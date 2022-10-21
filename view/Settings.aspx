<%@ Page Title="" Language="C#" MasterPageFile="~/view/Admin.Master" AutoEventWireup="true" CodeBehind="Settings.aspx.cs" Inherits="MonitoringSystem.view.Settings" %>
<asp:Content ID="head" ContentPlaceHolderID="Content_Header" runat="server">
</asp:Content>
<asp:Content ID="Settings" ContentPlaceHolderID="Content_Page" runat="server">
    <div class="container-fluid">
        <form id="form1" runat="server">
            <div class="container-fluid">
        <div class="row justify-content-center" id="list_area">
            <div class="col-lg-5">
                <div class="table-responsive">
                    <h5 class="card-header fw-bolder iocl-blue-text border">
                        <i class="fas fa-gas-pump"></i> Fuel Tanks List
                    </h5>
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th scope="col">Tank Name</th>
                                <th scope="col">Capacity (L)</th>
                                <th scope="col">Threshold (L)</th>
                                <!-- <th scope="col">Battery Level</th> -->
                                <th scope="col">Action</th>
                            </tr>
                        </thead>
                        <tbody id="oil_list_tbody">

                        </tbody>
                    </table>
                </div>
            </div>
            <!-- <div class="w-100"></div> -->
            <div class="col-lg-5">
                <div class="table-responsive">
                    <h5 class="card-header fw-bolder iocl-blue-text border">
                        <i class="fas fa-tint"></i> Water Tanks List
                    </h5>
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th scope="col">Tank Name</th>
                                <th scope="col">Capasity (KL)</th>
                                <th scope="col">Threshold (KL)</th>
                                <th scope="col">Action</th>
                            </tr>
                        </thead>
                        <tbody id="water_list_tbody">

                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="row justify-content-center">
            <div class="col-lg-5 d-none" id="oil_form">
                <div class="card">
                    <h5 class="card-header fw-bolder iocl-blue-text">
                        <i class="fas fa-gas-pump"></i> Fuel Tank Manager
                    </h5>
                    <div class="card-body">
                        <form>
                            <div class="row mb-3">
                                <label for="inputName" class="col-sm-3 col-form-label">
                      Tank Name
                    </label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" id="inputTankName" placeholder="Enter Tank Name" readonly />
                                </div>
                            </div>
                            <div class="row mb-3">
                                <label for="inputCapasity" class="col-sm-3 col-form-label">Capacity</label
                    >
                    <div class="col-sm-9">
                      <input
                        type="text"
                        class="form-control"
                        id="inputCapasity"
                        placeholder="Enter Capasity"
                        readonly
                      />
                    </div>
                  </div>
                  <div class="row mb-3">
                    <label for="inputFuelThreshold" class="col-sm-3 col-form-label"
                      >Fuel Threshold</label
                    >
                    <div class="col-sm-9">
                      <input
                        type="text"
                        class="form-control"
                        id="inputFuelThreshold"
                        placeholder="Enter Fuel Threshold"
                      />
                    </div>
                  </div>
                  <div class="col-12 text-center">
                    <button
                      type="submit"
                      class="btn btn-primary"
                      onclick="showHideForm('oil_form')"
                    >
                      Submit</button
                    >&nbsp;
                    <button
                      type="button"
                      class="btn btn-danger"
                      onclick="showHideForm('oil_form')"
                    >
                      Cancel
                    </button>
                  </div>
                </form>
              </div>
            </div>
          </div>
          <div class="col-lg-5 d-none" id="water_form">
            <div class="card">
              <h5 class="card-header fw-bolder iocl-blue-text">
                <i class="fas fa-tint"></i> Water Tank Manager
              </h5>
              <div class="card-body">
                <form>
                  <div class="row mb-3">
                    <label for="inputName" class="col-sm-3 col-form-label">
                      Tank Name
                    </label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" id="inputTankName" placeholder="Enter Tank Name" readonly />
                                </div>
                            </div>
                            <div class="row mb-3">
                                <label for="inputCapasity" class="col-sm-3 col-form-label">Capacity</label
                    >
                    <div class="col-sm-9">
                      <input
                        type="text"
                        class="form-control"
                        id="inputCapasity"
                        placeholder="Enter Capasity"
                        readonly
                      />
                    </div>
                  </div>
                  <div class="row mb-3">
                    <label for="inputWaterThreshold" class="col-sm-3 col-form-label"
                      >Water Threshold</label
                    >
                    <div class="col-sm-9">
                      <input
                        type="text"
                        class="form-control"
                        id="inputWaterThreshold"
                        placeholder="Enter water Threshold"
                      />
                    </div>
                  </div>
                  <div class="col-12 text-center">
                    <button
                      type="submit"
                      class="btn btn-primary"
                      onclick="showHideForm('water_form')"
                    >
                      Submit</button
                    >&nbsp;
                    <button
                      type="button"
                      class="btn btn-danger"
                      onclick="showHideForm('water_form')"
                    >
                      Cancel
                    </button>
                  </div>
                </form>
              </div>
            </div>
          </div>
        </div>
    </div>
        </form>
    </div>
</asp:Content>
<asp:Content ID="scripts" ContentPlaceHolderID="Content_Script" runat="server">
    <script>
        let oilList= [
        {
          name: "DG 750kVA",
          capacity: "10000",
          threshold: "3500",
          battery: "20",
        },
        {
          name: "DG 250kVA",
          capacity: "50000",
          threshold: "15000",
          battery: "50",
        },
        {
          name: "Fire Pump 1",
          capacity: "5000",
          threshold: "1500",
          battery: "20",
        },
        {
          name: "Fire Pump 2",
          capacity: "1000",
          threshold: "300",
          battery: "20",
        },
        {
          name: "Fire Pump 3",
          capacity: "15000",
          threshold: "3500",
          battery: "30",
        },
      ];
        let waterList = [
        { name: "Fire Water Tank 1", capacity: "25000", threshold: "5000" },
        { name: "Fire Water Tank 2", capacity: "50000", threshold: "10000" },
        { name: "Fire Water Tank 3", capacity: "20000", threshold: "4000" },
      ];
        function listGenerate() {
            let listHTML = "";
            for (let cnt = 0; cnt < oilList.length; cnt++) {
                let item = oilList[cnt];
                listHTML += `
                <tr>
                      <td>${ item.name }</td>
                      <td>${ item.capacity }</td>
                      <td>${ item.threshold }</td>
                      <td>
                        <i class="fas fa-pencil-alt text-primary" onclick="showHideForm('oil_form')"></i>
                      </td>
                </tr>
            `;
            }
            document.getElementById("oil_list_tbody").innerHTML = listHTML;
            
            listHTML = "";
            for (let cnt = 0; cnt < waterList.length; cnt++) {
                let item = waterList[cnt];
                listHTML += `
                <tr>
                      <td>${ item.name }</td>
                      <td>${ item.capacity }</td>
                      <td>${ item.threshold }</td>
                      <td>
                        <i class="fas fa-pencil-alt text-primary" onclick="showHideForm('water_form')"></i>
                      </td>
                </tr>
            `;
            }
            document.getElementById("water_list_tbody").innerHTML = listHTML;
        }
        function showHideForm(formname){
            document.getElementById("list_area").classList.toggle("d-none");
            document.getElementById(formname).classList.toggle("d-none");
        }
        function initSettingManager() {
          listGenerate();
        }

        initSettingManager();
    </script>
</asp:Content>
