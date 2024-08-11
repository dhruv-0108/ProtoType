<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="SupervisorDataEntry.aspx.cs" Inherits="ProtoType.SupervisorDataEntry" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cplMain" runat="server">
    <div class="container">
        <div class="row clearfix text-center h3" style="margin-top: -5px">Create Notification</div>
        <div class="row clearfix text-center"></div>
        <div style="text-align: center">
            <asp:Label runat="server" ID="lblErroMsg" CssClass="alert alert-danger" Visible="False"></asp:Label>
        </div>
<div style="text-align: center">
            <asp:Label runat="server" ID="LblErrGrid" CssClass="alert alert-danger" Visible="False"></asp:Label>
        </div>
        <br />
        <div class="row clearfix">
            <div class="form-group col-sm-4">
                <asp:Label ID="Label1" runat="server" CssClass="control-label" Text="Maintenance Type :"></asp:Label>
                <asp:DropDownList ID="DdlMaintType" runat="server" CssClass="form-control " AutoPostBack="true" OnSelectedIndexChanged="DdlMaintType_SelectedIndexChanged">
                </asp:DropDownList>
                
            </div>
            <div class="form-group col-sm-4">
                <asp:Label ID="Label7" runat="server" CssClass="control-label" Text="Cause Type :"></asp:Label>
                <asp:DropDownList ID="DdlCausetype" runat="server" CssClass="form-control " AutoPostBack="true" OnSelectedIndexChanged="DdlCausetype_SelectedIndexChanged">
                </asp:DropDownList>
               
            </div>
            <div class="form-group col-sm-4">
                <asp:Label ID="Label2" runat="server" CssClass="control-label" Text="Responsible Department:"></asp:Label>
                <asp:DropDownList ID="DdlDepart" runat="server" CssClass="form-control " AutoPostBack="true" OnSelectedIndexChanged="DdlDepart_SelectedIndexChanged">
                </asp:DropDownList>
               
            </div>
        </div>
        <div class="row clearfix">
            <div class="form-group col-sm-4">
               <asp:Label ID="lblrid" runat="server" CssClass="control-label" Text="RECORD ID :"></asp:Label><br />
                <asp:TextBox runat="server" ID="txtrid" CssClass="form-control " ReadOnly="true"></asp:TextBox>
            </div>

            <div class="form-group col-sm-4">
                <asp:Label ID="lblfcode" runat="server" CssClass="control-label" Text="DEPARTMENT CODE :"></asp:Label>
                <asp:TextBox runat="server" ID="txtfcode" CssClass="form-control " ReadOnly="true"></asp:TextBox>

            </div>
            <div class="form-group col-sm-4">
               <asp:Label ID="lblfdesc" runat="server" CssClass="control-label" Text="DEPARTMENT CODE :"></asp:Label>
                <asp:TextBox runat="server" ID="txtfdesc" CssClass="form-control " ReadOnly="true"></asp:TextBox>
            </div>
            
            
        </div>
        <div class="row clearfix">
            <div class="form-group col-sm-4">
               <asp:Label ID="lblid" runat="server" CssClass="control-label" Text="EMPLOYEE ID :"></asp:Label>
                <asp:TextBox runat="server" ID="txteid" CssClass="form-control " ReadOnly="true"></asp:TextBox>
            </div>

            <div class="form-group col-sm-4">
                <asp:Label ID="lblecode" runat="server" CssClass="control-label" Text="EQUIPMENT CODE :"></asp:Label>
                <asp:TextBox runat="server" ID="txtecode" CssClass="form-control " ReadOnly="true"></asp:TextBox>

            </div>
            <div class="form-group col-sm-4">
               <asp:Label ID="lbledesc" runat="server" CssClass="control-label" Text="EQUIPMENT CODE :"></asp:Label>
                <asp:TextBox runat="server" ID="txtedesc" CssClass="form-control " ReadOnly="true"></asp:TextBox>
            </div>
        </div>

        <!--START DATE TIME-->
        <div class="row clearfix">
            <div class="form-group col-sm-2">
               <asp:Label ID="lblstartdate" runat="server" CssClass="control-label" Text=" START DATE"></asp:Label>
                <asp:TextBox runat="server" ID="txtstartdate" CssClass="form-control " ReadOnly="true"></asp:TextBox>
            </div>

            <div class="form-group col-sm-2">
                <asp:Label ID="lblstarttime" runat="server" CssClass="control-label" Text="START TIME"></asp:Label>
                <asp:TextBox runat="server" ID="txtstarttime" CssClass="form-control " ReadOnly="true"></asp:TextBox>

            </div>
            

            <div class="form-group col-sm-2">
               <asp:Label ID="lblenddate" runat="server" CssClass="control-label" Text=" END DATE"></asp:Label>
                <asp:TextBox runat="server" ID="txtenddate" CssClass="form-control " ReadOnly="true" ></asp:TextBox>
            </div>

            <div class="form-group col-sm-2">
                <asp:Label ID="lblendtime" runat="server" CssClass="control-label" Text="END TIME"></asp:Label>
                <asp:TextBox runat="server" ID="txtendtime" CssClass="form-control " ReadOnly="true"></asp:TextBox>

            </div>
            
        </div>
        <div class="row clearfix">
            <div class="form-group col-sm-2">
                <asp:Label ID="LblTotManHr" runat="server" CssClass="control-label" Text="Total Minutes:"></asp:Label>
                <asp:TextBox runat="server" ID="txttotalmin" CssClass="form-control numbersOnly" autocomplete="off" onpaste="return false" MaxLength="2" ReadOnly="true"></asp:TextBox>
            </div>
        </div>
        
            
        </div>
        <div class="row clearfix">
            <div class="form-group col-sm-4" align="center">
                <asp:Button runat="server" ID="btninsert" Text="Create" CssClass="btn btn-success" OnClick="btninsert_Click" />
            </div>
        </div>
    
    <div class="row clearfix" style="font-size: smaller"> 
          
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>
        <asp:GridView ID="GVDevent" runat="server" CellPadding="2"
            CssClass="table table-bordered table-striped" AutoGenerateColumns="False" 
            OnSelectedIndexChanged="GVDevent_SelectedIndexChanged">
            <Columns>
                <asp:BoundField HeaderText="RECORD ID" DataField="record_id" />
                <asp:BoundField HeaderText="DEPARTMNET CODE" DataField="function_code" />
                <asp:BoundField HeaderText="DEPARTMENT DESCRIPTION" DataField="function_desc" />
                <asp:BoundField HeaderText="EQUIPMENT CODE" DataField="equip_code" />
                <asp:BoundField HeaderText="EQUIPMENT DESC" DataField="equip_desc" />
                <asp:BoundField HeaderText="EMPLOYEE ID" DataField="Id" />
                <asp:BoundField HeaderText="START DATE" DataField="start_date" />
                <asp:BoundField HeaderText="START TIME" DataField="start_time" />
                <asp:BoundField HeaderText="END DATE" DataField="end_date" />
                <asp:BoundField HeaderText="END TIME" DataField="end_time" />
                <asp:BoundField HeaderText="DURATION" DataField="duration_mins" />
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Button runat="server" ID="selectbtn" Text="SELECT" CommandName="SELECT" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
   </ContentTemplate>
                    </asp:UpdatePanel>
        </div>
</asp:Content>
