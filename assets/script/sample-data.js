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
    series: [], // replace values
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
    series: [0],
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
    series: [0],
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