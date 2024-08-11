<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="AllRecords.aspx.cs" Inherits="ProtoType.AllRecords" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cplMain" runat="server">
   
    <div class="row clearfix">
            <div align="center">
                <asp:Button runat="server" ID="btnexport" Text="EXPORT" CssClass="btn btn-success" OnClick="btnexport_Click"/>
            </div>
        </div>
    <br />
    <br />
    <div class="row clearfix" style="font-size: smaller"> 
          
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>
                        <asp:GridView ID="GVDrecords" runat="server" CellPadding="0" AllowPaging="false"
                            CssClass="table table-bordered table-striped"
                            ShowFooter="False"
                            EmptyDataText="No Data Available" 
                            AutoGenerateColumns="False"  EditRowStyle-BackColor="LightGray">
                            <HeaderStyle HorizontalAlign="Center" BackColor="LightGray"/>
                            <RowStyle HorizontalAlign="Center" />
                            
                            <Columns>
                                
                                <asp:BoundField HeaderText="RECORD ID" DataField="record_id" ItemStyle-Width="8%" HeaderStyle-Width="8%"/>
                                <asp:BoundField HeaderText="DEPARTMNET CODE" DataField="function_code" ItemStyle-Width="8%" HeaderStyle-Width="8%" />
                                <asp:BoundField HeaderText="DEPARTMENT DESCRIPTION" DataField="function_desc" ItemStyle-Width="8%" HeaderStyle-Width="8%" />
                                <asp:BoundField HeaderText="EQUIPMENT CODE" DataField="equip_code" ItemStyle-Width="8%" HeaderStyle-Width="8%" />
                                <asp:BoundField HeaderText="EQUIPMENT DESCRIPTION" DataField="equip_desc" ItemStyle-Width="8%" HeaderStyle-Width="8%" />
                                <asp:BoundField HeaderText="EMPLOYEE ID" DataField="Id" ItemStyle-Width="8%" HeaderStyle-Width="8%" />
                                <asp:BoundField HeaderText="START DATE" DataField="start_date" DataFormatString="{0:dd/MM/yyyy}" ItemStyle-Width="8%" HeaderStyle-Width="8%" />
                                <asp:BoundField HeaderText="START TIME" DataField="start_time" ItemStyle-Width="8%" HeaderStyle-Width="8%" />
                                <asp:BoundField HeaderText="END DATE" DataField="end_date" DataFormatString="{0:dd/MM/yyyy}" ItemStyle-Width="8%" HeaderStyle-Width="8%"/>
                                <asp:BoundField HeaderText="END TIME" DataField="end_time" ItemStyle-Width="8%" HeaderStyle-Width="8%" />
                                <asp:BoundField HeaderText="MAINTENANCE CODE" DataField="maint_code" ItemStyle-Width="8%" HeaderStyle-Width="8%" />
                                <asp:BoundField HeaderText="RESPONSIBLE DEPARTMENT" DataField="dept_code" ItemStyle-Width="8%" HeaderStyle-Width="8%" />
                                <asp:BoundField HeaderText="CAUSE CODE" DataField="cause_code" ItemStyle-Width="8%" HeaderStyle-Width="8%"/>
                                <asp:BoundField HeaderText="UPDATED BY" DataField="update_by" ItemStyle-Width="8%" HeaderStyle-Width="8%"/>
                                <asp:BoundField HeaderText="UPDATE TIME" DataField="update_time" ItemStyle-Width="8%" HeaderStyle-Width="8%"/>
                                <asp:BoundField HeaderText="DURATION" DataField="duration_mins" ItemStyle-Width="8%" HeaderStyle-Width="8%"/>
                                
                            </Columns>
                        </asp:GridView>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
</asp:Content>
