<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="EquipmentDetail.aspx.cs" Inherits="ProtoType.EquipmentDetail" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cplMain" runat="server">
     <div class="container-fluid">
        <div class="row clearfix text-center h3" style="margin-top: -5px">
            REGISTER EQUIPMENT

        </div>
         <br />

        <div style="text-align: center">
            <asp:Label runat="server" ID="lblErroMsg" CssClass="alert alert-danger" Visible="False"></asp:Label>
        </div>
         <br />
         <br />
    <table class="table table-responsive" >
            <tr>
                <td>
                    <asp:Label runat="server" CssClass="control-label" Text="FUNCTION DESCRIPTION:"></asp:Label>
               
                </td>
                <td>
                    <asp:DropDownList ID="Ddlfunctiondesc" runat="server" AutoPostBack="true" CssClass="control-label">
                    </asp:DropDownList>
                </td>
                
            </tr>
             <tr>
                <td>
                    <asp:Label runat="server" CssClass="control-label" Text="CODE:"></asp:Label>
               
                </td>
                <td>
                    <asp:TextBox runat="server" ID="tcode" CssClass="form-control"></asp:TextBox>
                </td>
                 
            </tr> 
            <tr>
                <td>
                    <asp:Label runat="server" CssClass="control-label" Text="DESCRIPTION:"></asp:Label>
               
                </td>
                <td>
                    <asp:TextBox runat="server" ID="tdesc" CssClass="form-control"></asp:TextBox>
                </td>
                 
            </tr>
            <tr>
                <td>
                    <asp:Label runat="server" CssClass="control-label" Text="CLASS:"></asp:Label>
               
                </td>
                <td>
                    <asp:DropDownList ID="Ddlequipclass" runat="server" AutoPostBack="true" CssClass="control-label">
                        <asp:ListItem Text="A" Value="A"></asp:ListItem>
                        <asp:ListItem Text="B" Value="B"></asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
                
             <tr>
                <td>
                    <asp:Label runat="server" CssClass="control-label" Text="STATUS:"></asp:Label>
               
                </td>
                <td>
                    <asp:CheckBoxList AutoPostBack="true" runat="server" ID="Chlstatus">
                        <asp:ListItem>OK</asp:ListItem>
                        <asp:ListItem>NOT OK</asp:ListItem>
                    </asp:CheckBoxList>
                </td>  
               
            </tr>
          
        </table>
         <br />
         <div align="center">
             <asp:Button ID="enterbtn" runat="server" CssClass="m-btn green" Text="ENTER" OnClick="enterbtn_Click"/>
         </div>
         <br />
        
        <div class="row clearfix" style="font-size: smaller"> 
           
                <div class="row clearfix text-center h4">EQUIPMENT DETAILS</div>
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>
                        <asp:GridView ID="equipgrid" runat="server" CellPadding="0" AllowPaging="false"
                            CssClass="table table-bordered table-striped"
                            ShowFooter="False"
                            EmptyDataText="No Data Available" 
                            AutoGenerateColumns="False"  EditRowStyle-BackColor="Transparent" OnRowEditing="equipgrid_RowEditing" OnRowCancelingEdit="equipgrid_RowCancelingEdit" OnRowUpdating="equipgrid_RowUpdating" >
                            <Columns>
                                
                                <asp:TemplateField HeaderText="ID" HeaderStyle-ForeColor="White" HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="#333333" HeaderStyle-BorderColor="Black" HeaderStyle-BorderWidth="2px" ItemStyle-Width="10%" ItemStyle-Wrap="true">
                                    <ItemStyle HorizontalAlign="Center" BorderWidth="2px" BorderColor="black" ForeColor="Black" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblid1" runat="server" Text='<%#Eval("record_id") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:Label ID="lblid2" runat="server" Text='<%#Eval("record_id") %>'></asp:Label>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                
                                <asp:TemplateField HeaderText=" FUNCTION CODE" HeaderStyle-ForeColor="White" HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="#333333" HeaderStyle-BorderColor="Black" HeaderStyle-BorderWidth="2px" ItemStyle-Width="10%" ItemStyle-Wrap="true" >
                                    <ItemStyle HorizontalAlign="Center" BorderWidth="2px" BorderColor="black" ForeColor="Black" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblcode" runat="server" Text='<%#Bind("function_code") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtfcode" runat="server" Text='<%#Eval("function_code") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                
                                <asp:TemplateField HeaderText="FUNCTION DESCRIPTION" HeaderStyle-ForeColor="White" HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="#333333" HeaderStyle-BorderColor="Black" HeaderStyle-BorderWidth="2px" ItemStyle-Width="10%" ItemStyle-Wrap="true">
                                    <ItemStyle HorizontalAlign="Center" BorderWidth="2px" BorderColor="black" ForeColor="Black" />
                                    <ItemTemplate>
                                        <asp:Label ID="lbldesc" runat="server" Text='<%#Bind("function_desc") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtfdesc" runat="server" Text='<%#Eval("function_desc") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                
                             <asp:TemplateField HeaderText=" EQUIPMENT CODE" HeaderStyle-ForeColor="White" HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="#333333" HeaderStyle-BorderColor="Black" HeaderStyle-BorderWidth="2px" ItemStyle-Width="10%" ItemStyle-Wrap="true">
                                    <ItemStyle HorizontalAlign="Center" BorderWidth="2px" BorderColor="black" ForeColor="Black" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblecode" runat="server" Text='<%#Bind("equip_code") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtecode" runat="server" Text='<%#Eval("equip_code") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                
                                <asp:TemplateField HeaderText="EQUIPMENT DESCRIPTION" HeaderStyle-ForeColor="White" HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="#333333" HeaderStyle-BorderColor="Black" HeaderStyle-BorderWidth="2px" ItemStyle-Width="10%" ItemStyle-Wrap="true">
                                    <ItemStyle HorizontalAlign="Center" BorderWidth="2px" BorderColor="black" ForeColor="Black" />
                                    <ItemTemplate>
                                        <asp:Label ID="lbledesc" runat="server" Text='<%#Bind("equip_desc") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtedesc" runat="server" Text='<%#Eval("equip_desc") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="EQUIPMENT CLASS" HeaderStyle-ForeColor="White" HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="#333333" HeaderStyle-BorderColor="Black" HeaderStyle-BorderWidth="2px" ItemStyle-Width="10%" ItemStyle-Wrap="true">
                                    <ItemStyle HorizontalAlign="Center" BorderWidth="2px" BorderColor="black" ForeColor="Black" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblclass" runat="server" Text='<%#Bind("equip_class") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtclass" runat="server" Text='<%#Eval("equip_class") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                               
                                <asp:TemplateField HeaderText="STATUS" HeaderStyle-ForeColor="White" HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="#333333" HeaderStyle-BorderColor="Black" HeaderStyle-BorderWidth="2px" ItemStyle-Width="10%" ItemStyle-Wrap="true">
                                    <ItemStyle HorizontalAlign="Center" BorderWidth="2px" BorderColor="black" VerticalAlign="Middle" ForeColor="Black"/>
                                    
                                    <ItemTemplate>
                                        <asp:CheckBox ID="oke" runat="server" text="OK" enabled="false" Checked='<%# (Eval("active_status").ToString()=="1" ? true : false) %>'/><br />
                                        <asp:CheckBox ID="notoke" runat="server" text="NOT OK" enabled="false" Checked='<%# (Eval("active_status").ToString()=="0" ? true : false) %>'/>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:CheckBoxList ID="cblstatus" runat="server" AutoPostBack="true">
                                            <asp:ListItem>OK</asp:ListItem>
                                            <asp:ListItem>NOT OK</asp:ListItem>
                                        </asp:CheckBoxList>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                
                                <asp:TemplateField HeaderText="ACTION" HeaderStyle-ForeColor="White" HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="#333333" HeaderStyle-BorderColor="Black" HeaderStyle-BorderWidth="2px" ItemStyle-Width="10%" ItemStyle-Wrap="true">
                                     <ItemStyle HorizontalAlign="Center" BorderWidth="2px" BorderColor="black" ForeColor="Black" />
                                    <ItemTemplate>
                                        <asp:LinkButton ID="editbtn" Font-Size="Small" runat="server" CommandName="Edit" Text="EDIT" CssClass="btn btn-success"></asp:LinkButton>
                                    
                                     
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:LinkButton ID="updatebtn" runat="server" Font-Size="Small" CommandName="Update" Text="UPDATE" CssClass="btn btn-success"></asp:LinkButton>
                                        
                                        <asp:LinkButton ID="cancebtn" runat="server" Font-Size="Small" CommandName="Cancel" Text="CANCEL" CssClass="btn btn-danger"></asp:LinkButton>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        
    </div>
</asp:Content>
