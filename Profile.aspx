
<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="ProtoType.Profile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cplMain" runat="server">
    <div class="container-fluid">
        <div class="row clearfix text-center h3" style="margin-top: -5px">YOUR PROFILE</div>
        <div style="text-align: center">
            <asp:Label runat="server" ID="lblErroMsg" CssClass="alert alert-danger" Visible="False"></asp:Label>
        </div>
      <table style="text-align: left; margin: 0 auto;" class="table table-responsive" >
           <tr>
               <td>
                   <asp:Label ID="lblname" CssClass="control-label" runat="server" Text="NAME:"></asp:Label>
               </td>
               <td>
                   <asp:TextBox ID="txtname" CssClass="form-control " runat="server" ReadOnly="true"></asp:TextBox>
               </td>
               <td></td>
           </tr>
          <tr>
               <td>
                   <asp:Label ID="lblcity" CssClass="control-label" runat="server" Text="CITY:"></asp:Label>
               </td>
               <td>
                   <asp:TextBox ID="txtcity" CssClass="form-control " runat="server" ReadOnly="true"></asp:TextBox>
               </td>
              <td></td>
           </tr>
          <tr>
               <td>
                   <asp:Label ID="lblcontact" CssClass="control-label" runat="server" Text="CONTACT:"></asp:Label>
               </td>
               <td>
                   <asp:TextBox ID="txtcontact" CssClass="form-control " runat="server" ReadOnly="true"></asp:TextBox>
               </td>
              <td></td>
           </tr>
          <tr>
               <td>
                   <asp:Label ID="lblemail" CssClass="control-label" runat="server" Text="EMAIL:"></asp:Label>
               </td>
               <td>
                   <asp:TextBox ID="txtemail" CssClass="form-control " runat="server" ReadOnly="true"></asp:TextBox>
               </td>
              <td></td>
           </tr>
          <tr>
               <td>
                   <asp:Label ID="lbladdress" CssClass="control-label" runat="server" Text="ADDRESS:"></asp:Label>
               </td>
               <td>
                   <asp:TextBox ID="txtaddress" CssClass="form-control " runat="server" ReadOnly="true"></asp:TextBox>
               </td>
              <td></td>
           </tr>
          <tr>
               <td>
                   <asp:Label ID="lblposition" CssClass="control-label" runat="server" Text="POSITION:"></asp:Label>
               </td>
               <td>
                   <asp:TextBox ID="txtposition" CssClass="form-control " runat="server" ReadOnly="true"></asp:TextBox>
               </td>
              <td></td>
           </tr>
          <tr>
               <td>
                   <asp:Label ID="lblcredentials" CssClass="control-label" runat="server" Text="CREDENTIALS:"></asp:Label>
               </td>
               <td>
                   <asp:TextBox ID="txtcredentials" CssClass="form-control " runat="server" ReadOnly="true"></asp:TextBox>
               </td>
            
           </tr>
         
         
        </table>
        

     </div>
    <div align="center">
         <asp:Button ID="enterbtn" runat="server" CssClass="btn btn-success" Text="CHANGE" OnClick="enterbtn_Click"/>
    </div>
</asp:Content>
