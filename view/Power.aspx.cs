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
    public partial class Power : System.Web.UI.Page
    {
        public static string strConnectionString = ConfigurationManager.ConnectionStrings["sqlconnectionstring"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod(EnableSession = true)]
        public static string getReport(string fromdate, string todate)
        {

            try
            {
                using (SqlConnection con = new SqlConnection(strConnectionString))
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand
                    {
                        Connection = con,
                        CommandText = "mss_Rep",
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.AddWithValue("@fromdate", fromdate);
                    cmd.Parameters.AddWithValue("@ToDate", todate);
                    cmd.Parameters.AddWithValue("@from", "pressure");


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
                        row.Add("Device", dt.Rows[i]["Device"].ToString());
                        row.Add("Phase", dt.Rows[i]["Phase"].ToString());
                        row.Add("Total_W", dt.Rows[i]["Total W"].ToString());
                        row.Add("Total_VA", dt.Rows[i]["Total kVA"].ToString());
                        row.Add("Total_VAR", dt.Rows[i]["Total VAR"].ToString());
                        row.Add("Avg_PF", dt.Rows[i]["Avg PF"].ToString());
                        row.Add("date", dt.Rows[i]["date"].ToString());


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