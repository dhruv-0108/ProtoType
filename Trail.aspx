<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Trail.aspx.cs" Inherits="ProtoType.Trail" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link id="Link1" href="Assets/css/Utilities.min.css" rel="stylesheet" type="text/css" media="screen" runat="server" />    
    <link href="Content/bootstrap-switch/bootstrap3/bootstrap-switch.min.css" rel="stylesheet" /> 
    
    <script src="/Assets/jqueryui/jquery-1.9.1.js"></script>
    <script src="/Assets/jqueryui/jquery-ui.js"></script> 
     
    
    <script src="/Assets/scripts/bootstrap.min.js"></script>
    <script src="/Assets/scripts/bootstrap-switch.min.js"></script>

    <script src="https://code.highcharts.com/highcharts.js"></script>
    <script src="https://code.highcharts.com/modules/drilldown.js"></script>
    <script srs="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div id="column"></div>
        </div>
    
        </form>
    <script type="text/javascript">

        $(document).ready(function () {
            chartdata('bar');
        })

        function chartdata(displayType) {
            var ArrEquip = [];
            var ArrDur = [];
            $.ajax({
                url: "../WebService/srvChart.asmx/GetData",
                data: '{}',
                dataType: "json",
                type: "POST",
                contentType: "application/json;char=utf-8",
                success: function (response) {
                    console.log(response.data);

                    for (var i = 0; i < response.d.length; i++) {
                        ArrEquip.push(response.d[i].equip);
                        var seriesDur = new Array(response.d[i].equip, parseFloat(response.d[i].dura));
                        ArrDur.push(seriesDur);
                    }
                    console.log(response.data);
                },
                complete: function (response) {
                    InitiateGraph(ArrDur, ArrEquip, displayType);
                }
            })
        }

        function InitiateGraph(durt, equipt, displaytype) {

            Highcharts.chart('one', {
                chart: {
                    height: 200,
                    backgroundColor: null,
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
                            return this.value; // clean, unformatted number for year
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
                    verticalAlign:'middle'
                },
                
                series: [{
                    name: 'equip',
                    data: durt
                }]
            });
        }
    </script>
</body>
</html>
