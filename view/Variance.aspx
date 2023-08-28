﻿<%@ Page Language="C#" MasterPageFile="~/view/Admin.Master" AutoEventWireup="true" CodeBehind="Variance.aspx.cs" Inherits="MonitoringSystem.view.Variance" %>

<asp:Content ID="head" ContentPlaceHolderID="Content_Header" runat="server">
</asp:Content>
<asp:Content ID="Variance" ContentPlaceHolderID="Content_Page" runat="server">
    <div class="row mb-5 justify-content-center"">
            <div class="col-lg-9">
                <div class="card">
                    <h5 class="card-header fw-bolder iocl-blue-text">
                       Variance Analysis report
                    </h5>
                  
                    <div>  
                      <div class="card-header bg-white border-0">
                          
         <div class="btn-group float-start column">
               <h6 class="float-center">From</h6>
                <input  type="date" id="fromdatechange" >
            </div>  
            <div class="btn-group float-start column">
                           <h6 class="float-center">To</h6>
                <input  type="date" id="todatechange" >
           </div>
             <div class="btn-group float-start column">
               <button type="submit"value="Submit" onclick="submit()">Submit</button>
                 </div>
                                          
           <div class="btn-group float-end">
                            <image src="../assets/excel.png" id="btnExport" onclick="exportReportToExcel(this)"></image>
               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        
                            <image src="../assets/pdf.png" id="btnExport" onclick="pdf()"></image>
                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        
                            <image src="../assets/csv.png" id="btnExport" onclick="tableToCSV()"></image>
            </div>
         </div>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <div class="col">
                      <table id="Table1"  hidden style="border: 1px solid black;border-collapse: collapse;" width="100%" align="center" cellpadding="2" cellspacing="2" border="0" bgcolor="#EAEAEA" >  
                            <thead id="reporthead1">
                            <tr align="left" style="background-color:#004080;color:White;" >  
                                <td>S.No.</td>  
                               
                                <td>Device</td>  
                                <td>Start date</td>
                                <td>End date</td>
                                <td>kWH</td>  
                                <td>No of Running Hours</td>  
                                <td>KWH/RunningHours</td>  
                                       <td>Standard Value(kWh)</td> 
                                <td>Deviation</td>
                          
                            </tr>
                        
                                </thead><%--<%=getReport("2022-05-22")%>  --%>
                            <tbody id="reportdatas1"></tbody>
                        </table> 
                        <table id="Table"   style="border: 1px solid black;border-collapse: collapse;" width="100%" align="center" cellpadding="2" cellspacing="2" border="0" bgcolor="#EAEAEA" >  
                            <thead id="reporthead">
                            <tr align="left" style="background-color:#004080;color:White;" >  
                                <td>S.No.</td>  
                                <td>Device</td>   
                                <td>Start date</td>
                                <td>End date</td>
                                <td>kWH</td>  
                                <td>No of Running Hours</td>  
                                <td>KWH/RunningHours</td>  
                                 <td>Standard Value(kWh)</td> 
                                <td>Deviation</td>
                            </tr>
                        
                                </thead><%--<%=getReport("2022-05-22")%>  --%>
                            <tbody id="reportdatas"></tbody>

                        </table>  
                            </div>
                        <div id="pageNavPosition" style="padding-top: 20px" align="center">
                   </div>

                    </div>
                    </div>
                </div>
         
        </div>
    <div id="loader"></div>
    <div class="pro1">
     <div class="progress" id="progress">
  <div class="color" id="color">
      
  </div>

</div>
    <p style="text-align:center;">Please Wait...</p>
        </div>
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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.js"></script>
    <script>


        let docdefinition = "";
        var pager = new Pager('Table', 10);
        var pager1 = new Pager('Table', 10);
        var spinner = $('.pro1');
        let fromdate, todate, today;
        $(document).ready(function () {

            var now = new Date();

            var day = ("0" + now.getDate()).slice(-2);
            var month = ("0" + (now.getMonth() + 1)).slice(-2);

            today = now.getFullYear() + "-" + (month) + "-" + (day);

            $('#fromdatechange').val(today);
            $('#todatechange').val(today);

            spinner.show();
            GetItem(today, today);
            fromdate = today;
            todate = today;

            fromdatechange.max = new Date().toISOString().split("T")[0];
            todatechange.max = new Date().toISOString().split("T")[0];
        });
        $('#fromdatechange').change(function () {
            fromdate = this.value;

            $('#reportdatas').innerHTML = "";
            // spinner.show();
            //GetItem(selecteddate);
        });
        $('#todatechange').change(function () {
            todate = this.value;

            $('#reportdatas').innerHTML = "";
            // spinner.show();
            // GetItem(selecteddate);
        });


        function set(devicename, value) {
            // var h = devicename.split(",");
            var hh = 'standard_' + value;
            var valu = document.getElementById(hh).value;
            spinner.show();


            $.ajax({
                type: "POST",
                url: "Variance.aspx/getstandardrate",
                data: JSON.stringify({ device: devicename, value: valu }),
                contentType: "application/json; charset=utf-8",
                dataType: 'text',

            }).done(function (data) {
                let dataObj = JSON.parse(data);
                let dObj = JSON.parse(dataObj.d);
                let list = dObj.data;
                GetItem(fromdate, todate);
                spinner.hide();
            });

        }
        const getDaysDiff = (start_date, end_date, date_format = 'YYYY-MM-DD') => {
            const getDateAsArray = (date) => {
                return moment(date.split(/\D+/), date_format);
            }
            return getDateAsArray(end_date).diff(getDateAsArray(start_date), 'days') + 1;
        }
        function submit() {
            if (fromdate > todate) {
                alert("todate should be greater from fromdate");
                todate = today;
                $('#todatechange').val(today);
            }
            else if (isMoreThan30DaysAgo(new Date(fromdate)) == true) {
                alert("Please select date below 30 Days");
            }
            else {
                var jj = getDaysDiff(fromdate, todate);
                if (jj > 15) {
                    document.getElementById("color").style["-webkit-animation"] = "progres 600s infinite linear";
                }
                else if (jj > 5) {
                    document.getElementById("color").style["-webkit-animation"] = "progres 300s infinite linear";
                }
                else if (jj > 3) {
                    document.getElementById("color").style["-webkit-animation"] = "progres 180s infinite linear";
                }
                else {
                    document.getElementById("color").style["-webkit-animation"] = "progres 90s infinite linear";
                }
                spinner.show();
                document.getElementById("reportdatas").innerHTML = "";
                document.getElementById("reportdatas1").innerHTML = "";

                GetItem(fromdate, todate);
            }
            // alert(fromdate, todate);
        }

        function isMoreThan30DaysAgo(date) {
            //                   days  hours min  sec  ms
            const thirtyDaysInMs = 30 * 24 * 60 * 60 * 1000;
            const timestampThirtyDaysAgo = new Date(todate) - thirtyDaysInMs;


            if (timestampThirtyDaysAgo > date) {


                return true;
            } else {


                return false;
            }
        }
        const _MS_PER_DAY = 1000 * 60 * 60 * 24;

        // a and b are javascript Date objects
        function dateDiffInDays(a, b) {
            // Discard the time and time-zone information.
            const utc1 = Date.UTC(a.getFullYear(), a.getMonth(), a.getDate());
            const utc2 = Date.UTC(b.getFullYear(), b.getMonth(), b.getDate());

            return Math.floor((utc2 - utc1) / _MS_PER_DAY);
        }

        function GetItem(selecteddate, todate) {

            $.ajax({
                type: "POST",
                url: "Variance.aspx/getReport",
                data: JSON.stringify({ date: selecteddate, todate: todate }),
                contentType: "application/json; charset=utf-8",
                dataType: 'text',

            }).done(function (data) {
                let dataObj = JSON.parse(data);
                let dObj = JSON.parse(dataObj.d);
                let list = dObj.data;
                spinner.hide();
                if (list.length == 0 || list == "undefined") {
                    document.getElementById("reportdatas").innerHTML = "No Datas"
                }

                if (list.length) {
                    let rowHTML = "", row1HTML;
                    var devicen = "";
                    var stan = "";

                    for (let cnt = 0; cnt < list.length; cnt++) {
                        let obj = list[cnt];
                        var direction = obj.direction == 1 ? '&#9660;' : '&#9650;';
                        devicen = obj.device;
                        let color = obj.direction == 0 ? "#964B00" : "#03174f";
                        stan = obj.standard == 0 ? "0.00" : obj.standard;
                        let devia = obj.direction == 1 ? obj.deviation.replace('-', '') : obj.deviation;
                        let start = selecteddate;
                        let end = todate;
                        if (devia == "") {
                            devia = '-';
                        }
                        else {
                            devia = devia + "%";
                        }

                        let row = `<tr>
                               <td>${cnt + 1}</td> <td>${obj.device}</td><td>${start}</td><td>${end}</td>
<td>${obj.kwh}</td>
                                <td>${obj.hours}</td ><td>${obj.kwh_hr}</td>
      <td><input type="number" id="standard_${cnt}"  min="0" max="10" step="0.25" value="${stan}"  name="standard"/>
<button type="button" style="background-color:#004080;color:#ffffff"  onclick="set('${devicen}','${cnt}');">Set</button>
</td>
 <td style="color:${color}">${direction} ${devia}</td>

                             
                            </tr>`;
                        let row1 = `<tr>
                               <td>${cnt + 1}</td> <td>${obj.device}</td><td>${start}</td><td>${end}</td><td>${obj.kwh}</td>
                                <td>${obj.hours}</td ><td>${obj.kwh_hr}</td>
      <td><input type="number" id="standard1_${cnt}"  min="0" max="10" step="0.25" value="${stan}"  name="standard"/>
<button type="button" style="background-color:#004080;color:#ffffff"  onclick="set('${devicen}','${cnt}');">Set</button>
</td>
 <td>&#8593 ${obj.deviation}</td>

                             
                            </tr>`;
                        rowHTML += row;
                        row1HTML += row1;
                    }
                    document.getElementById("reportdatas1").innerHTML = row1HTML
                    document.getElementById("reportdatas").innerHTML = rowHTML

                    spinner.hide();

                    pager.init();
                    pager.showPageNav('pager', 'pageNavPosition');
                    pager.showPage(1);
                }

            });

        };


        function setTwoNumberDecimal(event) {
            this.value = parseFloat(this.value).toFixed(2);
        }

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

       


.progress{
    position: relative;
    height: 20px;
    width: 30%;
    margin-left:40%;
    border: 1px solid black;
    border-radius: 1px;
}
.progress .color{
    position: absolute;
    background-color: green;
    width: 0px;
    height: 20px;
    border-radius: 5px;
    animation: progres 10s infinite linear;    
}
@keyframes progres{
    0%{
      width: 0%;
    }
    25%{
        width: 50%;
    }
    50%{
        width: 75%;
    }
    75%{
        width: 85%;
    }
    100%{
        width: 100%;
    }
};
    
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
table td {
            padding: 0.5rem;
            border: 1px solid #fff;
        }
  .row {
  display: flex;
}

        .column {
            margin-left:10px;
  flex: 10%;
  padding: 5px;
  /* Should be removed. Only for demonstration */
}
</style>


    
</asp:Content>
