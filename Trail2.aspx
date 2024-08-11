<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Trail2.aspx.cs" Inherits="ProtoType.Trail2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <script src="/Assets/jqueryui/jquery-1.9.1.js"></script>
    <script src="/Assets/jqueryui/jquery-ui.js"></script>
    <script src="https://code.highcharts.com/highcharts.js"></script>
    <script src="https://code.highcharts.com/modules/drilldown.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:GridView runat="server" ID="mytrial"></asp:GridView>
        </div>
    </form>
   
</body>
</html>
