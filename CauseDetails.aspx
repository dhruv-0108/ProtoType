<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="CauseDetails.aspx.cs" Inherits="ProtoType.CauseDetails" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cplMain" runat="server">
    <div class="container-fluid">
        <div class="row clearfix text-center h3" style="margin-top: -5px">REGISTER NEW CAUSE</div>
        <br />
        <div style="text-align: center">
            <asp:Label runat="server" ID="lblErroMsg" CssClass="alert alert-danger" Visible="False"></asp:Label>
        </div>
        <br />
        <br />
           <table style="text-align: left; margin: 0 auto;" class="table table-responsive" >
            <tr>
                <td>
                   <asp:Label ID="lcode" runat="server" CssClass="control-label" Text="CODE:"></asp:Label>

                </td>
                <td>
                    <asp:TextBox runat="server" ID="tcode" CssClass="form-control"></asp:TextBox>
                </td>
                
            </tr>
             <tr>
                <td>
                    <asp:Label ID="ldesc" runat="server" CssClass="control-label" Text="DESCRIPTION:"></asp:Label>

                </td>
                <td>
                    <asp:TextBox runat="server" ID="tdesc" CssClass="form-control"></asp:TextBox>
                </td>
                 
            </tr>
             
             <tr>
                <td>
                    <asp:Label runat="server" CssClass="control-label" Text="STATUS:"></asp:Label>
               
                </td>
                <td>
                    <asp:CheckBoxList AutoPostBack="true" runat="server" ID="Chlstatus">
                        <asp:ListItem>ACTIVE</asp:ListItem>
                        <asp:ListItem>INACTIVE</asp:ListItem>
                    </asp:CheckBoxList>
                </td>  
              
            </tr>
        
        </table>

        <div class="row clearfix">
            <div align="center">
                <asp:Button ID="enterbtn" runat="server" CssClass="btn btn-success" Text="ENTER" OnClick="enterbtn_Click"/>
                </div>
            </div>
        <br />
        <br />
        <div class="row clearfix" style="font-size: smaller"> 
           
                <div class="row clearfix text-center h4">CAUSE DETAILS</div>
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>
                        <asp:GridView ID="causegrid" runat="server" CellPadding="0" AllowPaging="false" ShowFooter="False" EmptyDataText="No Data Available" AutoGenerateColumns="False" EditRowStyle-BackColor="Transparent" OnRowCancelingEdit="causegrid_RowCancelingEdit" OnRowEditing="causegrid_RowEditing" OnRowUpdating="causegrid_RowUpdating" BorderWidth="2px" BorderColor="Black" >
                <Columns>
                    <asp:TemplateField HeaderText="ID" HeaderStyle-ForeColor="White" HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="#333333" HeaderStyle-BorderColor="Black" HeaderStyle-BorderWidth="2px" ItemStyle-Width="10%" ItemStyle-Wrap="true">
                        <ItemStyle HorizontalAlign="Center" BorderWidth="2px" BorderColor="black" ForeColor="Black" Height="10px" />
                        <ItemTemplate>
                            <asp:Label ID="lblid1" runat="server" Text='<%#Eval("record_id") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:Label ID="lblid2" runat="server" Text='<%#Eval("record_id") %>'></asp:Label>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="CODE" HeaderStyle-ForeColor="White" HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="#333333" HeaderStyle-BorderColor="Black" HeaderStyle-BorderWidth="2px" ItemStyle-Width="10%" ItemStyle-Wrap="true">

                        <ItemStyle HorizontalAlign="Center" BorderWidth="2px" BorderColor="black" ForeColor="Black" />
                        <ItemTemplate>
                            <asp:Label ID="lblcode" runat="server" Text='<%#Bind("cause_code") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtcode" runat="server" Text='<%#Eval("cause_code") %>'></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="DESCRIPTION" HeaderStyle-ForeColor="White" HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="#333333" HeaderStyle-BorderColor="Black" HeaderStyle-BorderWidth="2px" ItemStyle-Width="10%" ItemStyle-Height="10px" ItemStyle-Wrap="true">
                        <ItemStyle HorizontalAlign="Center" BorderWidth="2px" BorderColor="black" ForeColor="Black"/>
                        <ItemTemplate>
                            <asp:Label ID="lbldesc" runat="server" Text='<%#Bind("cause_description") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtdesc" runat="server" Text='<%#Eval("cause_description") %>'></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="status" HeaderStyle-ForeColor="White" HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="#333333" HeaderStyle-BorderColor="Black" HeaderStyle-BorderWidth="2px" ItemStyle-Width="10%" ItemStyle-Wrap="true">
                        <ItemStyle HorizontalAlign="Center" BorderWidth="2px" BorderColor="black" VerticalAlign="Middle" ForeColor="Black"/>
                        <ItemTemplate>
                            <asp:CheckBox ID="workinge" runat="server" text="ACTIVE" enabled="false" Checked='<%# (Eval("active_status").ToString()=="1" ? true : false) %>'/><br />
                            <asp:CheckBox ID="lefte" runat="server" text="INACTIVE" enabled="false" Checked='<%# (Eval("active_status").ToString()=="0" ? true : false) %>'/>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:CheckBoxList ID="cblstatus" runat="server" AutoPostBack="true">
                                <asp:ListItem>ACTIVE</asp:ListItem>
                                <asp:ListItem>INACTIVE</asp:ListItem>
                            </asp:CheckBoxList>
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Action" HeaderStyle-ForeColor="White" HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="#333333" HeaderStyle-BorderColor="Black" HeaderStyle-BorderWidth="2px" ItemStyle-Width="15%" ItemStyle-Wrap="true">

                        <ItemStyle HorizontalAlign="Center" BorderWidth="2px" BorderColor="black" ForeColor="Black" />
                        <ItemTemplate>
                            <asp:LinkButton ID="editbtn" Font-Size="Small" runat="server" CommandName="Edit" Text="EDIT" CssClass="btn btn-success"></asp:LinkButton>
                        </ItemTemplate>
                        <EditItemTemplate>
                             <div style="display: flex; justify-content: center;">
                            <asp:LinkButton ID="updatebtn" runat="server" Font-Size="Small" CommandName="Update" Text="UPDATE" CssClass="btn btn-success" ></asp:LinkButton>
                            <asp:LinkButton ID="cancebtn" runat="server" Font-Size="Small" CommandName="Cancel" Text="CANCEL" CssClass="btn btn-danger"></asp:LinkButton>
                                 </div>
                        </EditItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        
    </div>
</asp:Content>
