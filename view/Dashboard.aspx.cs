
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using uPLibrary.Networking.M2Mqtt;
using uPLibrary.Networking.M2Mqtt.Messages;

namespace MonitoringSystem.view
{
    public partial class Dashboard : System.Web.UI.Page
    {
         
        public static string strConnectionString = ConfigurationManager.ConnectionStrings["sqlconnectionstring"].ConnectionString;
        public static MqttClient _mqttClient = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            GetEnergyList();

           

       }



     
        



        private static void ConnectToMqtt()
        {
            try
            {
                if (_mqttClient == null || _mqttClient.IsConnected == false)
                {
                    var clientId = Guid.NewGuid().ToString(); 
                    _mqttClient = new MqttClient("13.235.99.227", 1883, false, null, null, MqttSslProtocols.None);
                    _mqttClient.MqttMsgPublishReceived += MqttClient_MqttMsgPublishReceived;
                    _mqttClient.Connect(clientId, "ain-iocl-dev-usr", "@parinnosys123");
                }
            }
            catch (Exception)
            {
            }
        }
        private static void DisconnectMQTT()
        {
            if (_mqttClient != null)
            {
                if (_mqttClient.IsConnected)
                    _mqttClient.Disconnect();
                _mqttClient = null;
                System.Threading.Thread.Sleep(1000);
            }
        }


        private static void MqttClient_MqttMsgPublishReceived(object sender, MqttMsgPublishEventArgs e)
        {
            Console.WriteLine("Received = " + Encoding.UTF8.GetString(e.Message) + " on topic " + e.Topic);
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
        public static string getReport(string date)
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
                        CommandText = "mss_GetData",
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.AddWithValue("@Today", date);
                    cmd.Parameters.AddWithValue("@Device", "");

                    DataSet dt = new DataSet();
                    SqlDataAdapter dataAdapter = new SqlDataAdapter(cmd);
                    dataAdapter.Fill(dt);
                    dataAdapter.Dispose();
                    cmd.Dispose();
                    con.Close();
                    var size = dt.Tables[1].Rows.Count;
                    JObject dataObject = new JObject();
                    JArray jArray = new JArray();
                    for (int i = 0; i < size; i++)
                    {
                        JObject row = new JObject();
                        row.Add("Device", dt.Tables[1].Rows[i]["Device"].ToString());
                        row.Add("Phase", dt.Tables[1].Rows[i]["Phase"].ToString());
                        row.Add("Total_W", dt.Tables[1].Rows[i]["Total W"].ToString());
                        row.Add("Total_VA", dt.Tables[1].Rows[i]["Total kVA"].ToString());
                        row.Add("Total_VAR", dt.Tables[1].Rows[i]["Total VAR"].ToString());
                        row.Add("Avg_PF", dt.Tables[1].Rows[i]["Avg PF"].ToString());

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

        [WebMethod(EnableSession = true)]
         public static string GetEnergyMeterData(string MeterID,string Date)
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
                    cmd.Parameters.AddWithValue("@Today", Date);
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


                    var alertenergy = dt.Tables[0].Rows.Count;
                    JArray energykwh = new JArray();
                    for (int cnt = 0; cnt < alertenergy; cnt++)
                    {

                        JObject obj = new JObject();
                        obj.Add("todaykwh", dt.Tables[0].Rows[0]["Todaykwh"].ToString());
                        obj.Add("kwh", dt.Tables[0].Rows[0]["kWH"].ToString());
                        obj.Add("vah", dt.Tables[0].Rows[0]["VAh"].ToString());
                        obj.Add("varh", dt.Tables[0].Rows[0]["VARh"].ToString());
                        obj.Add("rtime", dt.Tables[0].Rows[cnt]["Time"].ToString());
                        energykwh.Add(obj);
                    }


                    var sizeFuelTank = dt.Tables[3].Rows.Count;
                    JArray fuelArray = new JArray();
                    for (int cnt = 0; cnt < sizeFuelTank; cnt++)
                    {

                        JObject obj = new JObject();
                        obj.Add("tank", dt.Tables[3].Rows[cnt]["Device 1"].ToString());
                        obj.Add("percentage", dt.Tables[3].Rows[cnt]["Pot Value"].ToString());
                        obj.Add("voltage", dt.Tables[3].Rows[cnt]["Voltage"].ToString());
                        obj.Add("time", dt.Tables[3].Rows[cnt]["TimeLevel"].ToString());
                        obj.Add("rtime", dt.Tables[3].Rows[cnt]["Time"].ToString());
                        obj.Add("alertlevel", dt.Tables[3].Rows[cnt]["alert_level"].ToString());
                        fuelArray.Add(obj);
                    }

                    var sizeWaterTank = dt.Tables[2].Rows.Count;
                    JArray waterArray = new JArray();
                    for (int cnt = 0; cnt < sizeWaterTank; cnt++)
                    {
                        
                        JObject obj = new JObject();
                        obj.Add("tank", dt.Tables[2].Rows[cnt]["Device"].ToString());
                        obj.Add("distance", dt.Tables[2].Rows[cnt]["Distance (m)"].ToString());
                        obj.Add("time", dt.Tables[2].Rows[cnt]["TimeLevel"].ToString());
                        obj.Add("rtime", dt.Tables[2].Rows[cnt]["Time"].ToString());
                        obj.Add("alertlevel", dt.Tables[2].Rows[cnt]["alert_level"].ToString());
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
                        obj.Add("time", dt.Tables[4].Rows[cnt]["TimeLevel"].ToString());
                        obj.Add("maxrpm", dt.Tables[4].Rows[cnt]["MaxRPM"].ToString());
                        obj.Add("Mtime", dt.Tables[4].Rows[cnt]["Time"].ToString());
                        obj.Add("min", dt.Tables[4].Rows[cnt]["Min"].ToString());
                        obj.Add("max", dt.Tables[4].Rows[cnt]["Max"].ToString());
                        obj.Add("timediff", dt.Tables[4].Rows[cnt]["timediff"].ToString());
                        firepumpArray.Add(obj);
                    }

                    var battery = dt.Tables[5].Rows.Count;
                    JArray batteryArray = new JArray();
                    for (int cnt = 0; cnt < battery; cnt++)
                    {

                        JObject obj = new JObject();
                        obj.Add("tank", dt.Tables[5].Rows[cnt]["Device"].ToString());
                        obj.Add("voltage", dt.Tables[5].Rows[cnt]["Voltage"].ToString());
                        obj.Add("time", dt.Tables[5].Rows[cnt]["TimeLevel"].ToString());
                        obj.Add("rtime", dt.Tables[5].Rows[cnt]["Remotetime"].ToString());
                        batteryArray.Add(obj);
                    }

                    var wfm = dt.Tables[6].Rows.Count;
                    JArray wfmarray = new JArray();
                    for (int cnt = 0; cnt < wfm; cnt++)
                    {

                        JObject obj = new JObject();
                        obj.Add("tank", dt.Tables[6].Rows[cnt]["Device"].ToString());
                        obj.Add("voltage", dt.Tables[6].Rows[cnt]["Voltage"].ToString());
                        obj.Add("time", dt.Tables[6].Rows[cnt]["TimeLevel"].ToString());
                        obj.Add("maxrpm", dt.Tables[6].Rows[cnt]["MRPM"].ToString());
                        obj.Add("Mtime", dt.Tables[6].Rows[cnt]["Mtime"].ToString());
                        obj.Add("Rtime", dt.Tables[6].Rows[cnt]["Time"].ToString());
                        wfmarray.Add(obj);
                    }
                    var firealert = dt.Tables[7].Rows.Count;
                    JArray firealertarray = new JArray();
                    for (int cnt = 0; cnt < firealert; cnt++)
                    {

                        JObject obj = new JObject();
                        obj.Add("tank", dt.Tables[7].Rows[cnt]["Device"].ToString());
                        obj.Add("start", dt.Tables[7].Rows[cnt]["Started"].ToString());
                        obj.Add("end", dt.Tables[7].Rows[cnt]["Ended"].ToString());
                        obj.Add("time", dt.Tables[7].Rows[cnt]["TimeLevel"].ToString());

                        firealertarray.Add(obj);
                    }

                    JObject jObject = new JObject
                {
                    {MeterID,  phase}, {"FUEL",  fuelArray}, {"WATER",  waterArray},{"FIREPUMP",firepumpArray},
                        {"BATTERY",batteryArray },{"WFM",wfmarray},{ "Alertenergy",energykwh},{"firealert",firealertarray}
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
                        CommandText = "Annunicator_Panel",
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
                    JObject dataObject = new JObject();
                    JArray jArray = new JArray();
                    for (int i = 0; i < size; i++)
                    {
                        JObject row = new JObject();
                        row.Add("name", dt.Rows[i]["_Device"].ToString());
                        row.Add("length", dt.Rows[i]["_Device_Length"].ToString());
                        row.Add("time", dt.Rows[i]["TimeLevel"].ToString());
                        row.Add("rtime", dt.Rows[i]["Remote_Time"].ToString());
                        jArray.Add(row);

                    }
                    dataObject.Add("data", jArray);

                    string JSONString = string.Empty;
                    JSONString = Convert.ToString(dataObject);
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
                        CommandText = "[sp_get_EMSTrips]",
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
                            { "MeterID", dt.Rows[i]["_Device"].ToString() },
                            { "Meterdesc", dt.Rows[i]["_Device_desc"].ToString() },

                            { "SwitchID", dt.Rows[i]["Channel_Name"].ToString() },
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
                        CommandText = "0",
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

        [WebMethod(EnableSession = true)]
        public static string GetPressureDatas(string date,float set,float record,string from,int start)
        {



            try
            {
                ConnectToMqtt();
                if (_mqttClient.IsConnected)
                {
                    _mqttClient.Subscribe(new[] { "AIN/IIOT/IOCLT/PTX/DATA" }, new[] { MqttMsgBase.QOS_LEVEL_AT_LEAST_ONCE });
                    _mqttClient.Subscribe(new[] { "AIN/IIOT/IOCLT/WFM/DATA" }, new[] { MqttMsgBase.QOS_LEVEL_AT_LEAST_ONCE });
                }

                if (_mqttClient != null && _mqttClient.IsConnected)
                    _mqttClient.Publish($"AIN/IIOT/IOCLT/PTX/RDATA", Encoding.UTF8.GetBytes("{get:1}"), MqttMsgBase.QOS_LEVEL_AT_LEAST_ONCE, false);
                _mqttClient.Publish($"AIN/IIOT/IOCLT/WFM/RDATA", Encoding.UTF8.GetBytes("{get:1}"), MqttMsgBase.QOS_LEVEL_AT_LEAST_ONCE, false);
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.ToString());
            }

           
            try
            {

                using (SqlConnection con = new SqlConnection(strConnectionString))
                {
                    SqlCommand cmd = new SqlCommand
                    {
                        Connection = con,
                        CommandText = "mss_getpressurevalues",
                        CommandType = CommandType.StoredProcedure,
                    };
                    cmd.Parameters.AddWithValue("@todate", date);
                    cmd.Parameters.AddWithValue("@set", set);
                    cmd.Parameters.AddWithValue("@record", record);
                    cmd.Parameters.AddWithValue("@from", from);
                    cmd.Parameters.AddWithValue("@value", start);
                    con.Open();
                    DataSet dt = new DataSet();
                    SqlDataAdapter dataAdapter = new SqlDataAdapter(cmd);
                    dataAdapter.Fill(dt);
                    dataAdapter.Dispose();
                    cmd.Dispose();
                    con.Close();
                    var size = dt.Tables[0].Rows.Count;
                    JObject dataObject = new JObject();
                    JArray jArray = new JArray();
                    for (int i = 0; i < size; i++)
                    {
                        JObject row = new JObject();
                        row.Add("set", dt.Tables[0].Rows[i]["setvalue"].ToString());
                        jArray.Add(row);

                    }
                    var size1 = dt.Tables[1].Rows.Count;
                    JArray recordArray = new JArray();
                    for (int i = 0; i < size1; i++)
                    {
                        JObject row1 = new JObject();
                        row1.Add("record", dt.Tables[1].Rows[i]["recordvalue"].ToString());
                        recordArray.Add(row1);

                    }

                    JObject jobject = new JObject { { "setvalue", jArray }, { "recordvalue", recordArray } };

                    //dataObject.Add("data", jArray);

                    string JSONString = string.Empty;
                    JSONString = Convert.ToString(jobject);
                    return JSONString;
                }
            }
            catch (System.Exception)
            {
                return "{}";
            }

        }



        [WebMethod(EnableSession = true)]
        public static string GetMQttDatas(string date)
        {



            try
            {
                ConnectToMqtt();
                //if (_mqttClient.IsConnected)
                //{
                //    _mqttClient.Subscribe(new[] { "AIN/IIOT/IOCLT/PTX/DATA" }, new[] { MqttMsgBase.QOS_LEVEL_AT_LEAST_ONCE });
                //    _mqttClient.Subscribe(new[] { "AIN/IIOT/IOCLT/WFM/DATA" }, new[] { MqttMsgBase.QOS_LEVEL_AT_LEAST_ONCE });
                //}

                if (_mqttClient != null && _mqttClient.IsConnected)
                    _mqttClient.Publish($"AIN/IIOT/IOCLT/PTX/RDATA", Encoding.UTF8.GetBytes("{\"get\":1}"), MqttMsgBase.QOS_LEVEL_AT_LEAST_ONCE, false);
                _mqttClient.Publish($"AIN/IIOT/IOCLT/WFM/RDATA", Encoding.UTF8.GetBytes("{\"get\":1}"), MqttMsgBase.QOS_LEVEL_AT_LEAST_ONCE, false);
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.ToString());
            }

            Thread.Sleep(10000);
            try
            {

                using (SqlConnection con = new SqlConnection(strConnectionString))
                {
                    SqlCommand cmd = new SqlCommand
                    {
                        Connection = con,
                        CommandText = "mss_getalivevalues",
                        CommandType = CommandType.StoredProcedure,
                    };
                    cmd.Parameters.AddWithValue("@time", date);
                    con.Open();
                    DataSet dt = new DataSet();
                    SqlDataAdapter dataAdapter = new SqlDataAdapter(cmd);
                    dataAdapter.Fill(dt);
                    dataAdapter.Dispose();
                    cmd.Dispose();
                    con.Close();
                    var size = dt.Tables[0].Rows.Count;
                    JObject dataObject = new JObject();
                    JArray jArray = new JArray();
                    for (int i = 0; i < size; i++)
                    {
                        JObject row = new JObject();
                        row.Add("PTX", dt.Tables[0].Rows[i]["PTX"].ToString());
                        jArray.Add(row);

                    }
                    var size1 = dt.Tables[1].Rows.Count;
                    JArray recordArray = new JArray();
                    for (int i = 0; i < size1; i++)
                    {
                        JObject row1 = new JObject();
                        row1.Add("WFM", dt.Tables[1].Rows[i]["WFM"].ToString());
                        recordArray.Add(row1);

                    }

                    JObject jobject = new JObject { { "PTX", jArray }, { "WFM", recordArray } };

                    //dataObject.Add("data", jArray);

                    string JSONString = string.Empty;
                    JSONString = Convert.ToString(jobject);
                    return JSONString;
                }
            }
            catch (System.Exception ex)
            {
                Console.WriteLine(ex.ToString());
                return "{}";
            }

        }

        [WebMethod(EnableSession = true)]
        public static string GetPercentageValue()
        {

            try
            {
                using (SqlConnection con = new SqlConnection(strConnectionString))
                {
                    SqlCommand cmd = new SqlCommand
                    {
                        Connection = con,
                        CommandText = "[mss_percent]",
                        CommandType = CommandType.StoredProcedure,
                    };
                    con.Open();
                    DataSet dt = new DataSet();
                    SqlDataAdapter dataAdapter = new SqlDataAdapter(cmd);
                    dataAdapter.Fill(dt);
                    dataAdapter.Dispose();
                    cmd.Dispose();
                    con.Close();
                    var size = dt.Tables[0].Rows.Count;
                    JObject dataObject = new JObject();
                    JArray jArray = new JArray();
                    for (int i = 0; i < size; i++)
                    {
                        JObject row = new JObject();
                        row.Add("value", dt.Tables[0].Rows[i]["value"].ToString());
                        row.Add("device", dt.Tables[0].Rows[i]["device"].ToString());
                        jArray.Add(row);

                    }
                    dataObject.Add("data", jArray);

                    string JSONString = string.Empty;
                    JSONString = Convert.ToString(dataObject);
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