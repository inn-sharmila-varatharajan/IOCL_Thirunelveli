<%@ Page Title="" Language="C#" MasterPageFile="~/view/Admin.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="MonitoringSystem.view.Dashboard" %>

<asp:Content ID="head" ContentPlaceHolderID="Content_Header" runat="server">
</asp:Content>
<asp:Content ID="Dashboard" ContentPlaceHolderID="Content_Page" runat="server">
    <div class="container-fluid">
        <form id="form1" runat="server">
        <div class="row mb-5">
            <div class="col-lg-9">
                <div class="card">
                    <h5 class="card-header fw-bolder iocl-blue-text">
                        <i class="fas fa-lightbulb"></i> Energy Monitoring
                    </h5>
                    <div class="card-header bg-white border-0">
                        <span class="fw-bolder lh-lg iocl-blue-text">
                            <i class="fas fa-power-off"></i> Power Monitoring - <span id="energyElementPrint"></span>
          </span>
                        <div class="btn-group float-end">
                            <asp:DropDownList ID="EnergyListElement" onChange="loadPowerMonitoringData()" runat="server"> </asp:DropDownList> 
                        </div>
                    </div>
                    <div class="card-body px-0">
                        <div id="power_card">
                            <!-- card generate in JS -->
                        </div>
                      
                    </div>
                </div>
            </div>
            <div class="col-lg-3">
                <div class="card h-100">
                    <h5 class="card-header fw-bolder iocl-blue-text">
                        <i class="fas fa-lightbulb"></i> Alert - Energy Monitoring
                    </h5>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-3 pe-0 iocl-blue-bg fw-bold border-end">Time <span class="fs-75">(hrs)</span></div>
                            <div class="col-9 iocl-blue-bg fw-bold">Message</div>
                        </div>
                        <div class="row" id="power_Alert">
                            
                        </div>
                    </div>
                </div>
            </div>
        </div>

            <div class="row mb-5">
            <div class="col-lg-9">
                <div class="card">
                    <h5 class="card-header fw-bolder iocl-blue-text">
                        <i class="fas fa-lightbulb"></i> Annunciator</h5>
                    
                    <div class="card-body px-0">
                        <div class="w-100"></div>
                        <div class="card-header bg-white border-0">
                            <span class="fw-bolder lh-lg iocl-blue-text"><i class="fas fa-columns"></i>Panel Tripping
            Annunciator</span>
                        </div>
                        <div class="row justify-content-center mx-3" id="panel_card">
                            <!-- panel HTML generate by JS -->
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-3">
                <div class="card h-100">
                    <h5 class="card-header fw-bolder iocl-blue-text">
                        <i class="fas fa-lightbulb"></i> Alert - Annunicator
                    </h5>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-3 pe-0 iocl-blue-bg fw-bold border-end">Time <span class="fs-75">(hrs)</span></div>
                            <div class="col-9 iocl-blue-bg fw-bold">Message</div>
                        </div>
                        <div class="row" id="EMAlert">
                            
                        </div>
                        <div class="row" id="EM_Alert">
                            
                        </div>
                    </div>
                </div>
            </div>
        </div>
       
            <div class="row mb-5">
            <div class="col-lg-9">
                <div class="card">
                    <h5 class="card-header fw-bolder iocl-blue-text">
                        <i class="fas fa-battery-full"></i> Battery Level Monitoring
                    </h5>
                    <div class="card-body">
                        <div class="row justify-content-start" id="battery_monitoring">
                            <!-- fuel HTML Generate in JS -->
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-3">
                <div class="card h-100">
                    <h5 class="card-header fw-bolder iocl-blue-text">
                        <i class="fas fa-battery-full"></i> Alert - Battery Level
                    </h5>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-3 pe-0 iocl-blue-bg fw-bold border-end">Time <span class="fs-75">(hrs)</span></div>
                            <div class="col-9 iocl-blue-bg fw-bold">Message</div>
                        </div>
                        <div class="row" id="battery_alert"></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row mb-5">
            <div class="col-lg-9">
                <div class="card">
                    <h5 class="card-header fw-bolder iocl-blue-text">
                        <i class="fas fa-gas-pump"></i> Fuel Level Monitoring
                    </h5>
                    <div class="card-body">
                        <div class="row justify-content-start" id="fuel_monitoring">
                            <!-- fuel HTML Generate in JS -->
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-3">
                <div class="card h-100">
                    <h5 class="card-header fw-bolder iocl-blue-text">
                        <i class="fas fa-gas-pump"></i> Alert - Fuel Level
                    </h5>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-3 pe-0 iocl-blue-bg fw-bold border-end">Time <span class="fs-75">(hrs)</span></div>
                            <div class="col-9 iocl-blue-bg fw-bold">Message</div>
                        </div>
                        <div class="row" id="fuel_alert"></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row mb-5">
            <div class="col-lg-9">
                <div class="card">
                    <h5 class="card-header fw-bolder iocl-blue-text">
                        <i class="fas fa-tint"></i> Water Level Monitoring
                    </h5>
                    <div class="card-body">
                        <div class="row justify-content-start" id="water_monitoring">
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-3">
                <div class="card h-100">
                    <h5 class="card-header fw-bolder iocl-blue-text">
                        <i class="fas fa-tint"></i> Alert - Water Level
                    </h5>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-3 pe-0 iocl-blue-bg fw-bold border-end">Time <span class="fs-75">(hrs)</span></div>
                            <div class="col-9 iocl-blue-bg fw-bold">Message</div>
                        </div>
                        <div class="row" id="water_alert">

                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row mb-5">
            <div class="col-lg-9">
                <div class="card">
                    <h5 class="card-header fw-bolder iocl-blue-text">
                        <i class="fas fa-fire"></i> Fire Pump Monitoring
                    </h5>
                    <div class="card-body px-0">
                        <div class="row justify-content-start" id="fire_monitoring">
                        </div>
 </div>
                </div>
            </div>
            <div class="col-lg-3">
                <div class="card h-100">
                    <h5 class="card-header fw-bolder iocl-blue-text">
                        <i class="fas fa-fire"></i> Alert - Fire Pump
                    </h5>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-3 pe-0 iocl-blue-bg fw-bold border-end">Time <span class="fs-75">(hrs)</span></div>
                            <div class="col-9 iocl-blue-bg fw-bold">Message</div>
                        </div>
                        <div class="row" id="fire_alert">
                        </div>
                    </div>
                </div>
            </div>
        </div>

            <div class="row mb-5">
            <div class="col-lg-9">
                <div class="card">
                    <h5 class="card-header fw-bolder iocl-blue-text">
                        <i class="fas fa-water"></i> Water Flow Rate and Pressure Monitoring
                    </h5>
                    <div class="card-body px-0">
                        <div class="row justify-content-start" id="flow_monitoring">
                            
                        </div>  
                    </div>
                </div>
            </div>
            <div class="col-lg-3">
                <div class="card h-100">
                    <h5 class="card-header fw-bolder iocl-blue-text">
                        <i class="fas fa-water"></i> Alert - Water and Pressure 
                    </h5>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-3 pe-0 iocl-blue-bg fw-bold border-end">Time <span class="fs-75">(hrs)</span></div>
                            <div class="col-9 iocl-blue-bg fw-bold">Message</div>
                        </div>
                        <div class="row" id="flow_alert">
                        </div>
                    </div>
                </div>
            </div> 
        </div>
        </form>
    </div>
     <div id="loader"></div>
</asp:Content>
<asp:Content ID="scripts" ContentPlaceHolderID="Content_Script" runat="server">
    <script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
    <script src="../assets/script/svg-template.js"></script>
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script> 
 
        <script type="text/javascript"  src="https://cdn.datatables.net/1.10.2/js/jquery.dataTables.min.js"></script>
<script type="text/javascript"  src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>

<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/jquery-ui.min.js"></script>
    
    <script src="../Scripts/table2excel.js"></script>

<script src="../Scripts/tableHTMLExport.js"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.4.1/jspdf.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/2.3.5/jspdf.plugin.autotable.min.js"></script>
    <script>
        let docdefinition = ""; let json1 = [];
        var setary = [], recordary = [], flowary = [], pressureary = [], myArray = [], myrecordarray = [];
        let myjson = [];
        var chart, setvalue = 0, recordvalue = 0;
        var pager = new Pager('Table', 10);
        var spinner = $('#loader');

        $('#datechange').change(function () {
            var selecteddate = this.value;

            $('#reportdatas').innerHTML = "";
            GetItem(selecteddate);
        });
        function GetItem(selecteddate) {

            $.ajax({
                type: "POST",
                url: "Dashboard.aspx/getReport",
                data: JSON.stringify({ date: selecteddate }),
                contentType: "application/json; charset=utf-8",
                dataType: 'text',

            }).done(function (data) {
                let dataObj = JSON.parse(data);
                let dObj = JSON.parse(dataObj.d);
                let list = dObj.data;
                if (list.length == 0) {
                    document.getElementById("reportdatas").innerHTML = "No Datas"
                }

                if (list.length) {
                    let rowHTML = "";
                    for (let cnt = 0; cnt < list.length; cnt++) {
                        let obj = list[cnt];
                        let row = `<tr>
                                <td>${obj.Device}</td><td>${obj.Phase}</td>
                                <td>${obj.Total_W}</td ><td>${obj.Total_VA}</td>
                                <td>${obj.Total_VAR}</td><td>${obj.Avg_PF}</td>
                            </tr>`;
                        rowHTML += row;
                    }
                    document.getElementById("reportdatas").innerHTML = rowHTML
                    document.getElementById("reportdatas1").innerHTML = rowHTML



                    pager.init();
                    pager.showPageNav('pager', 'pageNavPosition');
                    pager.showPage(1);
                }

            });

        };

        function pdf() {
            var doc = new jsPDF(this.pdfOrientation, 'pt', this.pdfFormat);
            var res = doc.autoTableHtmlToJson(document.getElementById("Table1"));
            doc.autoTable(res.columns, res.data, {
                margin: { top: 40, horizontal: 10 }, startY: false, theme: 'grid', pageBreak:
                    'always', tableWidth: 'auto', columnWidth: 'wrap', showHeader: 'everyPage',
                tableLineColor: 200, tableLineWidth: 0,
                columnStyles: {
                    0: { columnWidth: 'auto' }, 1: { columnWidth: 'auto' }, 2: { columnWidth: 'auto' }, 3:
                        { columnWidth: 'auto' }, 4: { columnWidth: 'auto' },
                    5: { columnWidth: 'auto' }, 6: { columnWidth: 'auto' }, 7: { columnWidth: 'auto' }, 8:
                        { columnWidth: 'auto' }
                },
                headerStyles: { theme: 'grid' },
                styles: {
                    overflow: 'linebreak', columnWidth: 'wrap', font: 'arial', fontSize: 10,
                    cellPadding: 8, overflowColumns: 'linebreak'
                },
            });
            doc.save('Report.pdf');
        }


        function exportReportToExcel() {
            $("#Table").table2excel({
                filename: "Report.xls"
            });

        }
        function tableToCSV() {

            // Variable to store the final csv data
            var csv_data = [];

            // Get each row data
            var rows = document.getElementsByTagName('tr');
            for (var i = 0; i < rows.length; i++) {

                // Get each column data
                var cols = rows[i].querySelectorAll('td,th');

                // Stores each csv row data
                var csvrow = [];
                for (var j = 0; j < cols.length; j++) {

                    // Get the text data of each cell
                    // of a row and push it to csvrow
                    csvrow.push(cols[j].innerHTML);
                }

                // Combine each column value with comma
                csv_data.push(csvrow.join(","));
            }

            // Combine each row data with new line character
            csv_data = csv_data.join('\n');

            // Call this function to download csv file 
            downloadCSVFile(csv_data);

        }

        function downloadCSVFile(csv_data) {

            // Create CSV file object and feed
            // our csv_data into it
            CSVFile = new Blob([csv_data], {
                type: "text/csv"
            });

            // Create to temporary link to initiate
            // download process
            var temp_link = document.createElement('a');

            // Download csv file
            temp_link.download = "Report.csv";
            var url = window.URL.createObjectURL(CSVFile);
            temp_link.href = url;

            // This link should not be displayed
            temp_link.style.display = "none";
            document.body.appendChild(temp_link);

            // Automatically click the link to
            // trigger download
            temp_link.click();
            document.body.removeChild(temp_link);
        }




        function Pager(tableName, itemsPerPage) {

            this.tableName = tableName;

            this.itemsPerPage = itemsPerPage;

            this.currentPage = 1;

            this.pages = 0;

            this.inited = false;

            this.showRecords = function (from, to) {

                var rows = document.getElementById(tableName).rows;

                // i starts from 1 to skip table header row

                for (var i = 1; i < rows.length; i++) {

                    if (i < from || i > to)

                        rows[i].style.display = 'none';

                    else

                        rows[i].style.display = '';

                }

            }

            this.showPage = function (pageNumber) {

                if (!this.inited) {

                    alert("not inited");

                    return;

                }

                var oldPageAnchor = document.getElementById('pg' + this.currentPage);

                oldPageAnchor.className = 'pg-normal';

                this.currentPage = pageNumber;

                var newPageAnchor = document.getElementById('pg' + this.currentPage);

                newPageAnchor.className = 'pg-selected';

                var from = (pageNumber - 1) * itemsPerPage + 1;

                var to = from + itemsPerPage - 1;

                this.showRecords(from, to);

            }

            this.prev = function () {

                if (this.currentPage > 1)

                    this.showPage(this.currentPage - 1);

            }

            this.next = function () {

                if (this.currentPage < this.pages) {

                    this.showPage(this.currentPage + 1);

                }

            }

            this.init = function () {

                var rows = document.getElementById(tableName).rows;

                var records = (rows.length - 1);

                this.pages = Math.ceil(records / itemsPerPage);

                this.inited = true;

            }

            this.showPageNav = function (pagerName, positionId) {

                if (!this.inited) {

                    alert("not inited");

                    return;

                }

                var element = document.getElementById(positionId);

                var pagerHtml = '<span onclick="' + pagerName + '.prev();" class="pg-normal"> « Prev </span> ';

                for (var page = 1; page <= this.pages; page++)

                    pagerHtml += '<span id="pg' + page + '" class="pg-normal" onclick="' + pagerName + '.showPage(' + page + ');">' + page + '</span> ';

                pagerHtml += '<span onclick="' + pagerName + '.next();" class="pg-normal"> Next »</span>';

                element.innerHTML = pagerHtml;

            }

        }

    </script>

    <style type="text/css">
        #loader {
  display: none;
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  width: 100%;
  background: rgba(0,0,0,0.75) url(../assets/loader.gif) no-repeat center center;
  z-index: 10000;
}


.paging-nav {
  text-align: right;
  padding-top: 2px;
}

.paging-nav a {
  margin: auto 1px;
  text-decoration: none;
  display: inline-block;
  padding: 1px 7px;
  background: #03174f;
  color: white;
  border-radius: 3px;
}

.paging-nav .selected-page {
  background: #03174f;
  font-weight: bold;
}

.paging-nav,
#Table {
  margin: 0 auto;
  font-family: Arial, sans-serif;
}
.divpadding{
   
    
    border: 3px solid green;
}
</style>

    <style type="text/css">
        	


.left{
    margin-left:30px;
}
input.err
{
margin-left:120px;

}
.pg-normal {
color: #ffffff;
font-size: 15px;
cursor: pointer;
background: #03174f;
padding: 2px 4px 2px 4px;
}

.pg-selected {
color: #000;
font-size: 15px;
background: #ffffff;
padding: 2px 4px 2px 4px;
}

table.yui {
font-family:arial;
border-collapse:collapse;
border: solid 3px #03174f;
font-size:small;
}

table.yui td {
padding: 5px;
border-right: solid 1px #03174f;
}






</style>

   
    <script>

        //// let series_1 = [75];
        //var chart1 = new ApexCharts(document.querySelector("#fire_pump_1"), radial_options_1).render();
        //var chart2 = new ApexCharts(document.querySelector("#fire_pump_2"), radial_options_2).render();
        //var chart3 = new ApexCharts(document.querySelector("#fire_pump_3"), radial_options_3).render();
        //new ApexCharts(document.querySelector("#flow_chart"), line_options_1).render();
        //new ApexCharts(document.querySelector("#pressure_chart"), line_options_2).render();


        let fuelMonitoing = (fuelData) => {
            let fuelHTML = '', fuelalertHtml = '', tanknam = '';
            var currentdate = new Date();
            var datetime =
                currentdate.getHours() + ":"
                + currentdate.getMinutes();
            for (let cnt = 0; cnt < fuelData.length; cnt++) {
                let item = fuelData[cnt];
                item.value = parseInt(item["percentage"]) / 100;

                var hh = item.tank;
                if (hh.trim() == "DGBUFFER") {
                    tanknam = "DG Buffer";
                }
                else if (hh.trim() == "FIREPUMPBUFFER") {
                    tanknam = "FirePump Buffer";

                }
                else if (hh.trim() == "MAINBUFFER") {
                    tanknam = "Main Buffer";

                }
                else { tanknam = item.tank; }
                if (item.tank != 'WFM' || item.tank != 'PTX') {
                    let minute = item.time;
                    if (minute > 60) {
                        fuelalertHtml += `<div style="color:red" class="col-4 pe-0">${item.rtime}</div>
                            <div  style="color:red" class="col-8">${tanknam} - offline</div>`;

                    }
                    else if (item.voltage < 210) {
                        fuelalertHtml += `<div class="col-4 pe-0">${item.rtime}</div>
                            <div class="col-8">${tanknam} - Low</div>`;
                    }
                    let levels = "";

                    if (minute > 60) {
                        item.value = 2;
                        levels = "0";
                    }

                    else {
                        item.value = Math.round(item["percentage"] / 5) * 5 / 100;

                        levels = Math.round((item.voltage / 10) * 10);
                        if (item.voltage < 50) {
                            levels = "Empty";
                        }
                        else if (levels != 0) {
                            levels = Math.round(levels / 10) * 10 - 10 + "-" + Math.round(levels / 10) * 10 + " mm"
                        }
                        else {
                            levels = "Empty";
                        }
                    }
                    if (item.value > 1) {
                        item.value = 1;
                    }

                    if (minute > 60) {
                        fuelHTML += `
                <div class="col-sm-6 col-md-4 col-lg-3">
                    <div class="card mb-3">
                        <div class="row g-0">
                            <div class="col-12 text-center iocl-blue-text fw-bold">
                                <strong>${tanknam}</strong>
                                </div>
                                <div class="col-12 text-center mt-3">
                                   ${fuelSVG(item.value, item.tank)}
                                    </div>
                    
                           <div class="col-12">
                                        <div class="card-body">
      <div class="d-flex justify-content-center">
                    
                                              <strong> </strong>
                                                <strong></strong >
                    &nbsp;&nbsp;
                                            </div>

                                        </div>
                                    </div>
                  
                                </div>
                            </div>
                        </div>
                        `;
                    }
                    else {
                        fuelHTML += `
                <div class="col-sm-6 col-md-4 col-lg-3">
                    <div class="card mb-3">
                        <div class="row g-0">
                            <div class="col-12 text-center iocl-blue-text fw-bold">
                                <strong>${tanknam}</strong>
                                </div>
                                <div class="col-12 text-center mt-3">
                                   ${fuelSVG(item.value, item.tank)}
                                    </div>
                    
                           <div class="col-12">
                                        <div class="card-body">
      <div class="d-flex justify-content-center">
                    
                                                <strong>Level Range: </strong>
                                                <strong>&nbsp; ${levels}</strong >
                    
                                            </div>

                                        </div>
                                    </div>
                    
                                </div>
                            </div>
                        </div>
                        `;
                    }
                }
            }
            document.getElementById("fuel_monitoring").innerHTML = fuelHTML;
            document.getElementById("fuel_alert").innerHTML = fuelalertHtml;

        }

        let batteryMonitoring = (batterydata) => {
            let batteryHTML = '', batteryalertHtml = '', tanknam = '';

            var currentdate = new Date();
            var datetime =
                currentdate.getHours() + ":"
                + currentdate.getMinutes();
            for (let cnt = 0; cnt < batterydata.length; cnt++) {
                let item = batterydata[cnt];
                // item.value = parseInt(item["percentage"]) / 100;
                var hh = item.tank;


                let minute = item.time;

                if (minute > 60) {
                    batteryalertHtml += `<div style="color:red" class="col-4 pe-0">${item.rtime}</div>
                            <div style="color:red" class="col-8">${item.tank} - offline</div>`;
                }
                else if (item.voltage == 0 && minute > 60) {
                    batteryalertHtml += `<div style="color:red" class="col-4 pe-0">${item.rtime}</div>
                            <div style="color:red" class="col-8">${item.tank} - offline</div>`;
                }

                else if (item.voltage == 0 && minute < 60) {
                    batteryalertHtml += `<div style="color:red" class="col-4 pe-0">${item.rtime}</div>
                            <div style="color:red" class="col-8">${item.tank} - voltage 0</div>`;
                }
                else if (item.voltage < 18) {
                    batteryalertHtml += `<div style="color:red" class="col-4 pe-0">${item.rtime}</div>
                            <div style="color:red" class="col-8">${item.tank} - voltage low</div>`;

                }

                let levels = "";

                if (minute > 60) {
                    item.value = 2;
                    levels = "0";
                    item.voltage = 0;
                }


                if (minute > 60) {
                    batteryHTML += `
                <div class="col-sm-12 col-md-6 col-lg-3">
                    <div class="card mb-3">
                        <div class="row g-0">
                            <div class="col-12 text-center iocl-blue-text fw-bold">
                                <strong>${item.tank}</strong>
                                </div>
                                <div class="col-12 text-center mt-3">
                                   ${batterySVG(item.voltage)}
                                    </div>
                                    <div class="col-12">
                                        <div class="card-body">
      <div class="d-flex justify-content-center">
                                                &nbsp;&nbsp;
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        `;
                }
                else {
                    batteryHTML += `
                <div class="col-sm-12 col-md-6 col-lg-3">
                    <div class="card mb-3">
                        <div class="row g-0">
                            <div class="col-12 text-center iocl-blue-text fw-bold">
                                <strong>${item.tank}</strong>
                                </div>
                                <div class="col-12 text-center mt-3">
                                   ${batterySVG(item.voltage)}
                                    </div>
                                    <div class="col-12">
                                        <div class="card-body">
      <div class="d-flex justify-content-center">
                                                <strong>Voltage :</strong>
                                                <strong>&nbsp;${item.voltage}V</strong >
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        `;
                }
            }

            document.getElementById("battery_monitoring").innerHTML = batteryHTML;
            document.getElementById("battery_alert").innerHTML = batteryalertHtml;

        }

        let waterMonitoring = (waterData) => {
            let waterHTML = '', wateralertHtml = '', tanknam = '';
            var currentdate = new Date();
            var datetime =
                currentdate.getHours() + ":"
                + currentdate.getMinutes();

            if (!waterData.length) {
                return;
            }

            for (let cnt = 0; cnt < waterData.length; cnt++) {
                let item = waterData[cnt];
                item.value = parseInt(item.distance * 10) / 100;
               // alert(item.value);
                var hh = item.tank;
                if (hh.trim() == "TANK1") {
                    tanknam = "Fire Water Tank1";
                }
                else if (hh.trim() == "TANK2") {
                    tanknam = "Fire Water Tank2";

                }
                else { tanknam = "Fire Water Tank3"; }
                let levels = "";

                if (item.time > 60) {
                    item.value = 2;
                }
                else {
                   // item.value = Math.round(item["distance"] ) ;
                   // alert(item.value);
                }
                //if (item.distance < 1) {
                //    item.value = 0;
                //    levels = "0 to 100";
                //}
                //else if (item.distance < 3) {
                //    item.value = 25 / 100;
                //    levels = "101 to 300";
                //}
                //else if (item.distance < 5) {
                //    item.value = 50 / 100;
                //    levels = "301 to 500";
                //}
                //else if (item.distance < 7) {
                //    item.value = 75 / 100;
                //    levels = "501 to 700";
                //}
                //else {
                //    item.value = 100 / 100;
                //    levels = "701 to 1000";
                //}
                if (item.time > 60) {
                    wateralertHtml += `<div style="color:red" class="col-4 pe-0"> ${item.rtime}</div>
                            <div style="color:red" class="col-8">${tanknam} - offline</div>`;
                }

                else if (item.distance < item.alertlevel) {
                    wateralertHtml += `<div class="col-4 pe-0"> ${item.rtime}</div>
                            <div class="col-8">${tanknam} - Low</div>`;
                };
                if (item.time > 60) {
                    waterHTML += `
                <div
                  class="col-sm-6 col-md-4 col-lg-3">
                  <div class="card mb-3">
                    <div class="row g-0">
                      <div class="col-12 text-center iocl-blue-text fw-bold">
                        <strong>${tanknam}</strong>
                      </div>
                      <div class="col-12 text-center mt-3">
                        ${waterSVG(item.value, item.tank)}
                      </div>

                       <div class="col-12">
                        <div class="card-body">
                          <div class="d-flex justify-content-center">
&nbsp;&nbsp;
                            </div>
                        
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                `;
                } else {
                    waterHTML += `
                <div
                  class="col-sm-6 col-md-4 col-lg-3">
                  <div class="card mb-3">
                    <div class="row g-0">
                      <div class="col-12 text-center iocl-blue-text fw-bold">
                        <strong>${tanknam}</strong>
                      </div>
                      <div class="col-12 text-center mt-3">
                        ${waterSVG(item.value, item.tank)}
                      </div>

                       <div class="col-12">
                        <div class="card-body">
                          <div class="d-flex justify-content-center">
                            <strong>Level :</strong>
                            <strong>&nbsp;${item.distance} m</strong>
                          </div>
                        
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                `;
                }
            }
            document.getElementById("water_monitoring").innerHTML = waterHTML;
            document.getElementById("water_alert").innerHTML = wateralertHtml;

        }




        let firepumpMonitoring = (fireData, firealert) => {
            let fireHTML = '', firealertHtml = '', tanknam = '';
            var color1 = '', color2 = '', color3 = '', text1 = '', text2 = '', text3 = '', color4 = '', text4 = '';
            var currentdate = new Date();
            var datetime =
                currentdate.getHours() + ":"
                + currentdate.getMinutes();

            var color1 = '';
            if (!fireData.length) {
                return;
            }


            for (let cnt = 0; cnt < fireData.length; cnt++) {
                let item = fireData[cnt];
                var hh = item.tank;
                if (hh.trim() == "FIREENGINE1") {
                    tanknam = "Fire Engine1";
                }
                else if (hh.trim() == "FIREENGINE2") {
                    tanknam = "Fire Engine2";

                }
                else if (hh.trim() == "FIREENGINE3") {
                    tanknam = "Fire Engine3";

                }

                if (item.time > 60) {
                    firealertHtml += `<div style="color:red;" class="col-4 pe-0">${item.Mtime}</div>
                            <div style="color:red;" class="col-8">${tanknam} - offline</div>`;

                }
                else if (item.direction == 0) {

                    firealertHtml += `<div class="col-4 pe-0">${datetime}</div>
                            <div style="color:red" class="col-8">${tanknam} - Reverse Flow</div>`;
                }


                else if (item["min"] == "") {
                    firealertHtml += `<div class="col-4 pe-0"></div>
                            <div style="color:red" class="col-8 font-color:red">${tanknam}- Not Operated </div>`;
                }
                else if (item["maxrpm"] > 4000) {
                    firealertHtml += `<div class="col-4 pe-0"></div>
                            <div style="color:red" class="col-8 font-color:red">${tanknam}- Not Operated </div>`;
                }
                fireHTML += `
                         
                        <div class="col-lg-3 text-center">
                            <strong>${tanknam}</strong>
                            <div id="fire_pump_${cnt + 1}"></div>
                            <!-- <apexchart type="radialBar" :options="options_1" :series="series_1"></apexchart> -->
                            <strong>${item.rpm} Rpm</strong>
                        </div>
</div>
            `;

            }
            if (firealert.length != 0) {
                for (let k = 0; k < firealert.length; k++) {
                    var time = firealert[k]["start"].split(" ");
                    var time1 = firealert[k]["end"].split(" ");
                    if (firealert[k]["time"] < 60) {
                        firealertHtml += `<div class="col-3 pe-0">${firealert[k]["start"] + "-" + firealert[k]["end"]}</div>
                            <div class="col-9">${firealert[k]["tank"]}- Operated </div>`;
                    }
                };
            }
            document.getElementById("fire_monitoring").innerHTML = fireHTML;
            document.getElementById("fire_alert").innerHTML = firealertHtml;

            if (fireData[0]['direction'] == 2) {
                color1 = '#8fed01';
                text1 = "";
            }
            else if (fireData[0]['direction'] == 1) {
                color1 = '#8fed01';
                text1 = "F";
            }
            else if (fireData[0]['direction'] == 0) {
                color1 = '#D32F2F';
                text1 = "R";
            }
            if (fireData[1]['direction'] == 2) {
                color2 = '#8fed01';
                text2 = "";
            }
            else if (fireData[1]['direction'] == 1) {
                color2 = '#8fed01';
                text2 = "F";
            }
            else if (fireData[1]['direction'] == 0) {
                color2 = '#D32F2F';
                text2 = "R";
            }
            if (fireData[2]['direction'] == 2) {
                color3 = '#8fed01';
                text3 = "";
            }
            else if (fireData[2]['direction'] == 1) {
                color3 = '#8fed01';
                text3 = "F";
            }
            else if (fireData[2]['direction'] == 0) {
                color3 = '#D32F2F';
                text3 = "R";
            }

            callchart1(100, fireData[0]['time'] > 5 ? '#efefef' : color1, fireData[0]['direction'] == 0 ? "R" : "F", text1);
            callchart2(100, fireData[1]['time'] > 5 ? '#efefef' : color2, fireData[1]['direction'] == 0 ? "R" : "F", text2);
            callchart3(100, fireData[2]['time'] > 5 ? '#efefef' : color3, fireData[2]['direction'] == 0 ? "R" : "F", text3);

        }

        function initDashboard() {
            // powerMonitoring(powerArr);
            // panelAnnunciator();
            // fuelMonitoing();
            // waterMonitoring();
        }

        initDashboard();

        function callchart1(val1, val2, val3) {
            let radial_1 = {
                chart: {
                    height: 280,
                    type: "radialBar",
                },
                series: [val1], // replace values
                colors: [val2],
                labels: [val3],
                plotOptions: {
                    radialBar: {
                        startAngle: -135,
                        endAngle: 135,
                        track: {
                            background: "#EEEEEE",
                            startAngle: -135,
                            endAngle: 135,
                        },
                        dataLabels: {
                            name: {
                                show: false,
                                fontSize: "25px",
                                color: val2,
                            },
                            value: {
                                fontSize: "30px",
                                show: false,
                                formatter: function (val) {
                                    return val;
                                },
                            },
                        },
                    },
                },

            };
            new ApexCharts(document.querySelector("#fire_pump_1"), radial_1).render();

        }
        function callchart2(val1, val2, val3) {
            let radial_1 = {
                chart: {
                    height: 280,
                    type: "radialBar",
                },
                series: [val1], // replace values
                colors: [val2],
                labels: [val3],
                plotOptions: {
                    radialBar: {
                        startAngle: -135,
                        endAngle: 135,
                        track: {
                            background: "#EEEEEE",
                            startAngle: -135,
                            endAngle: 135,
                        },
                        dataLabels: {
                            name: {
                                show: false,
                                fontSize: "25px",
                                color: val2,
                            },
                            value: {
                                fontSize: "30px",
                                show: false,
                                formatter: function (val) {
                                    return val;
                                },
                            },
                        },
                    },
                },

            };
            new ApexCharts(document.querySelector("#fire_pump_2"), radial_1).render();

        }
        function callchart3(val1, val2, val3) {
            let radial_3 = {
                chart: {
                    height: 280,
                    type: "radialBar",
                },
                series: [val1],
                labels: [val3],
                plotOptions: {
                    radialBar: {
                        startAngle: -135,
                        endAngle: 135,
                        track: {
                            background: "#EEEEEE",
                            startAngle: -135,
                            endAngle: 135,
                        },
                        dataLabels: {
                            name: {
                                show: false,
                                fontSize: "25px",
                                color: val2,
                                offsetY: -10,
                            },
                            value: {
                                fontSize: "30px",
                                show: false,
                                color: "#D32F2F",
                                formatter: function (val) {
                                    return val;
                                },
                            },
                        },
                    },
                },
                colors: [val2],
            };
            new ApexCharts(document.querySelector("#fire_pump_3"), radial_3).render();

        }
        function callchart4(val1, val2, val3) {
            let radial_4 = {
                chart: {
                    height: 280,
                    type: "radialBar",
                },
                series: [val1],
                labels: [val3],
                plotOptions: {
                    radialBar: {
                        startAngle: -135,
                        endAngle: 135,
                        track: {
                            background: "#EEEEEE",
                            startAngle: -135,
                            endAngle: 135,
                        },
                        dataLabels: {
                            name: {
                                show: false,
                                fontSize: "25px",
                                color: val2,
                                offsetY: -10,
                            },
                            value: {
                                fontSize: "30px",
                                show: false,
                                color: "#D32F2F",
                                formatter: function (val) {
                                    return val;
                                },
                            },
                        },
                    },
                },
                colors: [val2],
            };
            new ApexCharts(document.querySelector("#fire_pump_4"), radial_4).render();

        }

        // ajax method write
    </script>
    <script>
        var today = '', start = 0, getdatetime = "", timing=30000,record=0;

        var currentdate = new Date();
        var datetime =
            currentdate.getHours() + ":"
            + currentdate.getMinutes();
        $(document).ready(function () {

            var now = new Date();

            var day = ("0" + now.getDate()).slice(-2);
            var month = ("0" + (now.getMonth() + 1)).slice(-2);
            getdatetime = (now.getFullYear() + "-" + (month) + "-" + (day) + " " + now.getHours() + ":" + ("0" + now.getMinutes()).slice(-2) + ":" + ("0" + now.getSeconds()).slice(-2));
            today = now.getFullYear() + "-" + (month) + "-" + (day);

        });

        const powerMonitoring = (objData) => {
            let powerHTML = "";
            /*  objData["sum"] = [
                  { name: "Today's kWh", value: "2562", unit: "" },
                  { name: "Wh", value: "2473", unit: "" },
                  { name: "VAh", value: "117", unit: "" },
                  { name: "VARh", value: "2473", unit: "" },
              ];*/
            document.getElementById("power_card").innerHTML = "";
            for (let phase in objData) {

                let border = "border-secondary";
                if (phase == "L1RED") {
                    border = "border-danger";
                } else if (phase == "L2YELLOW") {
                    border = "border-warning";
                } else if (phase == "L3BLUE") {
                    border = "border-primary";
                }


                powerHTML += `<div class="row row-cols-1 row-cols-sm-2 row-cols-md-4 row-cols-lg-6 g-1 m-1 border-start border-5 ${border}">`;
                for (let cnt = 0; cnt < objData[phase].length; cnt++) {
                    let item = objData[phase][cnt];
                    powerHTML += `
                      <div class="col">
                        <div class="card h-100 border-2 border-top-0 bg-light">
                          <div class="card-body p-0 iocl-blue-bg bg-gradient">
                            <div class="row m-0 py-2">
                              <div class="col-12 text-center text-light fw-bold h1 mb-0">${item["value"]}</div>
                              <div class="col-9 text-start iocl-orange-text fw-bold f6 pe-0">${item["name"]}</div>
                              <div class="col-3 text-end iocl-orange-text fw-bold f6 ps-0 text-nowrap">${item["unit"]}</div>
                            </div>
                          </div>
                        </div>
                      </div>
                      `;
                }
                powerHTML += `</div>`;
            }

            document.getElementById("power_card").innerHTML += powerHTML;
        }

        const panelAnnunciator = (objData) => {
            let hh = 16;

            let panelHTML = "", panelalerthtml = "";
            let color = "";


            for (let data in objData) {
                for (let i = 0; i < objData[data].length; i++) {
                    if (objData[data][i]["time"] > 60) {
                        color = "#efefef"
                    }
                    else {
                        color = "#8fed01";
                    }
                    if (objData[data][i]["time"] > 60) {
                        panelalerthtml += `<div style="color:red;" class="col-4 pe-0">${objData[data][i]["rtime"]}</div>
                            <div style="color:red;" class="col-8">${objData[data][i]["name"]}-offline</div>`;
                    }


                    if (objData[data][i]["name"] == "Battery2") {

                        panelHTML += `<div class="col-sm-6 col-md-5 text-center mb-6 mb-lg-3" >`;


                        panelHTML += `<div> <div style="border:solid 3px ${color}"  class="row row-cols-4 gx-2 justify-content-center" >`;

                        for (let cnt = 0; cnt < objData[data][i]["length"]; cnt++) {

                            panelHTML += `<div  class="col border p-0 text-center" id="${objData[data][i]["name"]}_S${hh + 1}"> S${hh + 1}</div>`;
                            hh += 1;
                        }

                        panelHTML += `</div></div><div class ="no-space-break"><strong>${objData[data][i]["name"]}</strong></div></div>`;


                    }
                    else {
                        panelHTML += `<div class="col-sm-6 col-md-5   text-center mb-6 mb-lg-3" style="background-color:"#8fed01">`;


                        panelHTML += `<div style="border:solid 3px ${color}" class="row row-cols-4 gx-2 justify-content-center" style="background-color:"#8fed01">`;

                        for (let cnt = 0; cnt < objData[data][i]["length"]; cnt++) {

                            panelHTML += `<div  class="col border p-0 text-center" id="${objData[data][i]["name"]}_S${cnt + 1}"> S${cnt + 1}</div>`;
                        }

                        panelHTML += `</div><div class ="no-space-break"><strong>${objData[data][i]["name"]}</strong></div></div>`;


                    }

                }
                document.getElementById("panel_card").innerHTML += panelHTML;
                document.getElementById("EM_Alert").innerHTML += panelalerthtml;

            }
        }

        const loadPowerMonitoringData = () => {
            let selectedEnergy = $("#<%= EnergyListElement.ClientID %>").val();
            $("#energyElementPrint").html(selectedEnergy)
            $.ajax({
                type: "POST",
                url: "Dashboard.aspx/GetEnergyMeterData",
                data: JSON.stringify({ MeterID: selectedEnergy, Date: today }),
                contentType: "application/json; charset=utf-8",
            }).done(function (data) {
                let parseData = JSON.parse(data.d);
                console.log(parseData)
                if (parseData) {
                    let selectedEnergy = $("#<%= EnergyListElement.ClientID %>").val();
                    let newData = parseData[selectedEnergy][0];
                    let powerData = [];
                    for (let key in newData) {
                        powerData.push({ name: key, value: newData[key], unit: powerUnit[key] });
                    }
                    powerMonitoring(parseData[selectedEnergy]);
                    fuelMonitoing(parseData["FUEL"]);
                    batteryMonitoring(parseData["BATTERY"]);
                    waterMonitoring(parseData["WATER"]);
                    firepumpMonitoring(parseData["FIREPUMP"], parseData["firealert"]);
                    initFlowImg(parseData["WFM"]);

                    powerAlert(parseData["Alertenergy"]);
                } else {
                    alert("Failed to load data");
                }
            });
        }
        const loadPowerMonitoringSwitches = () => {
            let selectedEnergy = $("#<%= EnergyListElement.ClientID %>").val();
            $.ajax({
                type: "POST",
                url: "Dashboard.aspx/GetEnergyMeterSwitches",
                contentType: "application/json; charset=utf-8",
            }).done(function (data) {
                let parseData = JSON.parse(data.d);
                if (parseData) {
                    panelAnnunciator(parseData)
                   loadPMSTrips();
                } else {
                    alert("Failed to load data");
                }
            });
        }
        const loadPMSTrips = () => {
            var alertHTML = '';
            let textclr =  "text-danger" ;
            var currentdate = new Date();
            var datetime =
                currentdate.getHours() + ":"
                + currentdate.getMinutes();

            $.ajax({
                type: "POST",
                url: "Dashboard.aspx/GetEMSTrips",
                contentType: "application/json; charset=utf-8",
            }).done(function (data) {
                let parseData = JSON.parse(data.d);
                if (parseData) {
                    $("#panel_card.panel-box.bg-danger").removeClass("bg-danger");

                    for (let cnt = 0; cnt < parseData.length; cnt++) {

                        if (parseData[cnt]["MeterID"] == "Battery1") {


                            if (parseData[cnt]["SwitchID"] == "S3" || parseData[cnt]["SwitchID"] == "S9" ||
                                parseData[cnt]["SwitchID"] == "S14" || parseData[cnt]["SwitchID"] == "S16") {

                              
                                $("#" + parseData[cnt]["MeterID"] + "_" + parseData[cnt]["SwitchID"]).addClass("bg-success");

                            }
                            else {
                                alertHTML += `<div class="col-3 pe-0">${datetime}</div>
                            <div class="col-9">  ${parseData[cnt]["MeterID"]}-${parseData[cnt]["Meterdesc"]}-Pannel Tripped</div>`;
                                $("#" + parseData[cnt]["MeterID"] + "_" + parseData[cnt]["SwitchID"]).addClass("bg-danger");

                            }

                        }

                        else {
                            alertHTML += `<div class="col-3 pe-0">${datetime}</div>
                            <div class="col-9">  ${parseData[cnt]["MeterID"]}-${parseData[cnt]["Meterdesc"]}-Pannel Tripped</div>`;
                            $("#" + parseData[cnt]["MeterID"] + "_" + parseData[cnt]["SwitchID"]).addClass("bg-danger");

                        }

                                   }
                document.getElementById("EMAlert").innerHTML = alertHTML;
                } else {
                    alert("Failed to load data");
                }
            });
        }
        const loadPMSTripsAlert = () => {
            $.ajax({
                type: "POST",
                url: "Dashboard.aspx/GetEMSTripsAlerts",
                contentType: "application/json; charset=utf-8",
            }).done(function (data) {
                let parseData = JSON.parse(data.d);
                if (parseData) {
                    let alertHTML = "";
                    for (let cnt = 0; cnt < parseData.length; cnt++) {
                        let item = parseData[cnt];
                        let textclr = item.status == "True" ? "text-danger" : "text-success";
                        alertHTML += `<div class="col-3 pe-0 ${textclr}">${item["time"]}</div>
                            <div class="col-9 ${textclr}">${item["msg"]}</div>`;
                    }
                    document.getElementById("EMAlert").innerHTML = alertHTML;
                } else {
                    alert("Failed to load data");
                }
            });
        }
        function powerAlert(data) {
            let alertHtml = '';
            if (data.length != 0) {

                alertHtml += `<div class="col-4 pe-0">${data[0]["rtime"]} </div>
                            <div class="col-8">Today's kWh :  ${data[0]["todaykwh"]} </div>
<div class="col-4 pe-0">${data[0]["rtime"]} </div>
                            <div class="col-8">Total kWh :  ${data[0]["kwh"]} </div>
<div class="col-4 pe-0"> ${data[0]["rtime"]}</div>
                            <div class="col-8">Total kVAh :  ${data[0]["vah"]} </div>
<div class="col-4 pe-0">${data[0]["rtime"]} </div>
                            <div class="col-8">Total kVARh :  ${data[0]["varh"]} </div>`;



                document.getElementById("power_Alert").innerHTML = alertHtml

            }
            else {
                document.getElementById("power_Alert").innerHTML = "";
            }
        }
        function initFlowImg(data) {
          
            const svgCode = flowSvg(data[0]["time"] > 10 ? "#efefef" : "#22bc22");
            const flowrateCode = flowrateSvg(data[1]["time"] > 10 ? "#efefef" : "#005493");
            let wateralertHtml = '';     
            let time = data[1]["Mtime"].split(" ");
        let htmlCode = `<div class="col-lg-3 text-center">
                <strong>Flow Rate</strong>
                      <div class="col-12 text-center mt-3">
                        ${flowrateCode}
                      </div>
                    <strong id="vbar">${data[1]["voltage"]} m3/h</strong>
                        </div >
</div >

<div class="col-lg-6 text-center">
<div class="col-lg-8 text-center">

                               


   <!--  <div class="d-flex justify-content-center text-center mt3 left" >
                                     <input class=err type="text"  id="testnum" placeholder="pressure(bar)" />
                                    <button type="button" class="btn btn-primary btn-sm m-1" onclick="set();">
                                      Set
                                    </button>
                                    <button type="button" class="btn btn-primary btn-sm m-1" id='rdbtn' >
                                        Record
                                    </button>

                                </div> -->

                            </div>
<div>
<button type="button" class="btn btn-primary btn-sm " id='strtbtn' style="float: left;margin-left:50px;" onclick="Start();">
                                        Start Test
                                    </button>

<button type="button" class="btn btn-primary btn-sm " id='stpbtn' style="float: right;margin-right:50px;" onclick="Stop();">
                                        Stop Test
</div>

<button type="button" class="btn btn-primary btn-sm" id='recordbtn' style="margin-top: 30px;" onclick="Record();">
                                        Record
                                    </button>

<br/>
<br/>
                                <div class="col-12 text-center">
                                   
                                    <div class="text-start">
                                        <div id="chart"></div>
                                    </div>
<div class="d-flex justify-content-center text-center mt3 left" >
                                     <input  type="number"  style="margin:10px;"  id="flow_rate"  placeholder="Flow rate (m3/h)" />
                                     <input type="number" style="margin:10px;" id="pressure_bar"  placeholder="Pressure (bar)" />
                                   </div>
<button type="button" class="btn btn-primary btn-sm" id='basevalues' style="margin-top: 10px;" onclick="SetBaseValues();">
                                        Set Base Values
                                    </button>
                                </div>
                           </div>
<div class="col-lg-3 text-center">
                <strong>Pressure Transmitter</strong>
                      <div class="col-12 text-center mt-3">
                        ${svgCode}
                      </div>
    <strong id="pbar">${data[0]["voltage"]} bar</strong>
                        </div >
</div >`;

            if (data[0]['maxrpm'] != 0 && data[0]['time'] < 10) {

                wateralertHtml += `<div class="col-4 pe-0">${data[1]["Mtime"]}</div>
                            <div class="col-8"> Maximum flow ${data[1]["maxrpm"]} m3/h </div>`;
            }
            else if (data[0]['time'] > 10) {
                wateralertHtml += `<div style="color:red;" class="col-4 pe-0">${data[1]["Rtime"]}</div>
                            <div style="color:red;" class="col-8"> Pressure Transmitter offline</div>`;
            }
            if (data[1]['maxrpm'] != 0 && data[1]['time'] < 10) {
                wateralertHtml += `<div class="col-4 pe-0">${data[1]["Mtime"]}</div>
                            <div  class="col-8"> Maximum Pressure ${data[0]["maxrpm"]} bar </div>`;
            }
            else if (data[1]['time'] > 10) {
                wateralertHtml += `<div style="color:red;" class="col-4 pe-0">${data[1]["Rtime"]}</div>
                            <div style="color:red;" class="col-8"> Flow Rate offline</div>`;
            }

            document.getElementById("flow_monitoring").innerHTML = htmlCode
            document.getElementById("flow_alert").innerHTML = wateralertHtml
           
            chart = new ApexCharts(document.querySelector("#chart"), options1);
           
            logChart = () => console.log(chart),
                destroyChart = () => {
                    if (chart.ohYeahThisChartHasBeenRendered) {
                        chart.destroy();
                        chart.ohYeahThisChartHasBeenRendered = false;
                    }
                };

            chart.render().then(() => chart.ohYeahThisChartHasBeenRendered = true);   

           
            document.getElementById('stpbtn').disabled = 1;
            document.getElementById('recordbtn').disabled = 1;
            document.getElementById('basevalues').disabled = 1;
            document.getElementById('flow_rate').disabled = 1;
            document.getElementById('pressure_bar').disabled = 1;
            
        }
        const intervalLoading = () => {

            if (start == 0) {
                setInterval(() => {
                    if (start == 0) {
                        loadPMSTrips();
                        loadPowerMonitoringData();
                    }
                    else if (record==1) {
                        Record();
                    }
                   
                    //loadPMSTripsAlert();
                    // loadPMSTrips();
                }, timing);
            }
           
        }

            function loadPressureValues(setvalue, recordvalue, from) {

                $.ajax({
                    type: "POST",
                    url: "Dashboard.aspx/GetPressureDatas",
                    data: JSON.stringify({ date: today, set: setvalue, record: recordvalue, from: from, start: start }),
                    contentType: "application/json; charset=utf-8",
                }).done(function (data) {
                    let set1ary = [],rec1ary=[];
                    let parseData = JSON.parse(data.d);
                    if (parseData) {

                        if (parseData["setvalue"].length > 0) {
                            var set1 = parseData["setvalue"];

                            for (let cnt = 0; cnt < set1.length; cnt++) {
                                setary.push((parseData["setvalue"][cnt]["set"]));
                            }

                            for (let cnt1 = 0; cnt1 < parseData["recordvalue"].length; cnt1++) {
                                recordary.push((parseData["recordvalue"][cnt1]["record"]));
                            }
                          
                        }
                      

                    }

                    spinner.hide();
                   

                    if (chart != null) {
                        
                        chart.updateSeries([

                            {
                                name: 'Set',
                                data: setary
                            },
                            {
                                name: 'Record',
                                data: recordary
                            },
                        ],
                        );
                       
                    }
                },)};
    
        
            $(window).on("load", function () {

                loadPressureValues(0, 0, 'load');
                if (start == 0) {
                    $("#<%= EnergyListElement.ClientID %>").prop('selectedIndex', 0);
                    loadPowerMonitoringData();
                    loadPowerMonitoringSwitches();
                    intervalLoading();
                }
                else {

                    Record();
                }
            });
        let options1 = {

            chart: {
                height: 380,
                type: "line",
                foreColor: '#6D6D6D',
                stacked: false
            },

            colors: ['#F44336', '#9C27B0'],

            series: [
                {
                    name: 'Set',
                    data: json1
                },
                {
                    name: 'Record',
                    data: myjson
                }



            ],
            grid: {
                borderColor: '#6D6D6D'
            },
            stroke: {
                curve: 'smooth'
            },
            yaxis: {
                title: {
                    text: 'Pressure (bar)'
                },
                min: 0,
                max: 21,

                labels: {
                    show: true
                }
            },
            xaxis: {

                title: {
                    text: 'Flow Rate (m3/h)'
                },
                min: 0,
                max: 1200,

                tickAmount: 6,
                labels: {
                    show: true
                },
                type: 'numeric'
            },
            dataLabels: {
                enabled: true,
            },
            title: {
                text: 'Flow Rate(m3/h) / Pressure(bar)',
                align: 'center'
            },
        };

        const saveToArchive = async (chartId) => {
            const chartInstance = window.Apex._chartInstances.find(chart => chart.id === chartId);
            const base64 = await chartInstance.chart.dataURI();
            return base64;
        }
        function Record() {
            record = 1;
            let cnt, cnt1;
            var now = new Date();

            var day = ("0" + now.getDate()).slice(-2);
            var month = ("0" + (now.getMonth() + 1)).slice(-2);
            getdatetime = (now.getFullYear() + "-" + (month) + "-" + (day) + " " + now.getHours() + ":" + ("0" + now.getMinutes()).slice(-2) + ":" + ("0" + now.getSeconds()).slice(-2));

            $.ajax({
                type: "POST",
                url: "Dashboard.aspx/GetMQttDatas",
                data: JSON.stringify({ date: getdatetime }),
                contentType: "application/json; charset=utf-8",
            }).done(function (data) {
                let parseData = JSON.parse(data.d);
                if (parseData) {

              


                    if (parseData["PTX"].length > 0) {
                        var set1 = parseData["WFM"];

                        for (cnt = 0; cnt < set1.length; cnt++) {
                            setary.push((parseData["WFM"][cnt]["WFM"]));
                        }

                        for (cnt1 = 0; cnt1 < parseData["PTX"].length; cnt1++) {
                            recordary.push((parseData["PTX"][cnt1]["PTX"]));
                        }
                        document.getElementById('pbar').innerHTML = parseData["PTX"][0]["PTX"] + " bar";
                        document.getElementById('vbar').innerHTML = parseData["WFM"][0]["WFM"] +" m3/h";
                        myrecordarray.push([parseInt(parseData["WFM"][0]["WFM"]), parseInt(parseData["PTX"][0]["PTX"])]);
                       
                       // document.getElementById('pbar').value = parseInt(parseData["PTX"][0]["PTX"]);
                    }
                }
              

                if (chart != null) {

                    chart.updateOptions({

                        series: [

                            {

                                name: 'Set',
                                data: myArray
                            },
                            {
                                name: 'Record',
                                data: myrecordarray
                            }
                        ],
                        xaxis: {
                            min: 0,
                            max: 1200,
                            tickAmount: 6
                        }
                    });


                }
            });



        }
        function delay(time) {
            return new Promise(resolve => setTimeout(resolve, time));
        }


        function SetBaseValues() {
            if (parseInt(document.getElementById('flow_rate').value) > 1200) {
                alert("Enter the flow value below 1200");
            }
            else if (document.getElementById('flow_rate').value == "") {
                alert("Please enter the flow value");
            }
            else if (parseInt(document.getElementById('pressure_bar').value) > 21) {
                alert("Enter the pressure value below 21");
            }
            else if (document.getElementById('pressure_bar').value == "") {
                alert("Please enter the pressure value");
            }
            else {

                myArray.push([parseInt(document.getElementById('flow_rate').value), parseInt(document.getElementById('pressure_bar').value)]);
                document.getElementById('flow_rate').value = '';
                document.getElementById('pressure_bar').value = '';

                if (chart != null) {


                    chart.updateOptions({

                        series: [
                            {

                                name: 'Set',
                                data: myArray
                            },
                            {
                                name: 'Record',
                                data: myrecordarray
                            },
                        ],
                        xaxis: {
                            min: 0,
                            max: 1200,
                            tickAmount: 6
                        }

                    });


                }



                //chart.updateOptions({
                //    xaxis: {
                //        categories: flowary
                //    },
                //    series: [{

                //            name: 'Set',
                //            data: pressureary
                //        },


                //    ],
                //});


            }
        }


        function Start() {
            document.getElementById('stpbtn').disabled = 0;
            document.getElementById('recordbtn').disabled = 0;
            document.getElementById('basevalues').disabled = 0;
            document.getElementById('flow_rate').disabled = 0;
            document.getElementById('pressure_bar').disabled = 0;
            document.getElementById('strtbtn').disabled = 1;
            start = 1;
            timing = 5000;
            setary = [];
            // loadPressureValues(0, 0, "start");
        }
        function Stop() {
            document.getElementById('strtbtn').disabled = 0;
            document.getElementById('stpbtn').disabled = 1;
            document.getElementById('basevalues').disabled = 1;
            document.getElementById('recordbtn').disabled = 1;
            document.getElementById('flow_rate').disabled = 1;
            document.getElementById('pressure_bar').disabled = 1;
            start = 0;
            record = 0;
            timing = 30000;
            myArray = [];
            myrecordarray = [];
            document.getElementById('flow_rate').value = '';
            document.getElementById('pressure_bar').value = '';


            chart.dataURI().then(({ imgURI, blob }) => {
                var pdf = new jsPDF();
                pdf.addImage(imgURI, 'PNG', 0, 0);
                pdf.save("download.pdf");
            })



            if (chart != null) {


                chart.updateOptions({

                    series: [
                        {

                            name: 'Set',
                            data: myArray
                        },
                        {
                            name: 'Record',
                            data: myrecordarray
                        },
                    ],
                    xaxis: {
                        min: 0,
                        max: 1200,
                        tickAmount: 6
                    }

                });


            }
            //  loadPressureValues(0, 0, "stop");
            //   window.location.reload();
        }
        function set() {

            setvalue = document.getElementById('testnum').value;
            if (setvalue > 10) {
                alert("Enter the value below 10");
            }
            else if (setvalue == 0) {
                alert("Please enter the value");
            }
            else {
                //spinner.show();
                setary = [];
                loadPressureValues(setvalue, 0, 'set');

                //  window.location.reload();

            }
        }
    </script>
</asp:Content>
