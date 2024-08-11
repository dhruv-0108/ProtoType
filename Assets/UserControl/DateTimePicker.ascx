<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DateTimePicker.ascx.cs" Inherits="ProtoType.Assets.UserControl.DateTimePicker" %>
<asp:UpdatePanel runat="server" ID="upDTP">
    <ContentTemplate>
        <table class="table-responsive" >
            <tr>
                <td ><asp:Label ID="lblUCDate" runat="server" CssClass="control-label" Text="Date:" Visible="false"></asp:Label></td>
                <td ><asp:Label ID="TextBox1" runat="server" ReadOnly="True" CssClass="form-control"></asp:Label></td>
                <td >
                    <asp:ImageButton runat="server" ID="Button1" OnClick="Button1_Click" Width="24px" Height="24px" ImageUrl="~/Assets/images/calendar_24.png" CausesValidation="False" ImageAlign="Middle"/>
                    <div style="display: inline; z-index: 10; position:fixed;margin-left:-100px;">
                        <asp:Calendar ID="Calendar1" runat="server" OnSelectionChanged="Calendar1_SelectionChanged" Visible="False" BackColor="White" BorderColor="#3366CC"
                            Font-Names="Arial" Font-Size="10pt" Height="200px" Width="220px" ForeColor="#003399" BorderWidth="1px" DayNameFormat="Shortest"
                            ShowGridLines="True" OnDayRender="Calendar1_DayRender" NextPrevFormat="ShortMonth" CaptionAlign="Top" CellPadding="1">
                            <DayHeaderStyle Height="1px" BackColor="#0099FF" ForeColor="#ffff66" VerticalAlign="Middle" HorizontalAlign="Center" BorderStyle="Groove" />
                            <NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF" />
                            <OtherMonthDayStyle ForeColor="#999999" />
                            <SelectedDayStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" CssClass="alert"/>
                            <SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
                            <TitleStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" BorderColor="#3366CC" BorderWidth="1px" Height="25px" />
                            <TodayDayStyle BackColor="#99CCCC" ForeColor="White" />
                            <WeekendDayStyle BackColor="#99CCFF" />
                        </asp:Calendar>
                    </div>
                </td>
<%--                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Width="100%" Enabled="False" ForeColor="red" ErrorMessage="Select A Date" ControlToValidate="TextBox1" />
                </td>--%>
            </tr>
        </table>
    </ContentTemplate>
</asp:UpdatePanel>