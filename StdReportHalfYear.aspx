<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="StdReportHalfYear.aspx.cs" Inherits="ProtoType.StdReportHalfYear" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cplMain" runat="server">
    <div class="row clearfix">
       <div align="center">
          <asp:Button runat="server" ID="btnpie" Text="PIE" CssClass="btn btn-success" OnClick="btnpie_Click"/> &nbsp;
          <asp:Button runat="server" ID="btncolumn" Text="COLUMN" CssClass="btn btn-success" OnClick="btncolumn_Click"/>
       </div>
    </div> 
    <div class="row clearfix" style="font-size: smaller"> 
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <asp:GridView ID="GVDreport" runat="server" CellPadding="2"
            CssClass="table table-bordered table-striped" AutoGenerateColumns="false">
                      <Columns>
                          <asp:BoundField HeaderText="DEPARTMENT" DataField="function_desc" ItemStyle-Width="10%" ItemStyle-HorizontalAlign="Center" />
                           <asp:TemplateField HeaderText="AVAILABILTY (%)" ItemStyle-HorizontalAlign="Center">
                               <ItemStyle HorizontalAlign="Center" Width="10%" />
                                <ItemTemplate>
                                    <asp:Label ID="lbl_HT250" runat="server" Text='<%#Eval("AVAILABLE") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                      </Columns>
                </asp:GridView>
            </ContentTemplate>
         </asp:UpdatePanel>
      </div>
    <div class="row clearfix">
        <div align="center">
            <asp:Button runat="server" ID="refreshbtn" OnClick="refreshbtn_Click" Text="REFRESH" />
        </div>
    </div>
</asp:Content>
