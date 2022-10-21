using Newtonsoft.Json;
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
    public partial class Dashboard : System.Web.UI.Page
    {
        public static string strConnectionString = ConfigurationManager.ConnectionStrings["sqlconnectionstring"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            GetEnergyList();
        }
        //[WebMethod(EnableSession = true)]
        public void GetEnergyList()
        {
            try
            {
                
                using (SqlConnection con = new SqlConnection(strConnectionString))
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand
                    {
                        CommandText = "sp_get_EnergyMeters",
                        Connection = con,
                        CommandType = CommandType.StoredProcedure
                    };
                    SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    sqlDataAdapter.Fill(dt);
                    sqlDataAdapter.Dispose();
                    EnergyListElement.DataSource = dt;
                    EnergyListElement.DataBind();
                    EnergyListElement.DataTextField = "Name";
                    EnergyListElement.DataValueField = "Identifier";
                    //EnergyListElement.DataValueField = "ID";
                    EnergyListElement.DataBind();
                    cmd.Dispose();
                    con.Close();
                    //var jsonStr = JsonConvert.SerializeObject(dt);
                    //return jsonStr;
                }
            }
            catch (Exception)
            {
                //return "[]";
            }
        }
        [WebMethod(EnableSession = true)]
        public static string GetEnergyMeterData(string MeterID)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(strConnectionString))
                {
                    SqlCommand cmd = new SqlCommand
                    {
                        Connection = con,
                        CommandText = "sp_get_EnergyMeterData",
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.AddWithValue("@MeterID", MeterID);
                    con.Open();
                    DataTable dt = new DataTable();
                    SqlDataAdapter dataAdapter = new SqlDataAdapter(cmd);
                    dataAdapter.Fill(dt);
                    dataAdapter.Dispose();
                    cmd.Dispose();
                    con.Close();
                    var size = dt.Rows.Count;
                    JObject phase = new JObject();

                    for (int i = 0; i < size; i++)
                    {

                        //jArray.Add(new JObject
                        //{
                        //    //{ "L", dt.Rows[i]["L"].ToString() },
                        //    { "VN", dt.Rows[i]["VN"].ToString() },
                        //    { "I", dt.Rows[i]["I"].ToString() },
                        //    { "Active Power", dt.Rows[i]["AP"].ToString() },
                        //    { "Apparent Power", dt.Rows[i]["APP"].ToString() },
                        //    { "Reactive Power ", dt.Rows[i]["RP"].ToString() },
                        //    { "PF", dt.Rows[i]["PF"].ToString() },
                        //    //{ "VL", dt.Rows[i]["VL"].ToString() },
                        //    //{ "AVL", dt.Rows[i]["AVL"].ToString() }
                        //});
                        JArray jArray = new JArray();
                        JObject vn = new JObject();
                        vn.Add("name", "VN");
                        vn.Add("value", dt.Rows[i]["VN"].ToString());
                        vn.Add("unit", "V");
                        jArray.Add(vn);

                        JObject I = new JObject();
                        I.Add("name", "I");
                        I.Add("value", dt.Rows[i]["I"].ToString());
                        I.Add("unit", "A");
                        jArray.Add(I);

                        JObject ap = new JObject();
                        ap.Add("name", "Active Power");
                        ap.Add("value", dt.Rows[i]["AP"].ToString());
                        ap.Add("unit", "W");
                        jArray.Add(ap);

                        JObject app = new JObject();
                        app.Add("name", "Apparent Power");
                        app.Add("value", dt.Rows[i]["APP"].ToString());
                        app.Add("unit", "VA");
                        jArray.Add(app);

                        JObject rp = new JObject();
                        rp.Add("name", "Reactive Power");
                        rp.Add("value", dt.Rows[i]["RP"].ToString());
                        rp.Add("unit", "VAR");
                        jArray.Add(rp);

                        JObject pf = new JObject();
                        pf.Add("name", "PF");
                        pf.Add("value", dt.Rows[i]["PF"].ToString());
                        pf.Add("unit", "");
                        jArray.Add(pf);

                        phase.Add(dt.Rows[i]["L"].ToString(), jArray);
                    }
                    JObject jObject = new JObject
                    {
                        {MeterID,  phase},
                    };
                    // return jObject;
                    string JSONString = string.Empty;
                    JSONString = Convert.ToString(jObject);
                    return JSONString;
                }
            }
            catch (System.Exception)
            {
                return "{}";
            }
        }
        [WebMethod(EnableSession = true)]
        public static string GetEnergyMeterSwitches()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(strConnectionString))
                {
                    SqlCommand cmd = new SqlCommand
                    {
                        Connection = con,
                        CommandText = "sp_get_EnergyMeterSwitches",
                        CommandType = CommandType.StoredProcedure
                    };
                    //cmd.Parameters.AddWithValue("@MeterID", MeterID);
                    con.Open();
                    DataTable dt = new DataTable();
                    SqlDataAdapter dataAdapter = new SqlDataAdapter(cmd);
                    dataAdapter.Fill(dt);
                    dataAdapter.Dispose();
                    cmd.Dispose();
                    con.Close();
                    var size = dt.Rows.Count;
                    JArray jArray = new JArray();
                    JObject jObject = new JObject();
                    string iMeterID = "";
                    for (int i = 0; i < size; i++)
                    {
                        if (i == 0) { iMeterID = dt.Rows[i]["MeterID"].ToString(); }
                        if (iMeterID != dt.Rows[i]["MeterID"].ToString())
                        {
                            jObject.Add(iMeterID, jArray);
                            jArray.Clear();
                            iMeterID = dt.Rows[i]["MeterID"].ToString();
                        }
                        jArray.Add(new JObject
                        {
                            { "SwitchID", dt.Rows[i]["SwitchID"].ToString() },
                            { "SwitchName", dt.Rows[i]["SwitchName"].ToString() }
                        });
                    }

                    string JSONString = string.Empty;
                    JSONString = Convert.ToString(jObject);
                    return JSONString;
                }
            }
            catch (System.Exception)
            {
                return "{}";
            }
        }
        [WebMethod(EnableSession = true)]
        public static string GetEMSTrips()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(strConnectionString))
                {
                    SqlCommand cmd = new SqlCommand
                    {
                        Connection = con,
                        CommandText = "sp_get_EMSTrips",
                        CommandType = CommandType.StoredProcedure
                    };
                    con.Open();
                    DataTable dt = new DataTable();
                    SqlDataAdapter dataAdapter = new SqlDataAdapter(cmd);
                    dataAdapter.Fill(dt);
                    dataAdapter.Dispose();
                    cmd.Dispose();
                    con.Close();
                    var size = dt.Rows.Count;
                    JArray jArray = new JArray();
                    JObject jObject = new JObject();
                    string iMeterID = "";
                    for (int i = 0; i < size; i++)
                    {
                        jArray.Add(new JObject
                        {
                            { "MeterID", dt.Rows[i]["MeterID"].ToString() },
                            { "SwitchID", dt.Rows[i]["SwitchID"].ToString() },
                        });
                    }

                    string JSONString = string.Empty;
                    JSONString = Convert.ToString(jArray);
                    return JSONString;
                }
            }
            catch (System.Exception)
            {
                return "{}";
            }
        }

        [WebMethod(EnableSession = true)]
        public static string GetEMSTripsAlerts()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(strConnectionString))
                {
                    SqlCommand cmd = new SqlCommand
                    {
                        Connection = con,
                        CommandText = "sp_get_EMSTripAlerts",
                        CommandType = CommandType.StoredProcedure
                    };
                    con.Open();
                    DataTable dt = new DataTable();
                    SqlDataAdapter dataAdapter = new SqlDataAdapter(cmd);
                    dataAdapter.Fill(dt);
                    dataAdapter.Dispose();
                    cmd.Dispose();
                    con.Close();
                    var size = dt.Rows.Count;
                    JArray jArray = new JArray();
                    JObject jObject = new JObject();
                    string iMeterID = "";
                    for (int i = 0; i < size; i++)
                    {
                        JObject EMSTAlert = new JObject();
                        EMSTAlert.Add("time", dt.Rows[i]["Time"].ToString());
                        EMSTAlert.Add("msg", dt.Rows[i]["Msg"].ToString());
                        EMSTAlert.Add("status", dt.Rows[i]["status"].ToString());
                        jArray.Add(EMSTAlert);

                    }

                    string JSONString = string.Empty;
                    JSONString = Convert.ToString(jArray);
                    return JSONString;
                }
            }
            catch (System.Exception)
            {
                return "{}";
            }
        }

    }
}