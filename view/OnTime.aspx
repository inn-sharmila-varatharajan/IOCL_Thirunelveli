<%@ Page Language="C#" MasterPageFile="~/view/Admin.Master" AutoEventWireup="true" CodeBehind="OnTime.aspx.cs" Inherits="MonitoringSystem.view.OnTime" %>


<asp:Content ID="head" ContentPlaceHolderID="Content_Header" runat="server">
</asp:Content>
<asp:Content ID="OnTime" ContentPlaceHolderID="Content_Page" runat="server">
    <div class="row mb-5 justify-content-center">
            <div class="col-lg-9">
                <div class="card">
                    <h5 class="card-header fw-bolder iocl-blue-text">
                       On-Time Report
                    </h5>
                    <div>  
                      <div class="card-header bg-white border-0">
                          
           <div class="btn-group float-start">
                <input  type="date" id="datechange" >
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
                                <td>Equipment Name</td>  
                                <td>Start Time</td>  
                                <td>Stop Time</td>  
                                <td>Running Hours</td>  

                            </tr>
                        
                                </thead><%--<%=getReport("2022-05-22")%>  --%>
                            <tbody id="reportdatas1"></tbody>
                        </table> 
                        <table id="Table"   style="border: 1px solid black;border-collapse: collapse;" width="100%" align="center" cellpadding="2" cellspacing="2" border="0" bgcolor="#EAEAEA" >  
                            <thead id="reporthead">
                            <tr align="left" style="background-color:#004080;color:White;" >  
                              <td>S.No.</td>  
                                <td>Equipment Name</td>  
                                <td>Start Time</td>  
                                <td>Stop Time</td>  
                                <td>Running Hours</td>  
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
        let docdefinition = "";
        var pager = new Pager('Table', 10);
        var spinner = $('#loader');




        $(document).ready(function () {

            var now = new Date();

            var day = ("0" + now.getDate()).slice(-2);
            var month = ("0" + (now.getMonth() + 1)).slice(-2);

            var today = now.getFullYear() + "-" + (month) + "-" + (day);

            $('#datechange').val(today);
            spinner.show();
            GetItem(today);
            datechange.max = new Date().toISOString().split("T")[0];
        });
        $('#datechange').change(function () {
            var selecteddate = this.value;
            spinner.show();
            $('#reportdatas').innerHTML = "";
            GetItem(selecteddate);
        });
        function GetItem(selecteddate) {

            $.ajax({
                type: "POST",
                url: "OnTime.aspx/getReport",
                data: JSON.stringify({ date: selecteddate, todate: selecteddate }),
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
                    let cnh = 0;
                    for (let cnt = 0; cnt < list.length; cnt++) {
                        let obj = list[cnt];
                        if (obj.hours != "00:00") {
                            let row = `<tr>
                               <td>${cnh + 1}</td> <td>${obj.device}</td><td>${obj.starttime}</td>
                                <td>${obj.endtime}</td ><td>${obj.hours}</td>
                             
                            </tr>`;
                            rowHTML += row;
                            cnh++;
                        }
                    }
                    document.getElementById("reportdatas").innerHTML = rowHTML
                    document.getElementById("reportdatas1").innerHTML = rowHTML

                    spinner.hide();

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
            $("#Table1").table2excel({
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
border: solid 1px #03174f;
font-size:small;
}

table.yui td {
padding: 5px;
border-right: solid 1px #03174f;
}
table {
    border-collapse: collapse;
}
table td {
            padding: 0.5rem;
            border: 1px solid #fff;
        }
</style>  

</asp:Content>
