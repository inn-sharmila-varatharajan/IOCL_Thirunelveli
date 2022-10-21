<%@ Page Title="" Language="C#" MasterPageFile="~/view/Admin.Master" AutoEventWireup="true" CodeBehind="UserManager.aspx.cs" Inherits="MonitoringSystem.view.UserManager" %>
<asp:Content ID="head" ContentPlaceHolderID="Content_Header" runat="server">
</asp:Content>
<asp:Content ID="UserManager" ContentPlaceHolderID="Content_Page" runat="server">
    <div class="container-fluid">
        <form id="form1" runat="server">
            <div class="row justify-content-center">
            <div class="col-lg-6" id="user_list">
                <div class="table-responsive">
                    <h5 class="card-header fw-bolder iocl-blue-text border">
                        <i class="fas fa-users"></i> Users List
                    </h5>
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th scope="col">Detail</th>
                                <th scope="col">Role</th>
                                <th scope="col">Action</th>
                            </tr>
                        </thead>
                        <tbody id="user_list_tbody">

                        </tbody>
                    </table>
                    <p class="text-secondary">Note: for user password reset use edit function and save to generate new password.</p>
                </div>
            </div>
            <div class="col-lg-4 d-none" id="user_form">
                <div class="card">
                    <h5 class="card-header fw-bolder iocl-blue-text">
                        <i class="fas fa-user-edit"></i> User Manager
                    </h5>
                    <div class="card-body">
                        <form>
                            <div class="row mb-3">
                                <label for="inputName" class="col-sm-2 col-form-label">
                        Name
                      </label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="inputName" placeholder="Enter Name" value="Jacob" />
                                </div>
                            </div>
                            <div class="row mb-3">
                                <label for="inputEmail" class="col-sm-2 col-form-label">Email</label
                      >
                      <div class="col-sm-10">
                        <input
                          type="email"
                          class="form-control"
                          id="inputEmail"
                          placeholder="Enter Email"
                          value="Jacob@gmail.com"
                        />
                      </div>
                    </div>
                    <div class="row mb-3">
                      <label for="inputPhone" class="col-sm-2 col-form-label"
                        >Phone</label
                      >
                      <div class="col-sm-10">
                        <input
                          type="text"
                          class="form-control"
                          id="inputPhone"
                          placeholder="Enter 10-digit Number"
                          value="147852369"
                        />
                      </div>
                    </div>
                    <div class="row mb-3">
                      <label for="inputRole" class="col-sm-2 col-form-label"
                        >Role</label
                      >
                      <div class="col-sm-10">
                        <select id="inputRole" class="form-select">
                          <option>Choose...</option>
                          <option selected>User</option>
                        </select>
                      </div>
                    </div>
                    <div class="col-12 text-center">
                      <button
                        type="submit"
                        class="btn btn-primary"
                        onclick="showHideForm()"
                      >
                        Submit</button
                      >&nbsp;
                      <button
                        type="button"
                        class="btn btn-danger"
                        onclick="showHideForm()"
                      >
                        Cancel
                      </button>
                    </div>
                  </form>
                </div>
              </div>
            </div>
          </div>
        </form>
    </div>
</asp:Content>
<asp:Content ID="scripts" ContentPlaceHolderID="Content_Script" runat="server">
    <script>
        let userList = [
        {
          name: "Mark",
          mail: "mark@gmail.com",
          phone: "987654321",
          role: "Admin",
        },
        {
          name: "Jacob",
          mail: "Jacob@gmail.com",
          phone: "147852369",
          role: "User",
        },
        {
          name: "Larry the Bird",
          mail: "larry@twitter.com",
          phone: "789456123",
          role: "User",
        },
        {
          name: "Christian",
          mail: "christian@gmail.com",
          phone: "963258741",
          role: "User",
        },
        {
          name: "leggend",
          mail: "leggend@gmail.com",
          phone: "546879213",
          role: "User",
        },
      ];
        function userListGenerate() {
            let listHTML = "";
            for(let cnt=0; cnt < userList.length; cnt++){
                let item = userList[cnt];
                listHTML += `
                <tr>
                      <td><strong>${ item.name}</strong> <br><span class="me-1"><i class="fas fa-phone text-secondary"></i> ${ item.phone } </span> <span><i class="fas fa-envelope  text-secondary"></i> ${ item.mail }</span></td>
                      <td>${ item.role }</td>
                      <td>
                        <i class="fas fa-pencil-alt text-primary" onclick="showHideForm()"></i>&nbsp;
                        ${ item.role !== 'Admin' ? `<i class="fas fa-trash-alt text-danger"></i>` : ''}
                      </td>
                </tr>
            `;
            }
            document.getElementById("user_list_tbody").innerHTML = listHTML;
        }
        
        function showHideForm(){
            document.getElementById("user_list").classList.toggle("d-none");
            document.getElementById("user_form").classList.toggle("d-none");
        }
        function initUserManager() {
            userListGenerate();
        }

        initUserManager();
    </script>
</asp:Content>
