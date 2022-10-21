using EncryptAndDecrypt;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Net.Mime;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
namespace MonitoringSystem
{
    public partial class Login : System.Web.UI.Page
    {
        public static string strConnectionString = ConfigurationManager.ConnectionStrings["sqlconnectionstring"].ConnectionString;
        public static int nAttempts = Convert.ToInt32(ConfigurationManager.AppSettings["LockoutAttempts"]);

        static List<LoginCounter> objCounter = new List<LoginCounter>();
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public void btnSignin_Click(object sender, EventArgs e)
        {
            try
            {
                CheckLogin();
            }
            catch (Exception ex)
            {
                lblErrorMessage.Text = "Error in Signin " + ex.Message;
            }
        }

        private void CheckLogin()
        {
            if (Application == null)
            {
                lblErrorMessage.Text = $"Application variable missing! Please restart from IIS";
                return;
            }
            if (Application.AllKeys.Contains("usernames") == false)
            {
                lblErrorMessage.Text = $"Username missing in application variable";
                return;
            }
            var usernames = (List<string>)Application["usernames"];
            if (usernames == null)
            {
                lblErrorMessage.Text = $"Application variable nullable value exist";
                return;
            }
            //var LoginLimit = ConfigurationManager.AppSettings["LoginLimit"].ToString();
            //int count = 0;
            //if (usernames != null && string.IsNullOrEmpty(txtEmailid.Text) == false)
            //{
            //    try
            //    {
            //        count = usernames.Where(x => x.Trim().ToUpper().Equals(txtEmailid.Text.Trim().ToUpper())).ToList().Count;
            //    }
            //    catch
            //    {
            //        count = 0;
            //    }
            //}
            //if (count >= Convert.ToInt32(LoginLimit))
            //{
            //    lblErrorMessage.Text = $"{txtEmailid.Text}<br/><strong>Login limit reached!</strong>";
            //    return;
            //}
            var emailID = txtEmailid.Text;
            var pwd = txtPassword.Text;
            if (!string.IsNullOrEmpty(emailID))
            {
                if (!string.IsNullOrEmpty(pwd))
                {
                    string userIDPasswordValue = Encoding.Default.GetString(Convert.FromBase64String(pwd));
                    var credentials = userIDPasswordValue.Split(':');

                    if (credentials.Length == 2)
                    {
                        var dsetUserProfile = GetUserProfile(credentials[0].Replace("'", "").Trim(), credentials[1].Replace("'", "").Trim());
                        if (dsetUserProfile != null && dsetUserProfile.Tables.Count > 1 && dsetUserProfile.Tables[1].Rows.Count > 0)
                        {
                            if (dsetUserProfile.Tables[0].Rows[0]["Column1"].ToString() == "1")
                            {
                                usernames.Add(dsetUserProfile.Tables[1].Rows[0]["Username"].ToString());
                                Application["usernames"] = usernames;

                                Session.Clear();
                                if (ConfigurationManager.AppSettings.AllKeys.Contains("SessionTimeOut"))
                                {
                                    var SessionTimeOut = ConfigurationManager.AppSettings["SessionTimeOut"].ToString();
                                    Session.Timeout = Convert.ToInt32(SessionTimeOut);
                                }
                                Session["UserId"] = dsetUserProfile.Tables[1].Rows[0]["UserId"].ToString(); 
                                Session["Username"] = dsetUserProfile.Tables[1].Rows[0]["Username"].ToString();
                                Session["Fullname"] = dsetUserProfile.Tables[1].Rows[0]["Fullname"].ToString();
                                Session["UserRole"] = dsetUserProfile.Tables[1].Rows[0]["UserRole"].ToString();
                                Session["MobileNumber"] = dsetUserProfile.Tables[1].Rows[0]["MobileNumber"].ToString();
                                Session["LoggedIn"] = "1";

                                Session["SessionID"] = Session.SessionID;
                                //Audit Trail
                                //var ipAddress = Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
                                //if (string.IsNullOrEmpty(ipAddress))
                                //{
                                //    ipAddress = Request.ServerVariables["REMOTE_ADDR"];
                                //}
                                //using (SqlConnection con = new SqlConnection(strConnectionString))
                                //{
                                //    SqlCommand cmd = new SqlCommand();
                                //    cmd.Connection = con;
                                //    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                                //    cmd.CommandText = "sp_LoginAuditTrail";
                                //    SqlParameter param1 = new SqlParameter("@Email", credentials[0].Replace("'", "").Trim());
                                //    SqlParameter param2 = new SqlParameter("@IpAddress", ipAddress);
                                //    SqlParameter param3 = new SqlParameter("@SessionId", Session.SessionID);
                                //    cmd.Parameters.Add(param1);
                                //    cmd.Parameters.Add(param2);
                                //    cmd.Parameters.Add(param3);
                                //    con.Open();
                                //    cmd.ExecuteNonQuery();
                                //    con.Close();
                                //}
                                Response.Redirect("view/Dashboard.aspx", false);
                            }
                            else
                            {
                                lblErrorMessage.Text = "Invalid credentials";
                                Session["LoggedIn"] = "0";
                            }
                        }
                        else
                        {
                            if (IsAccountExists(credentials[0]) == true)
                            {
                                if (IsUserLocked(credentials[0]) == true)
                                {
                                    lblErrorMessage.Text = "User account locked. Please try again after 30 minutes.";
                                }
                                else
                                {
                                    SetAttempts(credentials[0]);
                                }
                            }
                            else
                            {
                                lblErrorMessage.Text = "Invalid email";
                            }

                            Session["LoggedIn"] = "0";
                        }
                    }
                    else
                    {
                        lblErrorMessage.Text = "Insufficient credentials";
                        Session["LoggedIn"] = "0";
                    }
                }
                else
                {
                    lblErrorMessage.Text = "Please enter password";
                    Session["LoggedIn"] = "0";
                }
            }
            else
            {
                lblErrorMessage.Text = "Please enter username";
                Session["LoggedIn"] = "0";
            }
        }

        public DataSet GetUserProfile(string pUsername, string pPassword)
        {

            try
            {
                string CreateEncrptAndDecpt = ConfigurationManager.AppSettings["CreateEncrptAndDecpt"];
                string SendEncptPass = pPassword;
                if (CreateEncrptAndDecpt == "true")
                {
                    var EncptPassword = ClsEncryptAndDecrypt.EncryptPassword(pPassword).ToString();
                    SendEncptPass = EncptPassword;
                }


                using (SqlConnection con = new SqlConnection(strConnectionString))
                {
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = con;
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = "x_Login";
                    // cmd.CommandText = "x_Login_Backup1";

                    SqlParameter param1 = new SqlParameter("@UserName", pUsername);
                    SqlParameter param2 = new SqlParameter("@Password", SendEncptPass);
                    cmd.Parameters.Add(param1);
                    cmd.Parameters.Add(param2);
                    con.Open();
                    DataSet dsTemp = new DataSet();
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        sda.Fill(dsTemp);
                        sda.Dispose();
                        con.Close();
                    }
                    return dsTemp;
                }
            }
            catch (Exception ex)
            {
                lblErrorMessage.Text = "Error in GetUserProfile " + ex.Message;
                return null;
            }
        }

        private bool IsAccountExists(string pUsername)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(strConnectionString))
                {
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = con;
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = "sp_IsUserExists";

                    cmd.Parameters.Clear();
                    cmd.Parameters.Add("@EmailID", SqlDbType.NVarChar).Value = pUsername;
                    cmd.Parameters.Add("@Exists", SqlDbType.Bit).Direction = ParameterDirection.Output;

                    con.Open();

                    cmd.ExecuteNonQuery();

                    bool Exists = Convert.ToBoolean(cmd.Parameters["@Exists"].Value.ToString());

                    con.Close();

                    return Exists;
                }
            }
            catch (Exception ex)
            {
                lblErrorMessage.Text = "Error in IsAccountExists" + ex.Message;
            }

            return false;
        }

        private bool IsUserLocked(string pUsername)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(strConnectionString))
                {
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = con;
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = "sp_IsUserLockedOut";

                    cmd.Parameters.Clear();
                    cmd.Parameters.Add("@EmailID", SqlDbType.NVarChar).Value = pUsername;
                    cmd.Parameters.Add("@Locked", SqlDbType.Bit).Direction = ParameterDirection.Output;

                    con.Open();

                    cmd.ExecuteNonQuery();

                    bool Exists = Convert.ToBoolean(cmd.Parameters["@Locked"].Value.ToString());

                    con.Close();

                    return Exists;
                }
            }
            catch (Exception ex)
            {
                lblErrorMessage.Text = "Error in IsUserLocked" + ex.Message;
            }

            return false;
        }

        private void SetAttempts(string pUsername)
        {
            var item = objCounter.Find(x => x.UserName.Equals(pUsername, StringComparison.CurrentCultureIgnoreCase));
            if (item == null)
            {
                objCounter.Add(new LoginCounter { UserName = pUsername, Attempts = 1 });
                lblErrorMessage.Text = String.Format("Invalid credentials, attempt = {0}/{1}", 1, nAttempts);
            }
            else
            {
                if (item.Attempts > nAttempts)
                {
                    SetAccountLockout(pUsername, true);

                    lblErrorMessage.Text = String.Format("ACCOUNT LOCKED. An Email has been sent to your account.", ++item.Attempts, nAttempts);
                }
                else if (item.Attempts <= nAttempts)
                {
                    item.Attempts++;
                    lblErrorMessage.Text = String.Format("Invalid credentials, attempt = {0}/{1}", item.Attempts, nAttempts);
                }
            }
        }
        private void SetAccountLockout(string pUsername, bool bLock)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(strConnectionString))
                {
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = con;
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = "sp_Lockout";

                    cmd.Parameters.Clear();
                    cmd.Parameters.Add("@EmailID", SqlDbType.NVarChar).Value = pUsername;
                    cmd.Parameters.Add("@Lock", SqlDbType.Bit).Value = bLock;

                    con.Open();

                    cmd.ExecuteNonQuery();

                    con.Close();

                    SendLockedOutEmail(pUsername);
                    //SendLockedOutEmail("sysadmin@aparinnosys.com");
                }
            }
            catch (Exception ex)
            {
                lblErrorMessage.Text = "Error in SetAccountLockout" + ex.Message;
            }
        }
        public void SendLockedOutEmail(string pEmail)
        {
            try
            {
                string samplemail = string.Empty;
                samplemail = "<p>Your account (" + pEmail + ") associated with Innoculate is locked. Please try to login again after 30 minutes.</p><br>" +
                    "<p>Please do not reply to this automated email.</p>";
                MailMessage mm = new MailMessage("alerter_2@aparinnosys.com", pEmail);
                mm.Subject = "Innoculate Account Locked";
                //mm.Body = samplemail;
                mm.IsBodyHtml = true;
                mm.AlternateViews.Add(AlternateView.CreateAlternateViewFromString(samplemail, null, MediaTypeNames.Text.Html));
                SmtpClient smtp = new SmtpClient();
                smtp.Host = "smtp.gmail.com";
                smtp.EnableSsl = true;
                NetworkCredential NetworkCred = new NetworkCredential();
                NetworkCred.UserName = "alerter_2@aparinnosys.com";
                NetworkCred.Password = "ncriot@2017";
                smtp.UseDefaultCredentials = true;
                smtp.Credentials = NetworkCred;
                smtp.Port = 587;
                smtp.Send(mm);

                lblErrorMessage.Text = "Email had been sent";
            }
            catch (Exception ex)
            {
                //log.Error("Error in SendEmail_Type " + ex.Message);
            }
        }
    }
    internal class LoginCounter
    {
        public String UserName { get; set; }
        public int Attempts { get; set; }
    }
}