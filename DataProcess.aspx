﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="DataProcess.aspx.cs" Inherits="ProtoType.DataProcess" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script srs="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cplMain" runat="server">
    <div align="center">
        <asp:Button ID="btnreturn" runat="server" Text="RETURN" CssClass="btn btn-success" OnClick="btnreturn_Click"/>
    </div>

    <div class="row clearfix" style="font-size: smaller"> 
      <asp:GridView ID="GVDprocess" runat="server" CellPadding="2"
            CssClass="table table-bordered table-striped" AutoGenerateColumns="false" OnRowUpdating="GVDprocess_RowUpdating" OnRowEditing="GVDprocess_RowEditing" OnRowCommand="GVDprocess_RowCommand">
                      <Columns>
                           <asp:TemplateField HeaderText="ID" HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="LightBlue" HeaderStyle-BorderColor="Black" HeaderStyle-BorderWidth="1px" ItemStyle-Width="60px" ItemStyle-Wrap="true">
                              <ItemStyle HorizontalAlign="Center" />
                               <ItemTemplate>
                                   <asp:TextBox runat="server" ID="lblrid" Text='<%# Bind("rid") %>'></asp:TextBox>
                               </ItemTemplate>
                              <EditItemTemplate>
                                  <asp:TextBox runat="server" ID="lblrid2" Text='<%# Bind("rid") %>' ></asp:TextBox>
                               </ItemTemplate>
                              </EditItemTemplate>
                           </asp:TemplateField>


                           <asp:TemplateField HeaderText="EQUIPMENT" HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="LightBlue" HeaderStyle-BorderColor="Black" HeaderStyle-BorderWidth="1px" ItemStyle-Width="60px" ItemStyle-Wrap="true">
                               <ItemStyle HorizontalAlign="Center" />
                               <ItemTemplate>
                                   <asp:TextBox runat="server" ID="lblequip" Text='<%# Bind("equip_desc") %>'></asp:TextBox>
                               </ItemTemplate>
                               <EditItemTemplate>
                                   <asp:TextBox runat="server" ID="lblequip2" Text='<%# Bind("equip_desc") %>'></asp:TextBox>
                               </EditItemTemplate>
                           </asp:TemplateField>

                         <asp:TemplateField HeaderText="START DATE" HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="LightBlue" HeaderStyle-BorderColor="Black" HeaderStyle-BorderWidth="1px" ItemStyle-Width="60px" ItemStyle-Wrap="true">
                             <ItemStyle HorizontalAlign="Center" />  
                             <ItemTemplate>
                                   <asp:TextBox runat="server" ID="lblsdate" Text='<%# Bind("start_date","{0:dd-MM-yyyy}") %>'></asp:TextBox>
                               </ItemTemplate>
                             <EditItemTemplate>
                                 <asp:TextBox runat="server" ID="lblsdate2" Text='<%# Bind("start_date","{0:dd-MM-yyyy}") %>'></asp:TextBox>
                             </EditItemTemplate>
                           </asp:TemplateField>

                          <asp:TemplateField HeaderText="START TIME" HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="LightBlue" HeaderStyle-BorderColor="Black" HeaderStyle-BorderWidth="1px" ItemStyle-Width="60px" ItemStyle-Wrap="true">
                              <ItemStyle HorizontalAlign="Center" /> 
                              <ItemTemplate>
                                   <asp:TextBox runat="server" ID="lblstime" Text='<%# Bind("start_time") %>'></asp:TextBox>
                               </ItemTemplate>
                              <EditItemTemplate>
                                  <asp:TextBox runat="server" ID="lblstime2" Text='<%# Bind("start_time") %>'></asp:TextBox>
                              </EditItemTemplate>
                           </asp:TemplateField>

                          <asp:TemplateField HeaderText="END DATE" HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="LightBlue" HeaderStyle-BorderColor="Black" HeaderStyle-BorderWidth="1px" ItemStyle-Width="60px" ItemStyle-Wrap="true">
                              <ItemStyle HorizontalAlign="Center" /> 
                              <ItemTemplate>
                                   <asp:TextBox runat="server" ID="lbledate" Text='<%# Bind("end_date","{0:dd-MM-yyyy}") %>'></asp:TextBox>
                               </ItemTemplate>
                              <EditItemTemplate>
                                  <asp:TextBox runat="server" ID="lbledate2" Text='<%# Bind("end_date","{0:dd-MM-yyyy}") %>'></asp:TextBox>
                              </EditItemTemplate>
                           </asp:TemplateField>
                          
                          <asp:TemplateField HeaderText="END TIME" HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="LightBlue" HeaderStyle-BorderColor="Black" HeaderStyle-BorderWidth="1px" ItemStyle-Width="60px" ItemStyle-Wrap="true">
                              <ItemStyle HorizontalAlign="Center" /> 
                              <ItemTemplate>
                                   <asp:TextBox runat="server" ID="lbletime" Text='<%# Bind("end_time") %>'></asp:TextBox>
                               </ItemTemplate>
                              <EditItemTemplate>
                                  <asp:TextBox runat="server" ID="lbletime2" Text='<%# Bind("end_time") %>'></asp:TextBox>
                              </EditItemTemplate>
                           </asp:TemplateField>
                          <asp:TemplateField HeaderText="DURATION" HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="LightBlue" HeaderStyle-BorderColor="Black" HeaderStyle-BorderWidth="1px" ItemStyle-Width="60px" ItemStyle-Wrap="true">
                              <ItemStyle HorizontalAlign="Center" /> 
                              <ItemTemplate>
                                   <asp:TextBox runat="server" ID="lbldur" Text='<%# Bind("duration_min") %>'></asp:TextBox>
                               </ItemTemplate>
                              <EditItemTemplate>
                                   <asp:TextBox runat="server" ID="lbldur2" Text='<%# Bind("duration_min") %>'></asp:TextBox>
                              </EditItemTemplate>
                           </asp:TemplateField>
                           <asp:TemplateField HeaderText="MAINTENANCE" HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="LightBlue" HeaderStyle-BorderColor="Black" HeaderStyle-BorderWidth="1px" ItemStyle-Width="60px" ItemStyle-Wrap="true">
                               <ItemStyle HorizontalAlign="Center" />
                               <ItemTemplate>
                                   <asp:TextBox runat="server" ID="lblmcode" Text='<%# Bind("maint_code") %>'></asp:TextBox>
                               </ItemTemplate>
                               <EditItemTemplate>
                                   <asp:TextBox runat="server" ID="lblmcode2" Text='<%# Bind("maint_code") %>'></asp:TextBox>
                               </EditItemTemplate>
                           </asp:TemplateField>
                           <asp:TemplateField HeaderText="CAUSE" HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="LightBlue" HeaderStyle-BorderColor="Black" HeaderStyle-BorderWidth="1px" ItemStyle-Width="60px" ItemStyle-Wrap="true">
                               <ItemStyle HorizontalAlign="Center" />
                               <ItemTemplate>
                                   <asp:TextBox runat="server" ID="lblccode" Text='<%# Bind("cause_code") %>'></asp:TextBox>
                               </ItemTemplate>
                               <EditItemTemplate>
                                   <asp:TextBox runat="server" ID="lblccode2" Text='<%# Bind("cause_code") %>'></asp:TextBox>
                               </EditItemTemplate>
                           </asp:TemplateField>
                          <asp:TemplateField HeaderText="RESPONSIBLE" HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="LightBlue" HeaderStyle-BorderColor="Black" HeaderStyle-BorderWidth="1px" ItemStyle-Width="60px" ItemStyle-Wrap="true">
                              <ItemStyle HorizontalAlign="Center" /> 
                              <ItemTemplate>
                                   <asp:TextBox runat="server" ID="lblrdcode" Text='<%# Bind("dept_code") %>'></asp:TextBox>
                               </ItemTemplate>
                              <EditItemTemplate>
                                   <asp:TextBox runat="server" ID="lblrdcode2" Text='<%# Bind("dept_code") %>'></asp:TextBox>
                              </EditItemTemplate>
                           </asp:TemplateField>
                          <asp:TemplateField HeaderText="ACTION" HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="LightBlue" HeaderStyle-BorderColor="Black" HeaderStyle-BorderWidth="1px" ItemStyle-Width="60px" ItemStyle-Wrap="true">
                              <ItemStyle HorizontalAlign="Center" />
                              <ItemTemplate>
                                  <asp:Button ID="btnedit" runat="server" Text="EDIT" CommandName="Edit" />
                             
                              </ItemTemplate>
                              <EditItemTemplate>
                                  <asp:Button ID="btnupdate" runat="server" Text="UPDATE" CommandName="Update" />
                                   <asp:Button ID="btnsplit" runat="server" Text="SPLIT" Visible="false" CommandName="Insert" OnClientClick='return confirmDelete();'/>
                              </EditItemTemplate>
                          </asp:TemplateField>
                      </Columns>
                </asp:GridView>
    </div>
    <div>

    </div>
    <div align="center">
        <asp:Button ID="btnupload" runat="server" Text="UPLOAD" CssClass="btn btn-success" OnClick="btnupload_Click"/>
    </div>
    <script type="text/javascript">
        function confirmDelete() {
            return confirm('Are you sure you want to split?');
        }
        $(document).ready(function () {
            var edate = '<%= Session["edate"] %>';
            var etime = '<%= Session["etime"] %>';
            console.log(edate);
            console.log(etime);
        });
    </script>
</asp:Content>
