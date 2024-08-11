<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="SupervisorDataDisplay.aspx.cs" Inherits="ProtoType.SupervisorDataDisplay" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cplMain" runat="server">
    <div class="row clearfix" style="font-size: smaller"> 
      <asp:UpdatePanel ID="UpdatePanel2" runat="server">
         <ContentTemplate>
                <asp:GridView ID="GVDevent" runat="server" CellPadding="2" CssClass="table table-bordered table-striped" AutoGenerateColumns="False" OnRowUpdating="GVDevent_RowUpdating">
                    <Columns>
                       <asp:BoundField HeaderText="RECORD ID" DataField="record_id" />
                       <asp:BoundField HeaderText="EQUIPMENT DESC" DataField="equip_desc" />
                       <asp:BoundField HeaderText="START DATE" DataField="start_date" DataFormatString="{0:dd/MM/yyyy}"/>
                       <asp:BoundField HeaderText="START TIME" DataField="start_time" />
                       <asp:BoundField HeaderText="END DATE" DataField="end_date" DataFormatString="{0:dd/MM/yyyy}" />
                       <asp:BoundField HeaderText="END TIME" DataField="end_time" />
                       <asp:BoundField HeaderText="DURATION" DataField="duration_mins" />
                        <asp:TemplateField>
                            <ItemTemplate>
                                 <asp:Button ID="editbtn" runat="server" Text="EDIT" CommandName="Update"/>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
        </ContentTemplate>
      </asp:UpdatePanel>
    </div>
   
</asp:Content>
