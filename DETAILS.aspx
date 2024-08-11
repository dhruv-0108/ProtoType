<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="DETAILS.aspx.cs" Inherits="ProtoType.DETAILS" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cplMain" runat="server">
    <div class="container-fluid">
        <div class="row clearfix text-center h3" style="margin-top: -5px">
            REGISTER NEW EMPLOYEE
        </div>
        <br />

        <div style="text-align: center">
            <asp:Label runat="server" ID="lblErroMsg" CssClass="alert alert-danger" Visible="False"></asp:Label>
        </div>
        <br />
        <br />
      <table style="text-align: left; margin: 0 auto;" class="table table-responsive" >
            <tr>
                <td>
                    <asp:Label runat="server" CssClass="control-label" Text="NAME:"></asp:Label>
                
                </td>
                <td>
                    <asp:TextBox runat="server" ID="tname" CssClass="form-control"></asp:TextBox>
                </td>
                
            </tr>
             <tr>
                <td>
                    <asp:Label runat="server" CssClass="control-label" Text="CITY:"></asp:Label>
                
                </td>
                <td>
                    <asp:DropDownList AutoPostBack="true" runat="server" CssClass="form-control" ID="Ddlcity">
                        <asp:ListItem Text="SELECT CITY" Value="SELECT CITY"></asp:ListItem>
                        <asp:ListItem Text="SURAT" Value="SURAT"></asp:ListItem>
                        <asp:ListItem Text="GANDHINAGAR" Value="GANDHINAGAR"></asp:ListItem>
                        <asp:ListItem Text="PUNE" Value="PUNE"></asp:ListItem>
                    </asp:DropDownList>
                </td>
                 
            </tr>
             <tr>
                <td>
                    <asp:Label runat="server" CssClass="control-label" Text="CONTACT:"></asp:Label>
                
                </td>
                <td>
                    <asp:TextBox runat="server" ID="txtmobileNo" CssClass="form-control" onkeypress="numerics('txtmobileNo')"></asp:TextBox>
                </td>
                 
            </tr>
             <tr>
                <td>
                    <asp:Label runat="server" CssClass="control-label" Text="EMAIL:"></asp:Label>
                
                </td>
                <td>
                    <asp:TextBox runat="server" ID="temail" CssClass="form-control" TextMode="Email"></asp:TextBox>
                </td>    
                 
            </tr>
             <tr>
                <td>
                    <asp:Label runat="server" CssClass="control-label" Text="ADDRESS:"></asp:Label>
                
                </td>
                <td>
                    <asp:TextBox runat="server" ID="taddress" TabIndex="2" CssClass="form-control" TextMode="MultiLine" Rows="4"></asp:TextBox>
                </td>
                 
            </tr>
             <tr>
                <td>
                    <asp:Label runat="server" CssClass="control-label" Text="POSIITION:"></asp:Label>
                
                </td>
                <td>
                    <asp:DropDownList AutoPostBack="true" runat="server" CssClass="form-control" ID="Ddlposition">
                        <asp:ListItem Text="SELECT POSITION" Value="SELECT POSITION"></asp:ListItem>
                        <asp:ListItem Text="ENGINEER" Value="ENGINEER"></asp:ListItem>
                        <asp:ListItem Text="SUPERVISOR" Value="SUPERVISOR"></asp:ListItem>
                        <asp:ListItem Text="DEPARTMENT HEAD" Value="DEPARTMENT HEAD"></asp:ListItem>
                    </asp:DropDownList>
                </td>
                
            </tr>
             <tr>
                <td>
                    <asp:Label runat="server" CssClass="control-label" Text="CREDENTIALS:"></asp:Label>
                
                </td>
                <td>
                    <asp:TextBox runat="server" ID="tcred" CssClass="form-control"></asp:TextBox>
                </td>
                 
            </tr>
             <tr>
                <td>
                    <asp:Label runat="server" CssClass="control-label" Text="STATUS:"></asp:Label>
                
                </td>
                <td>
                    <asp:CheckBoxList AutoPostBack="true" runat="server" ID="Chlstatus">
                        <asp:ListItem>WORKING</asp:ListItem>
                        <asp:ListItem>LEFT</asp:ListItem>
                    </asp:CheckBoxList>
                </td>  
                
            </tr>
             <tr>
                <td>
                    <asp:Label runat="server" CssClass="control-label" Text="DEPARTMENT:"></asp:Label>
                
                </td>
                <td>
                    <asp:DropDownList AutoPostBack="true" CssClass="form-control" runat="server" ID="Ddldept">
                        <asp:ListItem Text="SELECT DEPARTMENT" Value="SELECT DEPARTMENT" Selected="True"></asp:ListItem>
                    </asp:DropDownList>
                </td>
                 
            </tr>
             <tr>
                 <td></td>
                 <td align="center">
                     <asp:Button ID="enterbtn" runat="server" CssClass="m-btn green" Text="ENTER" OnClick="enterbtn_Click"/>
                 </td>
             </tr>
        </table>
        
        <div class="row clearfix" style="font-size: smaller"> 
            
           
                <div class="row clearfix text-center h4">EMPLOYEE DETAILS</div>
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">

                    <ContentTemplate>
                        <asp:GridView ID="employeegrid" runat="server" CellPadding="0" AllowPaging="false"
                            CssClass="table table-bordered table-striped"
                            ShowFooter="False"
                            EmptyDataText="No Data Available" 
                            AutoGenerateColumns="False"  EditRowStyle-BackColor="LightGray" OnRowCancelingEdit="employeegrid_RowCancelingEdit" OnRowEditing="employeegrid_RowEditing" OnRowUpdating="employeegrid_RowUpdating" 
                            OnRowDeleting="employeegrid_RowDeleting">
                            <Columns>
                                
                                <asp:TemplateField HeaderText="id" HeaderStyle-ForeColor="White" HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="#333333" HeaderStyle-BorderColor="Black" HeaderStyle-BorderWidth="2px" ItemStyle-Width="10%" ItemStyle-Wrap="true">
                                    <ItemStyle HorizontalAlign="Center" BorderWidth="2px" BorderColor="black" ForeColor="Black" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblid1" runat="server" Text='<%#Eval("Id") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:Label ID="lblid2" runat="server" Text='<%#Eval("Id") %>'></asp:Label>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                
                                <asp:TemplateField HeaderText="name" HeaderStyle-ForeColor="White" HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="#333333" HeaderStyle-BorderColor="Black" HeaderStyle-BorderWidth="2px" ItemStyle-Width="10%" ItemStyle-Wrap="true">
                                    <ItemStyle HorizontalAlign="Center" BorderWidth="2px" BorderColor="black" ForeColor="Black" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblname" runat="server" Text='<%#Bind("name") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtname" runat="server" Text='<%#Eval("name") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                
                                <asp:TemplateField HeaderText="city" HeaderStyle-ForeColor="White" HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="#333333" HeaderStyle-BorderColor="Black" HeaderStyle-BorderWidth="2px" ItemStyle-Width="10%" ItemStyle-Wrap="true">
                                    <ItemStyle HorizontalAlign="Center" BorderWidth="2px" BorderColor="black" ForeColor="Black" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblcity" runat="server" Text='<%#Bind("city") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtcity" runat="server" Text='<%#Eval("city") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                
                                <asp:TemplateField HeaderText="contact" HeaderStyle-ForeColor="White" HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="#333333" HeaderStyle-BorderColor="Black" HeaderStyle-BorderWidth="2px" ItemStyle-Width="10%" ItemStyle-Wrap="true">
                                    
                                    <ItemStyle HorizontalAlign="Center" BorderWidth="2px" BorderColor="black" ForeColor="Black" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblcontact" runat="server" Text='<%#Bind("contact") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtcontact" runat="server" Text='<%#Eval("contact") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="email" HeaderStyle-ForeColor="White" HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="#333333" HeaderStyle-BorderColor="Black" HeaderStyle-BorderWidth="2px" ItemStyle-Width="10%" ItemStyle-Wrap="true">
                                    <ItemStyle HorizontalAlign="Center" BorderWidth="2px" BorderColor="black" ForeColor="Black" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblemail" runat="server" Text='<%#Bind("email") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtemail" runat="server" Text='<%#Eval("email") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                
                                <asp:TemplateField HeaderText="address" HeaderStyle-ForeColor="White" HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="#333333" HeaderStyle-BorderColor="Black" HeaderStyle-BorderWidth="2px" ItemStyle-Width="10%" ItemStyle-Wrap="true">
                                    <ItemStyle HorizontalAlign="Center" BorderWidth="2px" BorderColor="black" ForeColor="Black" />
                                    <ItemTemplate>
                                        <asp:Label ID="lbladdress" runat="server" Text='<%#Bind("address") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtaddress" Columns="2" runat="server" Text='<%#Eval("address") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                
                                <asp:TemplateField HeaderText="position" HeaderStyle-ForeColor="White" HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="#333333" HeaderStyle-BorderColor="Black" HeaderStyle-BorderWidth="2px" ItemStyle-Width="10%" ItemStyle-Wrap="true">
                                   <ItemStyle HorizontalAlign="Center" BorderWidth="2px" BorderColor="black" ForeColor="Black" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblposition" runat="server" Text='<%#Bind("position") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtposition" runat="server" Text='<%#Eval("position") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                
                                <asp:TemplateField HeaderText="credentials" HeaderStyle-ForeColor="White" HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="#333333" HeaderStyle-BorderColor="Black" HeaderStyle-BorderWidth="2px" ItemStyle-Width="10%" ItemStyle-Wrap="true">
                                    <ItemStyle HorizontalAlign="Center" BorderWidth="2px" BorderColor="black" ForeColor="Black" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblcredentials" runat="server" Text='<%#Bind("credentials") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtcredentials" runat="server" Text='<%#Eval("credentials") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="department" HeaderStyle-ForeColor="White" HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="#333333" HeaderStyle-BorderColor="Black" HeaderStyle-BorderWidth="2px" ItemStyle-Width="10%" ItemStyle-Wrap="true">
                                    <ItemStyle HorizontalAlign="Center" BorderWidth="2px" BorderColor="black" ForeColor="Black" />
                                    <ItemTemplate>
                                        <asp:Label ID="lbldept" runat="server" Text='<%#Bind("deptcode") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtdept" runat="server" Text='<%#Eval("deptcode") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                               
                                <asp:TemplateField HeaderText="status" HeaderStyle-ForeColor="White" HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="#333333" HeaderStyle-BorderColor="Black" HeaderStyle-BorderWidth="2px" ItemStyle-Width="10%" ItemStyle-Wrap="true">
                                    <ItemStyle HorizontalAlign="Center" BorderWidth="2px" BorderColor="black" ForeColor="Black" VerticalAlign="Middle" />
                                    
                                    <ItemTemplate>
                                        <asp:CheckBox ID="workinge" runat="server" text="WORKING" enabled="false" Checked='<%# (Eval("status").ToString()=="1" ? true : false) %>'/><br />
                                        <asp:CheckBox ID="lefte" runat="server" text="LEFT" enabled="false" Checked='<%# (Eval("status").ToString()=="0" ? true : false) %>'/>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:CheckBoxList ID="cblstatus" runat="server" AutoPostBack="true">
                                            <asp:ListItem>WORKING</asp:ListItem>
                                            <asp:ListItem>LEFT</asp:ListItem>
                                        </asp:CheckBoxList>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                
                                <asp:TemplateField HeaderText="id" HeaderStyle-ForeColor="White" HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="#333333" HeaderStyle-BorderColor="Black" HeaderStyle-BorderWidth="2px" ItemStyle-Width="10%" ItemStyle-Wrap="true">
                                    <ItemStyle HorizontalAlign="Center" BorderWidth="2px" BorderColor="black" ForeColor="Black" />
                                    <ItemTemplate>
                                        <asp:LinkButton ID="editbtn" Font-Size="Small" runat="server" CommandName="Edit" Text="EDIT" CssClass="btn btn-success"></asp:LinkButton>
                                    <asp:LinkButton ID="deletebtn" Font-Size="Small" runat="server" CommandName="Delete" Text="DELETE" CssClass="btn btn-danger"></asp:LinkButton>
                                     
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
