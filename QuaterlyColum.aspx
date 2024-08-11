<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="QuaterlyColum.aspx.cs" Inherits="ProtoType.QuaterlyColum" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.highcharts.com/highcharts.js"></script>
    <script src="https://code.highcharts.com/modules/drilldown.js"></script>
    <script src="https://code.highcharts.com/modules/accessibility.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cplMain" runat="server">
    <div class="row clearfix">
        <asp:Button runat="server" ID="returnbtn" Text="RETURN" OnClick="returnbtn_Click" />
        </div>
    <div class="row clearfix">
            <div class="form-group col-sm-2">
                
            </div>
            
            <div class="form-group col-sm-2">
                <asp:Label ID="Label1" runat="server" CssClass="control-label" Text="Maintenance Type :"></asp:Label>
                <asp:DropDownList ID="ddlmaint" runat="server" CssClass="form-control " AutoPostBack="false" OnSelectedIndexChanged="ddlmaint_SelectedIndexChanged">
                    
                </asp:DropDownList>
            </div>
         
            <div class="form-group col-sm-2">
                <asp:Label ID="Label7" runat="server" CssClass="control-label" Text="Equipment Class :"></asp:Label>
                <asp:DropDownList ID="ddlequipclass" runat="server" CssClass="form-control " AutoPostBack="false" OnSelectedIndexChanged="ddlequipclass_SelectedIndexChanged" >
                </asp:DropDownList>
               
            </div>
            <div class="form-group col-sm-2">
                <asp:Label ID="Label2" runat="server" CssClass="control-label" Text="Responsible Department:"></asp:Label>
                <asp:DropDownList ID="ddlResponsible" runat="server" CssClass="form-control " AutoPostBack="false" OnSelectedIndexChanged="ddlResponsible_SelectedIndexChanged" >
                </asp:DropDownList>
               
            </div>
    </div>
    <div class="row clearfix">
         <div align="center">
                <asp:Label ID="GraphDetail" runat="server" CssClass="control-label"></asp:Label>
         </div>
    </div>
    <div class="row clearfix">
           <div id="one"></div>
    
           <div id="container"></div>
     </div>
    
    <div id = "backdiv" align="center">
            <asp:Button ID="btnback" runat="server" Text="BACK" OnClientClick="back()"/>
    </div>
    
    <script type="text/javascript">
        $(document).ready(function () {
            $('#<%= ddlmaint.ClientID %>').change(function () {
                var selectedValue = $(this).val();
                console.log(selectedValue);

                chartdata('column', '', selectedValue, '', '')
            });

            $('#<%= ddlequipclass.ClientID %>').change(function () {
                var selectedValueEC = $(this).val();
                console.log(selectedValueEC);
                chartdata('column', '', '', selectedValueEC, '')
            });

            $('#<%= ddlResponsible.ClientID %>').change(function () {
                var selectedValueRD = $(this).val();
                console.log(selectedValueRD);
                chartdata('column', '', '', '', selectedValueRD)
            });

            var sv = '<%= Session["SelectedValue"] %>';
            var svEC = '<%= Session["SelectedValueEC"] %>';
            var svRD = '<%= Session["SelectedValueRD"] %>';

            if (sv !== '' && svRD == '' && svEC == '') {

                chartdata('column', '', sv,'','');
            }
            if (sv == '' && svRD !== '' && svEC=='') {

                chartdata('column', '', '', '',svRD);
            }
            if (sv == '' && svRD == '' && svEC !== '') {

                chartdata('column', '', '', svEC, '');
            }
            else {
                chartdata('column', '', '','','');
            }
            
        });

        function chartdata(displayType, department, selectedValue, selectedValueEC,selectedValueRD) {
            var ArrEquip = [];
            var ArrDur = [];
            var seriesData = [];
            var drilldownSeries = [];
            var label = document.getElementById('<%= GraphDetail.ClientID %>');

            var methodName;
            if (selectedValue == '' && selectedValueRD == '' && selectedValueEC == '') {
                label.innerHTML = "UNFILTERED GRAPH";
                methodName = 'ShowDept';
            }

            if (selectedValue !== '' && selectedValueRD == '' && selectedValueEC == '') {
                label.innerHTML = "GRAPH FILTERED WITH MAINTENANCE TYPE";
                methodName = 'ShowDept2';
            }
            if (selectedValue == '' && selectedValueRD == '' && !selectedValueEC == '') {
                label.innerHTML = "GRAPH FILTERED WITH EQUIPMENT CLASS";
                methodName = 'ShowDept4';
            }
            if (selectedValue == '' && selectedValueRD !== '' && selectedValueEC == '') {
                label.innerHTML = "GRAPH FILTERED WITH RESPONSIBLE DEPARTMENT";
                methodName = 'ShowDept3';
            }

            var requestData;
            if (selectedValue == '' && selectedValueRD == '' && selectedValueEC == '') {

                requestData = {};
            }

            if (selectedValue !== '' && selectedValueRD == '' && selectedValueEC == '') {
                requestData = { maintenanceCode: selectedValue };
            }
            if (selectedValue == '' && selectedValueRD == '' && selectedValueEC !== '') {
                requestData = { eqclass: selectedValueEC };
            }
            if (selectedValue == '' && selectedValueRD !== '' && selectedValueEC == '') {
                requestData = { rdeptCode: selectedValueRD };
            }



            $.ajax({
                url: "QuaterlyColum.aspx/" + methodName,
                data: JSON.stringify(requestData),
                dataType: "json",
                type: "POST",
                contentType: "application/json;char=utf-8",
                success: function (response) {
                    console.log(response.d);

                    for (var i = 0; i < response.d.length; i++) {
                        ArrEquip.push(response.d[i].fdesc);
                        var seriesDur = new Array(response.d[i].fdesc, parseFloat(response.d[i].dura));
                        console.log(response.d[i].fdesc);
                        ArrDur.push(seriesDur);

                        var drilldownData = [];
                        if (response.d[i].drilldown && response.d[i].drilldown.length > 0) {
                            for (var j = 0; j < response.d[i].drilldown.length; j++) {
                                var item = response.d[i].drilldown[j];
                                drilldownData.push({
                                    name: item.name,
                                    y: item.y
                                });
                            }
                        }

                        seriesData.push({
                            name: response.d[i].fdesc,
                            y: response.d[i].dura,
                            drilldown: drilldownData.length > 0 ? response.d[i].fdesc : null
                        });

                        if (drilldownData.length > 0) {
                            drilldownSeries.push({
                                id: response.d[i].fdesc,
                                data: drilldownData
                            });
                        }
                    }
                    console.log(ArrDur);

                    // Call ShowEquipment method for the selected department
                    if (department) {
                        loadEquipmentDowntime(department, selectedValue, selectedValueRD);
                    }
                },
                complete: function (response) {
                    InitiateGraph(ArrDur, ArrEquip, displayType, seriesData, drilldownSeries, selectedValue, selectedValueEC,selectedValueRD);
                    $("#backdiv").hide();
                }
            });
        }

        function InitiateGraph(data, equipt, displaytype, seriesData, drilldownSeries, selectedValue, selectedValueEC,selectedValueRD) {
            var chart = Highcharts.chart('one', {
                chart: {
                    type: displaytype
                },
                title: {
                    text: 'DURATION'
                },
                subtitle: {
                    text: 'Source'
                },
                xAxis: {
                    categories: equipt,
                    labels: {
                        formatter: function () {
                            return this.value;
                        }
                    }
                },
                yAxis: {
                    title: {
                        text: 'DURATION IN MINUTES'
                    }
                },
                legend: {
                    layout: 'vertical',
                    align: 'right',
                    verticalAlign: 'middle'
                },
                series: [{
                    name: 'equip',
                    data: seriesData,
                    drilldown: drilldownSeries.length > 0 ? 'equip' : null
                }],
                drilldown: {
                    series: drilldownSeries
                }
            });

            // Add event listener for department click
            chart.series[0].points.forEach(function (point) {
                point.graphic.element.addEventListener('click', function () {
                    loadEquipmentDowntime(point.name, selectedValue, selectedValueEC,selectedValueRD);
                });
            });
        }

        function loadEquipmentDowntime(department, maintenanceCode,eqclass,rdeptCode) {

            var label = document.getElementById('<%= GraphDetail.ClientID %>');

            var methodName;
            if (maintenanceCode == '' && rdeptCode == '' && eqclass == '') {

                methodName = 'ShowEquipment';
            }

            if (maintenanceCode !== '' && rdeptCode == '' && eqclass == '') {
                label.innerHTML = "GRAPH FILTERED WITH MAINTENANCE TYPE" + maintenanceCode + " AND" + department + "DEPARTMENT";
                methodName = 'ShowEquipment2';
            }
            if (maintenanceCode == '' && rdeptCode == '' && eqclass !== '') {
                label.innerHTML = "GRAPH FILTERED WITH EQUIPMENT CLASS" + eqclass + " AND" + department + "DEPARTMENT";
                methodName = 'ShowEquipment4';
            }
            if (maintenanceCode == '' && rdeptCode !== '' && eqclass == '') {
                label.innerHTML = "GRAPH FILTERED WITH RESPONSIBLE DEPARTMENT" + rdeptCode + " AND" + department + "DEPARTMENT";
                methodName = 'ShowEquipment3';
            }

            var requestData;
            if (maintenanceCode == '' && rdeptCode == '' && eqclass == '') {

                requestData = { department: department };
            }

            if (maintenanceCode !== '' && rdeptCode == '' && eqclass == '') {
                requestData = { department: department, maintenanceCode: maintenanceCode };
            }
            if (maintenanceCode == '' && rdeptCode == '' && eqclass !== '') {
                requestData = { department: department, eqclass: eqclass };
            }
            if (maintenanceCode == '' && rdeptCode !== '' && eqclass == '') {
                requestData = { department: department, rdeptCode: rdeptCode };
            }

            $.ajax({
                url: "QuaterlyColum.aspx/" + methodName,
                data: JSON.stringify(requestData),
                dataType: "json",
                type: "POST",
                contentType: "application/json;char=utf-8",
                success: function (response) {
                    var equipmentData = [];
                    for (var i = 0; i < response.d.length; i++) {
                        equipmentData.push({
                            name: response.d[i].equip,
                            y: parseFloat(response.d[i].dura)
                        });
                    }

                    // Create a new chart with drilldown equipment data
                    var drilldownChart = Highcharts.chart('container', {
                        chart: {
                            type: 'column'
                        },
                        title: {
                            text: 'Equipment Downtime for Department: ' + department
                        },
                        xAxis: {
                            type: 'category'
                        },
                        yAxis: {
                            title: {
                                text: 'DURATION IN MINUTES'
                            }
                        },
                        legend: {
                            enabled: false
                        },
                        series: [{
                            name: 'Equipment',
                            colorByPoint: true,
                            data: equipmentData
                        }]
                    });



                    // Hide the department-downtime chart
                    $('#one').hide();
                    $('#backdiv').show();

                }
            });
        }
        function back() {
            $('#one').show();
            $("#container").empty();
            $('#backdiv').hide();
        }
    </script>
</asp:Content>
