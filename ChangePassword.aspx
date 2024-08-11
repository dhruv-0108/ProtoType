<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChangePassword.aspx.cs" Inherits="ProtoType.ChangePassword" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>CHANGE PASSWORD</title>
        <link href="Assets/css/Login.css" rel="stylesheet" />
</head>
<body>
    <div id="preloader"><div id="load"></div></div>
        <form id="form1" runat="server" defaultfocus="txtUser" defaultbutton="cmdLogin">
            <div class="divLoginInfo">
                <asp:Label runat="server" ID="Information"></asp:Label></div>

            <div style="background: #035671; height: 50%; left: 0; min-height: 50%; position: absolute; top: 0; width: 100%; z-index: -2">
                <h1>REPORTCRAFT</h1>
            </div>
            <div style="background: dodgerblue; height: 2px; left: 0; position: absolute; top: 50%; width: 100%; z-index: -1"></div>
            <div style="background: #333333; height: 50%; left: 0; min-height: 50%; position: absolute; top: 50%; width: 100%; z-index: -2"></div>
            <div class="login">
                <div class="ribbon-wrapper h2">
                    <div class="ribbon-front">
                        <h2>Change Password</h2>
                    </div>
                    <div class="ribbon-edge-topleft2"></div>
                    <div class="ribbon-edge-bottomleft"></div>
                </div>
                <br/><br/>
                <ul>
                    <li>
                        <asp:TextBox runat="server" ID="txtUser" placeholder="Username" required="" TabIndex="1"></asp:TextBox><a href="#" class=" icon user"></a>
                    </li>
                    <li>
                        <asp:TextBox runat="server" ID="txtOldPassword" TextMode="Password" placeholder="Old Password" required="" TabIndex="2"></asp:TextBox><a href="#" class=" icon lock"></a>
                    </li>
                    <li>
                        <asp:TextBox runat="server" ID="txtNewPassword" TextMode="Password" placeholder="New Password" required="" TabIndex="2"></asp:TextBox><a href="#" class=" icon lock"></a>
                    </li>
                    <li>
                        <asp:TextBox runat="server" ID="txtRetypePassword" TextMode="Password" placeholder="Retype Password" required="" TabIndex="2"></asp:TextBox><a href="#" class=" icon lock"></a>
                    </li>
                </ul>
                &nbsp;<asp:Label runat="server" ID="lblErrorMsg" Text="&nbsp;" CssClass="ErrorMsg"></asp:Label>
                <div class="submit">
                    <asp:Button runat="server" ID="cmdLogin" Text="Change Password" CssClass="submit" OnClick="cmdLogin_Click" TabIndex="3"/>
                </div>
            </div>
        </form>
        <!-- Core JavaScript Files -->
        <script src="Assets/Scripts/jquery-2.1.4.min.js"></script>
        <script src="Assets/Scripts/wow.min.js"></script>
        <!-- Custom Theme JavaScript -->
        <script src="Assets/Scripts/custom.js"></script>
</body>
</html>
