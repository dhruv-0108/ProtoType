<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="UserEntryPage.aspx.cs" Inherits="ProtoType.UserEntryPage" %>

<%@ Register Src="~/Assets/UserControl/DateTimePicker.ascx" TagPrefix="uc1" TagName="DateTimePicker" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cplMain" runat="server">
    <div class="row clearfix">
        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="entrypage" ShowMessageBox="false" ShowSummary="true" EnableClientScript="true" />
    </div>
    <div class="container-fluid">
    <asp:MultiView ID="mvSumuFurnaceTemp" runat="server" ActiveViewIndex="0">

         <asp:View ID="vTransferToExel" runat="server">
            <div align="center">
                <table class="table table-responsive">
                    <tr>
                       <td style="color: red; font-weight: bold">
                           EQUIPMENTS:
                       </td>
                        <td>
                            <asp:DropDownList ID="equipddl" runat="server" CssClass="form-control " AutoPostBack="true">
                            </asp:DropDownList>
                        </td>
                        <td>
                            <asp:RequiredFieldValidator ID="rfequip" runat="server" ErrorMessage="PLEASE SELECT EQUIPMENT" ControlToValidate="equipddl" InitialValue="SELECT EQUIPMENT" ForeColor="Red" ValidationGroup="entrypage"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    
                    <tr>
                        <td style="color: red; font-weight: bold">
                            START DATE:
                        </td>
                        <td>
                            <uc1:DateTimePicker runat="server" ID="txtExecStartDate" Validate="True" sTime="true" />
                        </td>
                        <td>
                            
                        </td>
                    </tr>
                    
                    <tr>
                        <td style="color: red; font-weight: bold">
                            START TIME :
                        </td>
                        <td>
                            <asp:DropDownList ID="DdlStartHr" runat="server" CssClass="form-control " AutoPostBack="true">
                            </asp:DropDownList>
                        </td>
                        <td>
                            <asp:Label ID="lblstarthr" runat="server" CssClass="control-label" Text="Hour"></asp:Label>
                            
                        </td>
                        
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <asp:DropDownList ID="DdlStartMin" runat="server" CssClass="form-control " AutoPostBack="true"  >
                            </asp:DropDownList>
                        </td>
                        <td>
                            <asp:Label ID="lblstartmin" runat="server" CssClass="control-label" Text="Min"></asp:Label>
                        </td>
                        
                    </tr>
                    
                    <tr>
                        <td style="color: red; font-weight: bold">
                            END DATE :
                        </td>
                        <td>
                           <uc1:DateTimePicker runat="server" ID="txtExecEndDate" Validate="True" sTime="true" />
                        </td>
                        
                    </tr>
                    <tr>
                        <td style="color: red; font-weight: bold">
                            END TIME :
                        </td>
                        <td>
                            <asp:DropDownList ID="DdlEndHr" runat="server" CssClass="form-control " AutoPostBack="true">
                            </asp:DropDownList>
                        </td>
                        <td>
                            <asp:Label ID="lblendhr" runat="server" CssClass="control-label" Text="Hour"></asp:Label>
                        </td>
                        
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <asp:DropDownList ID="DdlEndMin" runat="server" CssClass="form-control " AutoPostBack="true">
                            </asp:DropDownList>
                        </td>
                 
                        <td>
                            <asp:Label ID="lblendmin" runat="server" CssClass="control-label" Text="Min"></asp:Label>
                        </td>
                       
                    </tr>
                    
                    <tr>
                        <td></td>
                        <td align="center">
                            <asp:Button ID="UPLOAD" runat="server" CssClass="m-btn green" Text="UPLOAD" OnClick="UPLOAD_Click" ValidationGroup="entrypage" CausesValidation="true" />
                        </td>
                    </tr>
                </table>
            </div>
           

        </asp:View>
    </asp:MultiView>
     <div class="row clearfix" style="font-size: smaller"> 
           
                <div class="row clearfix text-center h4">EMPLOYEE DETAILS</div>
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>
                        <asp:GridView ID="EventGrid" runat="server" CellPadding="0" AllowPaging="false"
                            CssClass="table table-bordered table-striped"
                            ShowFooter="False"
                            EmptyDataText="No Data Available" 
                            AutoGenerateColumns="False"  EditRowStyle-BackColor="LightGray">
                            <Columns>
                                <asp:TemplateField HeaderText="RECORD_ID">
                                    <ItemStyle HorizontalAlign="Center" />
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lblrecord" Text='<%# Bind("record_id") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                
                                <asp:TemplateField HeaderText="EQUIPMENT">
                                    <ItemStyle HorizontalAlign="Center" />
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lblequip" Text='<%# Eval("equip_desc") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                               
                                <asp:TemplateField HeaderText="START DATE">
                                    <ItemStyle HorizontalAlign="Center" />
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lblsd" Text='<%# Eval("start_date","{0:dd-MM-yyyy}") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                               
                                <asp:TemplateField HeaderText="START TIME">
                                    <ItemStyle HorizontalAlign="Center" />
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lblst" Text='<%# Eval("start_time") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="END DATE">
                                    <ItemStyle HorizontalAlign="Center" />
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lbled" Text='<%# Eval("end_date","{0:dd-MM-yyyy}") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                               
                                <asp:TemplateField HeaderText="END TIME">
                                    <ItemStyle HorizontalAlign="Center" />
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lblet" Text='<%# Eval("end_time") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                               
                            </Columns>
                        </asp:GridView>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        
    </div>
</asp:Content>
