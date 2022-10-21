<%@ Page Title="" Language="C#" MasterPageFile="~/view/Admin.Master" AutoEventWireup="true" CodeBehind="ChangePassword.aspx.cs" Inherits="MonitoringSystem.view.ChangePassword" %>
<asp:Content ID="head" ContentPlaceHolderID="Content_Header" runat="server">
</asp:Content>
<asp:Content ID="ChangePassword" ContentPlaceHolderID="Content_Page" runat="server">
     <div class="container-fluid">
        <form id="form1" runat="server">
            <div class="container-fluid">
        <div class="row justify-content-center">
            <div class="col-sm-5">
                <div class="card">
                    <h5 class="card-header fw-bolder iocl-blue-text">
                        <i class="fas fa-key"></i> Change Password
                    </h5>
                    <div class="card-body">
                        <div class="form">
                            <div class="row mb-3">
                                <label for="inputName" class="col-sm-3 col-form-label">
                      Current Password
                    </label>
                                <div class="col-sm-9">
                                    <input type="password" class="form-control" id="inputName" placeholder="Enter current Password" />
                                </div>
                            </div>
                            <div class="row mb-3">
                                <label for="inputEmail" class="col-sm-3 col-form-label">New Password</label>
                    <div class="col-sm-9">
                      <input
                        type="password"
                        class="form-control"
                        id="inputEmail"
                        placeholder="Enter New Password"
                      />
                    </div>
                  </div>
                  <div class="row mb-3">
                    <label for="inputPhone" class="col-sm-3 col-form-label"
                      >Confirm Password</label
                    >
                    <div class="col-sm-9">
                      <input
                        type="password"
                        class="form-control"
                        id="inputPhone"
                        placeholder="Enter Confirm Password"
                      />
                    </div>
                  </div>
                  <div class="col-12 text-center">
                    <button
                      type="submit"
                      class="btn btn-primary"
                      @click="showList = !showList"
                    >
                      Submit</button
                    >&nbsp;
                    <button
                      type="button"
                      class="btn btn-danger"
                      @click="showList = !showList"
                    >
                      Cancel
                    </button>
                  </div>
                </div>
              </div>
            </div>
          </div>
          
        </div>
    </div>
        </form>
    </div>
</asp:Content>
<asp:Content ID="scripts" ContentPlaceHolderID="Content_Script" runat="server">
</asp:Content>
