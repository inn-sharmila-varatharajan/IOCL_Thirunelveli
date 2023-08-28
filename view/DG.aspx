<%@ Page Language="C#" MasterPageFile="~/view/Admin.Master" AutoEventWireup="true" CodeBehind="DG.aspx.cs" Inherits="MonitoringSystem.view.DG" %>

<asp:Content ID="head" ContentPlaceHolderID="Content_Header" runat="server">
</asp:Content>
<asp:Content ID="DG" ContentPlaceHolderID="Content_Page" runat="server">
 <div class="row mb-5 justify-content-center"">
            <div class="col-lg-9">
                <div class="card">
                    <h5 class="card-header fw-bolder iocl-blue-text">
                      DG_Mileage_Report	

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
                                <td>S.No</td>  
                                <td>Date</td>  
                                <td>TimeStamp</td>  
                                <td>DG</td>  
                                <td>Diesel Level</td>  
                                <td>Running Hrs</td>  
                                <td>Diesel Level/RunningHr</td>  

                            </tr>
                        
                                </thead><%--<%=getReport("2022-05-22")%>  --%>
                            <tbody id="reportdatas1"></tbody>
                        </table> 
                        <table id="Table"   style="border: 1px solid black;border-collapse: collapse;" width="100%" align="center" cellpadding="2" cellspacing="2" border="0" bgcolor="#EAEAEA" >  
                            <thead id="reporthead">
                            <tr align="left" style="background-color:#004080;color:White;" >  
                               <td>S.No</td>  
                                <td>Date</td>  
                                <td>TimeStamp</td>  
                                <td>DG</td>  
                                <td>Diesel Level</td>  
                                <td>Running Hrs</td>  
                                <td>Diesel Level/RunningHr</td>    
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
        </div>    </asp:Content>

