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
                        <i class="fas fa-lightbulb"></i>Energy Monitoring
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
                        <i class="fas fa-bell"></i>Alert - Energy Monitoring
                    </h5>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-3 pe-0 iocl-blue-bg fw-bold border-end">Time <span class="fs-75">(hrs)</span></div>
                            <div class="col-9 iocl-blue-bg fw-bold">Message</div>
                        </div>
                        <div class="row" id="EMAlert">
                            
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row mb-5">
            <div class="col-lg-9">
                <div class="card">
                    <h5 class="card-header fw-bolder iocl-blue-text">
                        <i class="fas fa-gas-pump"></i>Fuel Level Monitoring
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
                        <i class="fas fa-bell"></i>Alert - Fuel Level
                    </h5>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-3 pe-0 iocl-blue-bg fw-bold border-end">Time <span class="fs-75">(hrs)</span></div>
                            <div class="col-9 iocl-blue-bg fw-bold">Message</div>
                        </div>
                        <div class="row">
                            <div class="col-3 pe-0">09:00</div>
                            <div class="col-9">Fire Pump 2 - Low</div>
                        </div>
                        <div class="row">
                            <div class="col-3 pe-0">07:30</div>
                            <div class="col-9">DG 750kVA - Low</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row mb-5">
            <div class="col-lg-9">
                <div class="card">
                    <h5 class="card-header fw-bolder iocl-blue-text">
                        <i class="fas fa-tint"></i>Water Level Monitoring
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
                        <i class="fas fa-bell"></i>Alert - Water Level
                    </h5>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-3 pe-0 iocl-blue-bg fw-bold border-end">Time <span class="fs-75">(hrs)</span></div>
                            <div class="col-9 iocl-blue-bg fw-bold">Message</div>
                        </div>
                        <div class="row">
                            <div class="col-3 pe-0">09:00</div>
                            <div class="col-9">Fire Water Tank 1 - Low</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row mb-5">
            <div class="col-lg-9">
                <div class="card">
                    <h5 class="card-header fw-bolder iocl-blue-text">
                        <i class="fas fa-fire"></i>Fire Pump Monitoring
                    </h5>
                    <div class="card-body px-0">
                        <div class="row justify-content-center">
                            <div class="col-lg-3 text-center">
                                <strong>Fire Pump 1</strong>
                                <div id="fire_pump_1"></div>
                                <!-- <apexchart type="radialBar" :options="options_1" :series="series_1"></apexchart> -->
                                <strong>1500 rpm</strong>
                            </div>
                            <div class="col-lg-3 text-center">
                                <strong>Fire Pump 2</strong>
                                <!-- <apexchart type="radialBar" :options="options_2" :series="series_2"></apexchart> -->
                                <div id="fire_pump_2"></div>
                                <strong>1700 rpm</strong>
                            </div>
                            <div class="col-lg-3 text-center">
                                <strong>Fire Pump 3</strong>
                                <div id="fire_pump_3"></div>
                                <!-- <apexchart type="radialBar" :options="options_3" :series="series_3"></apexchart> -->
                                <strong>300 rpm</strong>
                            </div>
                        </div>
                        <hr />
                        <div class="w-100"></div>
                        <div class="card-header bg-white border-0">
                            <span class="fw-bolder lh-lg iocl-blue-text">
                                <font-awesome-icon icon="wind" />
                                Water flow at delivery of
                  hydrant pump
                            </span>
                        </div>
                        <div class="row px-3 justify-content-between">
                            <div class="col-lg-2 pt-5">
                                <div class="d-flex">
                                    <strong class="w-50">Flow Rate</strong>
                                    <strong class="w-50">: 400 LPM</strong>
                                </div>
                                <div class="d-flex">
                                    <strong class="w-50">Pressure</strong>
                                    <strong class="w-50">: 8 bar</strong>
                                </div>
                            </div>
                            <div class="col-lg-4 text-center">
                                <div class="col-12 text-center">
                                    <strong>Flow Rate Vs Time</strong>
                                    <div class="text-start">
                                        <div id="flow_chart"></div>
                                    </div>
                                    <strong>Time (min)</strong>
                                </div>
                            </div>
                            <div class="col-lg-4 text-center">
                                <div class="col-12 text-center">
                                    <strong>Pressure Vs Time</strong>
                                    <div class="text-start">
                                        <div id="pressure_chart"></div>
                                    </div>
                                    <strong>Time (min)</strong>
                                </div>
                            </div>
                        </div>
                        <div class="row justify-content-end">
                            <div class="col-lg-8 text-center">
                                <div class="d-flex justify-content-center mt-3">
                                    <button type="button" class="btn btn-primary btn-sm m-1">
                                        Test
                                    </button>
                                    <button type="button" class="btn btn-primary btn-sm m-1">
                                        Reset
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-3">
                <div class="card h-100">
                    <h5 class="card-header fw-bolder iocl-blue-text">
                        <i class="fas fa-bell"></i>Alert - Fire Pump
                    </h5>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-3 pe-0 iocl-blue-bg fw-bold border-end">Time <span class="fs-75">(hrs)</span></div>
                            <div class="col-9 iocl-blue-bg fw-bold">Message</div>
                        </div>
                        <div class="row">
                            <div class="col-3 pe-0">11:00</div>
                            <div class="col-9">Fire Pump 3 - Reverse Flow</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        </form>
    </div>
</asp:Content>
<asp:Content ID="scripts" ContentPlaceHolderID="Content_Script" runat="server">
    <script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
    <script>
        let powerUnit = {
            "VRN": "V", "VYN": "V", "VBN": "V", "VRY": "V", "VYB": "V", "VRB": "V", "IR": "V", "IY": "V", "IB": "V", "Real Power": "KW", "Real Power": "kW",
            "APP": "kVA",
            "Reactive Power": "kVAr",
            "Power Factor": "",
            "Energy Consumption": "kWh",
            "Energy Consumed Today": "kWh",
            "Energy Consumed this month": "kWh",
        }
        let panelAnnunciatorArr = ["VCB", "ACB", "DG-1", "DG-2", "Fire Engine"];
        let oilData = [{
            tank: "DG 750kVA",
            capasity: "1000",
            current: "750",
            value: 0.25,
            battery: "5.4",
            mileage: "220",
            arh: "4",
        }, {
            tank: "DG 250kVA",
            capasity: "5000",
            current: "4500",
            value: 0.92,
            battery: "5.4",
            mileage: "220",
            arh: "4",
        }, {
            tank: "Fire Pump 1",
            capasity: "1000",
            current: "750",
            value: 0.85,
            battery: "5.4",
            mileage: "220",
            arh: "4",
        }, {
            tank: "Fire Pump 2",
            capasity: "5000",
            current: "4500",
            value: 0.22,
            battery: "5.4",
            mileage: "220",
            arh: "4",
        }, {
            tank: "Fire Pump 3",
            capasity: "1000",
            current: "750",
            value: 1,
            battery: "5.4",
            mileage: "220",
            arh: "4",
        },];
        let waterData = [{
            tank: "Fire Water Tank 1",
            capasity: "1000",
            current: "750",
            value: 0.25,
        }, {
            tank: "Fire Water Tank 2",
            capasity: "5000",
            current: "4500",
            value: 1,
        }, {
            tank: "Fire Water Tank 3",
            capasity: "1000",
            current: "750",
            value: 0.85,
        },];
        let radial_options_1 = {
            chart: {
                height: 280,
                type: "radialBar",
            },
            series: [75], // replace values
            colors: ["#90EE02"],
            labels: ["R"],
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
                            fontSize: "13px",
                            color: "#D32F2F",
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
        let radial_options_2 = {
            chart: {
                height: 280,
                type: "radialBar",
            },
            series: [85],
            labels: ["R"],
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
                            fontSize: "13px",
                            color: "#D32F2F",
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
            colors: ["#90EE02"],
        };
        let radial_options_3 = {
            chart: {
                height: 280,
                type: "radialBar",
            },
            series: [5],
            labels: ["R"],
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
                            show: true,
                            fontSize: "25px",
                            color: "#D32F2F",
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
            colors: ["#D32F2F"],
        };
        var line_options_1 = {
            chart: {
                type: 'line'
            },
            series: [{
                data: [6, 4, 8, 5, 10, 6, 8] //push values
            }],
            xaxis: {
                categories: [5, 10, 15, 20, 25, 30]
            },
            yaxis: {
                title: {
                    text: "Flow Rate (LPM)",
                    rotate: -90,
                    offsetX: 0,
                    offsetY: 0,
                    style: {
                        color: "#03174f",
                        fontSize: '14px',
                        fontFamily: 'Helvetica, Arial, sans-serif',
                        fontWeight: 600,
                        cssClass: 'pressure-yaxis-title',
                    },
                },
            },
        }
        var line_options_2 = {
            chart: {
                type: 'line'
            },
            series: [{
                data: [600, 400, 800, 120, 1000, 600, 800]
            }],
            xaxis: {
                categories: [5, 10, 15, 20, 25, 30]
            },
            yaxis: {
                title: {
                    text: "Pressure (bar)",
                    rotate: -90,
                    offsetX: 0,
                    offsetY: 0,
                    style: {
                        color: "#03174f",
                        fontSize: '14px',
                        fontFamily: 'Helvetica, Arial, sans-serif',
                        fontWeight: 600,
                        cssClass: 'pressure-yaxis-title',
                    },
                },
            },
        }
        // let series_1 = [75];
        new ApexCharts(document.querySelector("#fire_pump_1"), radial_options_1).render();
        new ApexCharts(document.querySelector("#fire_pump_2"), radial_options_2).render();
        new ApexCharts(document.querySelector("#fire_pump_3"), radial_options_3).render();
        new ApexCharts(document.querySelector("#flow_chart"), line_options_1).render();
        new ApexCharts(document.querySelector("#pressure_chart"), line_options_2).render();

        function powerMonitoring(objData) {
            let powerHTML = "";
            objData["sum"] = [
                { name: "Energy Consumption", value: "2473", unit: "kWh" },
                { name: "Energy Consumed Today", value: "117", unit: "kWh" },
                { name: "Energy Consumed this month", value: "2473", unit: "kWh" },
            ];

            document.getElementById("power_card").innerHTML = "";
            if (!objData.hasOwnProperty("R")) {
                return;
            }
            for (let phase in objData) {
                let border = "border-secondary";
                if (phase == "R") {
                    border = "border-danger";
                } else if (phase == "Y") {
                    border = "border-warning";
                } else if (phase == "B") {
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

        function panelAnnunciator(objData) {
            for (let name in objData) {
                let panelHTML = "";
                panelHTML += `<div class="col-sm-6 col-md-4 col-lg-2 text-center mb-5 mb-lg-2" >`;
                panelHTML += `<div class="row row-cols-5 gx-2 justify-content-center" >`;
                for (let cnt = 0; cnt < objData[name].length; cnt++) {
                    panelHTML += `<div class="col border p-0 text-center" id="${name}_${objData[name][cnt]["SwitchName"]}">${objData[name][cnt]["SwitchName"]}</div>`;
                }
                panelHTML += `</div><strong>${name}</strong></div>`;
                document.getElementById("panel_card").innerHTML += panelHTML;
            }
        }

        function fuelSVG(val, tank) {
            let fillColor = val < 0.3 ? "#B00020" : "#03174f";
            let values = 1 - val
            let percent = (1 - values).toFixed(2) * 100;
            return `
            <svg
    version="1.1"
    id="${tank}_1"
    inkscape:version="1.1.1 (3bf5ae0d25, 2021-09-20)"
    x="0px"
    y="0px"
    viewBox="0 0 320 180"
    xml:space="preserve"
    sodipodi:docname="fuel-tanker.svg"
    width="210"
    height="125"
    xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
    xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
    xmlns="http://www.w3.org/2000/svg"
    xmlns:svg="http://www.w3.org/2000/svg"
  >
    <defs id="${tank}_2" />
    <sodipodi:namedview
      bordercolor="#666666"
      borderopacity="1.0"
      id="${tank}_3"
      inkscape:current-layer="g13"
      inkscape:cx="41.5"
      inkscape:cy="152.5"
      inkscape:document-units="pt"
      inkscape:pagecheckerboard="0"
      inkscape:pageopacity="0.0"
      inkscape:pageshadow="2"
      inkscape:window-height="1001"
      inkscape:window-maximized="1"
      inkscape:window-width="1920"
      inkscape:window-x="-9"
      inkscape:window-y="-9"
      inkscape:zoom="1"
      pagecolor="#ffffff"
      showgrid="false"
    >
    </sodipodi:namedview>
    <defs id="${tank}_4">
      <filter
        id="${tank}_filterId"
        primitiveUnits="objectBoundingBox"
        x="-0.0041029792"
        y="-0.011092992"
        width="1.008206"
        height="1.0247414"
      >
        <feFlood
          x="0%"
          y="0%"
          width="100%"
          height="100%"
          flood-color="${fillColor}"
          id="${tank}_6"
        />
        <feOffset dy="${values}" id="${tank}_7">
          <animate attributeName="dy" from="1" to="${values}" dur="3s" />
        </feOffset>
        <feComposite operator="in" in2="SourceGraphic" id="${tank}_8" />
        <feComposite operator="over" in2="SourceGraphic" id="${tank}_9" />
      </filter>
    </defs>
    <g id="${tank}_10">
      <path
        class="tanker-tank-color"
        filter="url(#${tank}_filterId)"
        d="M 498.24692,226.86334 H 40.953992 c -19.870218,0 -35.849765,-22.1213 -35.849765,-49.20083 V 80.405056 c 0,-27.270227 16.118499,-49.200829 35.849765,-49.200829 H 498.24692 c 19.87021,0 35.84975,22.121303 35.84975,49.200829 v 97.257454 c 0,27.27023 -15.97954,49.20083 -35.84975,49.20083 z"
        style="fill: #ffffff; fill-opacity: 1; stroke: ${fillColor}; stroke-width: 4.34089; stroke-miterlimit: 4; stroke-dasharray: none; stroke-opacity: 1;"
        id="${tank}_11"
        transform="matrix(0.59358856,0,0,0.79752857,1.442579,-8.841446)"
      />

      <rect
        x="46.02108"
        y="3.6000004"
        class="tanker-lid"
        width="33.597111"
        height="12.04268"
        id="${tank}_12"
        style="stroke-width: 1; stroke:${fillColor}; fill:${fillColor}"
      />
      <rect
        x="208.18947"
        y="3.6000004"
        class="tanker-lid"
        width="33.597111"
        height="12.04268"
        id="${tank}_13"
        style="stroke-width: 1; stroke:${fillColor}; fill:${fillColor}"
      />
      <path
        d="m 291.62383,15.961692 v 9.53812 h -27.87662 v -9.53812 h -2.72835 V 173.34066 h 2.72835 v -9.53812 h 27.87662 v 9.53812 h 2.72836 V 15.961692 Z m 0,16.307107 V 47.499023 H 263.74721 V 32.268799 Z M 263.74721,113.18897 V 97.95875 h 27.87662 v 15.23022 z m 27.87662,6.76899 v 15.23022 H 263.74721 V 119.95796 Z M 263.74721,91.34362 V 76.113385 h 27.87662 V 91.34362 Z m 0,-21.999228 V 54.26801 h 27.87662 v 15.230223 h -27.87662 z m 0,87.689158 v -15.07638 h 27.87662 v 15.23022 h -27.87662 z"
        class="tanker-ladder"
        id="${tank}_14"
        style="stroke-width: 1.5; stroke: #f37022"
        fill="#f37022"
      />
      <text
        xml:space="preserve"
        style="
          font-style: normal;
          font-weight: normal;
          font-size: 40px;
          line-height: 1.25;
          font-family: sans-serif;
          fill: #f37022;
          fill-opacity: 1;
          stroke: none;
        "
        x="106"
        y="108"
        id="${tank}_15"
      >
        <tspan sodipodi:role="line" id="tspan1513" x="0" y="108">
          ${percent}%
        </tspan>
      </text>
    </g>
  </svg>
            `
        }

        function fuelMonitoing() {
            let fuelHTML = '';
            for (let cnt = 0; cnt < oilData.length; cnt++) {
                let item = oilData[cnt];
                item.tank = item.tank.replaceAll(' ', '_')
                fuelHTML += `
                <div class="col-sm-6 col-md-4 col-lg-3">
                    <div class="card mb-3">
                        <div class="row g-0">
                            <div class="col-12 text-center iocl-blue-text fw-bold">
                                <strong>${item.tank}</strong>
                                </div>
                                <div class="col-12 text-center mt-3">
                                   ${fuelSVG(item.value, item.tank)}
                                    </div>
                                    <div class="col-12">
                                        <div class="card-body">
                                            <div class="d-flex justify-content-between">
                                                <strong>Capacity</strong>
                                                <strong>${item.capasity} L</strong>
                                                </div>
                                                <div class="d-flex justify-content-between">
                                                    <strong>Current</strong>
                                                    <strong>${item.current} L</strong>
                                                    </div>
                                                <div class="d-flex justify-content-between">
                                                    <strong>Battery</strong>
                                                    <strong>${item.battery} V</strong>
                                                </div>
                                                <div class="d-flex justify-content-between">
                                                    <strong>Mileage</strong>
                                                    <strong>${item.mileage} sec/L</strong>
                                                    </div>
                                                <div class="d-flex justify-content-between">
                                                    <strong>ARH</strong>
                                                    <strong>${item.arh} Hrs</strong>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            `;
            }
            document.getElementById("fuel_monitoring").innerHTML = fuelHTML;
        }

        function waterSVG(val, tank) {
            let fillColor = val < 0.3 ? "#B00020" : "#03174f";
            let values = 1 - val
            let percent = (1 - values).toFixed(2) * 100;
            return `
            <svg
    version="1.1"
    id="${tank}_1"
    inkscape:version="1.1.1 (3bf5ae0d25, 2021-09-20)"
    x="0px"
    y="0px"
    viewBox="0 0 135 165"
    xml:space="preserve"
    sodipodi:docname="water-tank.svg"
    width="135"
    height="165"
    xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
    xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
    xmlns="http://www.w3.org/2000/svg"
    xmlns:svg="http://www.w3.org/2000/svg"
  >
    <sodipodi:namedview
      bordercolor="#666666"
      borderopacity="1.0"
      id="${tank}_2"
      inkscape:current-layer="g159"
      inkscape:cx="49.090393"
      inkscape:cy="65.691501"
      inkscape:document-units="pt"
      inkscape:pagecheckerboard="0"
      inkscape:pageopacity="0.0"
      inkscape:pageshadow="2"
      inkscape:window-height="1001"
      inkscape:window-maximized="1"
      inkscape:window-width="1920"
      inkscape:window-x="-9"
      inkscape:window-y="-9"
      inkscape:zoom="1"
      pagecolor="#ffffff"
      showgrid="false"
    >
    </sodipodi:namedview>
    <defs id="${tank}_4">
      <filter
        id="${tank}_filterId"
        primitiveUnits="objectBoundingBox"
        x="-0.0041029792"
        y="-0.011092992"
        width="1.008206"
        height="1.0247414"
      >
        <feFlood
          x="0%"
          y="0%"
          width="100%"
          height="100%"
          flood-color="${fillColor}"
          id="${tank}_6"
        />
        <feOffset dy="${values}" id="${tank}_7">
          <animate attributeName="dy" from="1" to="${values}" dur="3s" />
        </feOffset>
        <feComposite operator="in" in2="SourceGraphic" id="${tank}_8" />
        <feComposite operator="over" in2="SourceGraphic" id="${tank}_9" />
      </filter>
    </defs>
    <g id="${tank}_10">
      <path
        filter="url(#${tank}_filterId)"
        class="tanker-tank"
        d="m 45.4,15.5 c 0,0 -37,3.6 -38.1,17 -1.1,13.4 0,109.8 0,109.8 0,0 -0.4,8.6 46.2,11.5 4.2,0.7 67.2,0.8 73.6,-10.8 2.8,-4.5 0,-111.8 0,-111.8 -3.8,-16.9 -57.3,-17 -81.7,-15.7 z"
        id="${tank}_11"
        style="fill: #fff; stroke: ${fillColor}; stroke-width: 2;stroke-miterlimit: 10;"
      />
      <g id="${tank}_12" class="lid" inkscape:label="XMLID_1_">
        <path
          class="st1"
          d="m 88.3,10.1 v 4.1 C 88,15.1 80.7,16.8 67,16.8 53.3,16.8 46,15.1 45.7,14.2 V 10.1 C 46,9.2 53.3,7.5 67,7.5 c 13.7,0 21,1.7 21.3,2.6 z"
          id="${tank}_13"
          style="fill: #ffffff"
        />
        <path
          id="${tank}_14"
          class="st2"
          d="M 67,13.8 C 37.8,14 37.8,6.2 67,6.4 c 29.3,-0.2 29.2,7.7 0,7.4 z m 0,-6.3 c -13.7,0 -21,1.7 -21.3,2.6 -0.3,3.2 43,3.2 42.6,0 C 88,9.2 80.7,7.5 67,7.5 Z"
          style="fill:${fillColor}"
        />
        <path
          id="${tank}_15"
          class="st2"
          d="m 74,10.8 c -2,0.1 -0.2,-6.3 -1.1,-7 0,0 -12.9,0 -12.9,0 -0.5,-0.1 0,6 -0.2,6.2 0,1.2 -1.8,1.2 -1.8,0 0,0 0,-6 0,-6 0,-1.1 0.9,-2 1.9,-2 h 12.9 c 1.1,0 2,0.9 2,2 -0.3,0.7 0.8,7 -0.8,6.8 z"
          style="fill: ${fillColor}"
        />
        <path
          class="st2"
          d="M 88.3,14.2 V 10.1 C 88,9.2 80.7,7.5 67,7.5 53.3,7.5 46,9.2 45.7,10.1 v 4.1 c 0.3,0.9 7.6,2.6 21.3,2.6 13.7,0 21,-1.7 21.3,-2.6 z m 1,-4 v 4.1 C 89.3,17.2 74.7,18 67,18 59.3,18 44.7,17.2 44.7,14.3 v -4.1 c 0,-2.9 14.6,-3.7 22.3,-3.7 7.7,0 22.3,0.8 22.3,3.7 z"
          id="${tank}_16"
          style="fill: ${fillColor}"
        />
      </g>
      <path d="M8.4,129.3c0,0,57.8,19.4,118.7,0" style="fill:none; stroke: #ffffff; stroke-width:2; stroke-miterlimit: 10;" />
      <path d="M8.1,66.3c0,0,57.5,19.4,118.3,0" style="fill:none; stroke: #ffffff; stroke-width:2; stroke-miterlimit: 10;" />
      <path d="M8.1,98.3c0,0,57.5,19.4,118.3,0" style="fill:none; stroke: #ffffff; stroke-width:2; stroke-miterlimit: 10;" />
      <path d="M8.4,34.3c0,0,57.4,19.4,118,0" style="fill:none; stroke: #ffffff; stroke-width:2; stroke-miterlimit: 10;" />
      <text
        xml:space="preserve"
        style="
          font-style: normal;
          font-weight: normal;
          font-size: 26px;
          line-height: 1.25;
          font-family: sans-serif;
          fill: #f37022;
          fill-opacity: 1;
          stroke: none;
        "
        x="-30"
        y="98"
      >
        <tspan sodipodi:role="line" id="tspan1513" x="-30" y="98">
          ${percent}%
        </tspan>
      </text>
    </g>
  </svg>
            `
        }

        function waterMonitoring() {
            let waterHTML = '';
            for (let cnt = 0; cnt < waterData.length; cnt++) {
                let item = waterData[cnt];
                item.tank = item.tank.replaceAll(' ', '_');
                waterHTML += `
                <div
                  class="col-sm-6 col-md-4 col-lg-3">
                  <div class="card mb-3">
                    <div class="row g-0">
                      <div class="col-12 text-center iocl-blue-text fw-bold">
                        <strong>${item.tank}</strong>
                      </div>
                      <div class="col-12 text-center mt-3">
                        ${waterSVG(item.value, item.tank)}
                      </div>
                      <div class="col-12">
                        <div class="card-body">
                          <div class="d-flex justify-content-between">
                            <strong>Capacity</strong>
                            <strong>${item.capasity} KL</strong>
                          </div>
                          <div class="d-flex justify-content-between">
                            <strong>Current</strong>
                            <strong>${item.current} KL</strong>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                `;
            }
            document.getElementById("water_monitoring").innerHTML = waterHTML;
        }

        function initDashboard() {
            // powerMonitoring(powerArr);
            // panelAnnunciator();
            fuelMonitoing();
            waterMonitoring();
        }

        initDashboard();
        // ajax method write
    </script>
    <script>
        function loadPowerMonitoringData() {
            let selectedEnergy = $("#<%= EnergyListElement.ClientID %>").val();
            $("#energyElementPrint").html(selectedEnergy)
            $.ajax({
                type: "POST",
                url: "Dashboard.aspx/GetEnergyMeterData",
                data: JSON.stringify({ MeterID: selectedEnergy }),
                contentType: "application/json; charset=utf-8",
            }).done(function (data) {
                let parseData = JSON.parse(data.d);
                if (parseData) {
                    let selectedEnergy = $("#<%= EnergyListElement.ClientID %>").val();
                    let newData = parseData[selectedEnergy][0];
                    let powerData = [];
                    for (let key in newData) {
                        powerData.push({ name: key, value: newData[key], unit: powerUnit[key] });
                    }
                    powerMonitoring(parseData[selectedEnergy])
                } else {
                    alert("Failed to load data");
                }
            });
        }
        function loadPowerMonitoringSwitches() {
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
        function loadPMSTrips() {
            $.ajax({
                type: "POST",
                url: "Dashboard.aspx/GetEMSTrips",
                contentType: "application/json; charset=utf-8",
            }).done(function (data) {
                let parseData = JSON.parse(data.d);
                if (parseData) {
                    $("#panel_card.panel-box.bg-danger").removeClass("bg-danger");
                    for (let cnt = 0; cnt < parseData.length; cnt++) {
                        $("#" + parseData[cnt]["MeterID"] + "_" + parseData[cnt]["SwitchID"]).addClass("bg-danger");
                    }
                } else {
                    alert("Failed to load data");
                }
            });
        }
        function loadPMSTripsAlert() {
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
        function intervalLoading() {
            setInterval(() => {
                loadPowerMonitoringData();
                loadPMSTrips();
                loadPMSTripsAlert();
            }, 30000);
        }
        $(window).on("load", function () {
            $("#<%= EnergyListElement.ClientID %>").prop('selectedIndex', 0);
            loadPowerMonitoringData()
            loadPowerMonitoringSwitches();
            loadPMSTrips();
            loadPMSTripsAlert();
            intervalLoading();
        });
    </script>
</asp:Content>
