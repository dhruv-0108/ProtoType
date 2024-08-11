<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="DataDisplay.aspx.cs" Inherits="ProtoType.DataDisplay" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cplMain" runat="server">
    <div class="row clearfix" style="font-size: smaller"> 
      <asp:UpdatePanel ID="UpdatePanel2" runat="server">
         <ContentTemplate>
                <asp:GridView ID="GVDevent" runat="server" CellPadding="2" CssClass="table table-bordered table-striped" AutoGenerateColumns="False" OnRowUpdating="GVDevent_RowUpdating">
                    <Columns>
                       <asp:TemplateField HeaderText="ID" HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="LightBlue" HeaderStyle-BorderColor="Black" HeaderStyle-BorderWidth="1px" ItemStyle-Width="60px" ItemStyle-Wrap="true">
                           <ItemStyle HorizontalAlign="Center" />
                           <ItemTemplate>
                               <asp:TextBox ID="lblid" runat="server" Text='<%# Bind("record_id") %>'></asp:TextBox>
                           </ItemTemplate>
                       </asp:TemplateField>

                        <asp:TemplateField HeaderText="EQUIPMENT" HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="LightBlue" HeaderStyle-BorderColor="Black" HeaderStyle-BorderWidth="1px" ItemStyle-Width="60px" ItemStyle-Wrap="true">
                           
                            <ItemTemplate>
                               <asp:TextBox ID="lblequip" runat="server" Text='<%# Bind("equip_desc") %>' ></asp:TextBox>
                           </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField HeaderText="START DATE" HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="LightBlue" HeaderStyle-BorderColor="Black" HeaderStyle-BorderWidth="1px" ItemStyle-Width="60px" ItemStyle-Wrap="true">
                           <ItemTemplate>
                               <asp:TextBox ID="lblsdate" runat="server" Text='<%# Bind("start_date","{0:dd-MM-yyyy}") %>' ></asp:TextBox>
                           </ItemTemplate>
                       </asp:TemplateField>

                        <asp:TemplateField HeaderText="START TIME" HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="LightBlue" HeaderStyle-BorderColor="Black" HeaderStyle-BorderWidth="1px" ItemStyle-Width="60px" ItemStyle-Wrap="true">
                           <ItemTemplate>
                               <asp:TextBox ID="lblstime" runat="server" Text='<%# Bind("start_time") %>' ></asp:TextBox>
                           </ItemTemplate>
                       </asp:TemplateField>

                        <asp:TemplateField HeaderText="END DATE" HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="LightBlue" HeaderStyle-BorderColor="Black" HeaderStyle-BorderWidth="1px" ItemStyle-Width="60px" ItemStyle-Wrap="true">
                           <ItemTemplate>
                               <asp:TextBox ID="lbledate" runat="server" Text='<%# Bind("end_date","{0:dd-MM-yyyy}") %>' ></asp:TextBox>
                           </ItemTemplate>
                       </asp:TemplateField>

                        <asp:TemplateField HeaderText="END TIME" HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="LightBlue" HeaderStyle-BorderColor="Black" HeaderStyle-BorderWidth="1px" ItemStyle-Width="60px" ItemStyle-Wrap="true">
                           <ItemTemplate>
                               <asp:TextBox ID="lbletime" runat="server" Text='<%# Bind("end_time") %>' ></asp:TextBox>
                           </ItemTemplate>
                       </asp:TemplateField>

                        <asp:TemplateField HeaderText="DURATION" HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="LightBlue" HeaderStyle-BorderColor="Black" HeaderStyle-BorderWidth="1px" ItemStyle-Width="60px" ItemStyle-Wrap="true">
                           <ItemTemplate>
                               <asp:TextBox ID="lbldur" runat="server" Text='<%# Bind("duration_min") %>' ></asp:TextBox>
                           </ItemTemplate>
                       </asp:TemplateField>

                        <asp:TemplateField HeaderText="PROCESS" HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="LightBlue" HeaderStyle-BorderColor="Black" HeaderStyle-BorderWidth="1px" ItemStyle-Width="60px" ItemStyle-Wrap="true">
                            <ItemTemplate>
                                 <asp:Button ID="editbtn" runat="server" Text="PROCESS" CommandName="Update"/>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
        </ContentTemplate>
      </asp:UpdatePanel>
    </div>
</asp:Content>
