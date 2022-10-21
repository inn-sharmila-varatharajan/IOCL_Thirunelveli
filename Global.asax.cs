using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;

namespace MonitoringSystem
{
    public class Global : HttpApplication
    {
        //void Application_Start(object sender, EventArgs e)
        //{
        //    // Code that runs on application startup
        //    RouteConfig.RegisterRoutes(RouteTable.Routes);
        //    BundleConfig.RegisterBundles(BundleTable.Bundles);
        //}

        protected void Application_Start(object sender, EventArgs e)
        {
            Application["usernames"] = new List<string>();
        }
        protected void Session_End(object sender, EventArgs e)
        {
            try
            {
                var usernames = (List<string>)Application["usernames"];
                if (Session["Username"] != null)
                {
                    usernames.Remove(Session["Username"].ToString());
                }
            }
            catch (Exception)
            {

            }
            try
            {
                if (Session["Username"] != null)
                {
                    string strConnectionString = ConfigurationManager.ConnectionStrings["sqlconnectionstring"].ConnectionString;
                    using (SqlConnection con = new SqlConnection(strConnectionString))
                    {
                        SqlCommand cmd = new SqlCommand();
                        cmd.Connection = con;
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        cmd.CommandText = "sp_LoginAuditTrail";
                        SqlParameter param1 = new SqlParameter("@Email", string.Empty);
                        SqlParameter param2 = new SqlParameter("@IpAddress", string.Empty);
                        SqlParameter param3 = new SqlParameter("@SessionId", Session.SessionID);
                        SqlParameter param4 = new SqlParameter("@SessionEndAt", DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                        cmd.Parameters.Add(param1);
                        cmd.Parameters.Add(param2);
                        cmd.Parameters.Add(param3);
                        cmd.Parameters.Add(param4);
                        con.Open();
                        cmd.ExecuteNonQuery();
                        cmd.Dispose();
                        con.Close();
                    }
                }
            }
            finally
            {
                Session.Clear();
            }
        }
    }
}