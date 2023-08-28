using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MonitoringSystem.view
{
    public partial class Monthly : System.Web.UI.Page
    {
        public static string strConnectionString = ConfigurationManager.ConnectionStrings["sqlconnectionstring"].ConnectionString;


        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod(EnableSession = true)]
        public static string getReportMonthly(string date)
        {
            string data = "";
            try
            {
                using (SqlConnection con = new SqlConnection(strConnectionString))
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand
                    {
                        Connection = con,
                        CommandText = "mss_Rep_Monthly",
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.AddWithValue("@OnMonth", date);

                    DataTable dt = new DataTable();
                    SqlDataAdapter dataAdapter = new SqlDataAdapter(cmd);
                    dataAdapter.Fill(dt);
                    dataAdapter.Dispose();
                    cmd.Dispose();
                    con.Close();
                    var size = dt.Rows.Count;
                    JObject dataObject = new JObject();
                    JArray jArray = new JArray();
                    for (int i = 0; i < size; i++)
                    {
                        JObject row = new JObject();
                        row.Add("device", dt.Rows[i]["Device"].ToString());
                        row.Add("startdate", dt.Rows[i]["Start Date"].ToString());
                        row.Add("enddate", dt.Rows[i]["End Date"].ToString());
                        row.Add("kwh", dt.Rows[i]["Units"].ToString());
                        row.Add("kwh_hr", dt.Rows[i]["Units/Hr"].ToString());
                        row.Add("hours", dt.Rows[i]["Hours"].ToString());

                        jArray.Add(row);

                    }
                    dataObject.Add("data", jArray);

                    string JSONString = string.Empty;
                    JSONString = Convert.ToString(dataObject);
                    return JSONString;
                }
            }
            catch (System.Exception ex)
            {
                Console.WriteLine(ex.ToString());
                return "{}";
            }
        }
    }
}