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
    public partial class Settings : System.Web.UI.Page
    {
        public static string strConnectionString = ConfigurationManager.ConnectionStrings["sqlconnectionstring"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod(EnableSession = true)]
        public static string GetEnergyMeterData(string MeterID)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(strConnectionString))
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand
                    {
                        Connection = con,
                        CommandText = "mss_GetData",
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.AddWithValue("@Today", "2022-05-20");
                    cmd.Parameters.AddWithValue("@Device", MeterID);

                    DataSet dt = new DataSet();
                    SqlDataAdapter dataAdapter = new SqlDataAdapter(cmd);
                    dataAdapter.Fill(dt);
                    dataAdapter.Dispose();
                    cmd.Dispose();
                    con.Close();
                    var sizePhase = dt.Tables[0].Rows.Count;
                    JObject phase = new JObject();

                    for (int i = 0; i < sizePhase; i++)
                    {

                        JArray jArray = new JArray();
                        JObject vn = new JObject();
                        vn.Add("name", "VN");
                        vn.Add("value", dt.Tables[0].Rows[i]["Voltage"].ToString());
                        vn.Add("unit", "V");
                        jArray.Add(vn);

                        JObject I = new JObject();
                        I.Add("name", "I");
                        I.Add("value", dt.Tables[0].Rows[i]["Current"].ToString());
                        I.Add("unit", "A");
                        jArray.Add(I);

                        JObject ap = new JObject();
                        ap.Add("name", "Active Power");
                        ap.Add("value", dt.Tables[0].Rows[i]["Power"].ToString());
                        ap.Add("unit", "W");
                        jArray.Add(ap);

                        JObject app = new JObject();
                        app.Add("name", "Apparent Power");
                        app.Add("value", dt.Tables[0].Rows[i]["Real Power"].ToString());
                        app.Add("unit", "VA");
                        jArray.Add(app);

                        JObject rp = new JObject();
                        rp.Add("name", "Reactive Power");
                        rp.Add("value", dt.Tables[0].Rows[i]["Reactive Power"].ToString());
                        rp.Add("unit", "VAR");
                        jArray.Add(rp);

                        JObject pf = new JObject();
                        pf.Add("name", "PF");
                        pf.Add("value", dt.Tables[0].Rows[i]["Power Factor"].ToString());
                        pf.Add("unit", "");
                        jArray.Add(pf);

                        phase.Add(dt.Tables[0].Rows[i]["Phase"].ToString(), jArray);
                    }

                    var sizeFuelTank = dt.Tables[3].Rows.Count;
                    JArray fuelArray = new JArray();
                    for (int cnt = 0; cnt < sizeFuelTank; cnt++)
                    {

                        JObject obj = new JObject();
                        obj.Add("tank", dt.Tables[3].Rows[cnt]["Device 1"].ToString());
                        obj.Add("percentage", dt.Tables[3].Rows[cnt]["Pot Value"].ToString());
                        obj.Add("voltage", dt.Tables[3].Rows[cnt]["Voltage"].ToString());
                        obj.Add("time", dt.Tables[3].Rows[cnt]["Time"].ToString());
                        fuelArray.Add(obj);
                    }

                    var sizeWaterTank = dt.Tables[2].Rows.Count;
                    JArray waterArray = new JArray();
                    for (int cnt = 0; cnt < sizeWaterTank; cnt++)
                    {

                        JObject obj = new JObject();
                        obj.Add("tank", dt.Tables[2].Rows[cnt]["Device"].ToString());
                        obj.Add("distance", dt.Tables[2].Rows[cnt]["Distance (m)"].ToString());
                        obj.Add("time", dt.Tables[2].Rows[cnt]["Time"].ToString());
                        waterArray.Add(obj);
                    }

                    var firepump = dt.Tables[4].Rows.Count;
                    JArray firepumpArray = new JArray();
                    for (int cnt = 0; cnt < firepump; cnt++)
                    {

                        JObject obj = new JObject();
                        obj.Add("tank", dt.Tables[4].Rows[cnt]["Device"].ToString());
                        obj.Add("rpm", dt.Tables[4].Rows[cnt]["Rpm"].ToString());
                        obj.Add("direction", dt.Tables[4].Rows[cnt]["Direction"].ToString());
                        firepumpArray.Add(obj);
                    }

                    JObject jObject = new JObject
                {
                    {MeterID,  phase}, {"FUEL",  fuelArray}, {"WATER",  waterArray},{"FIREPUMP",firepumpArray}
                };
                    // return jObject;
                    string JSONString = string.Empty;
                    JSONString = Convert.ToString(jObject);
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