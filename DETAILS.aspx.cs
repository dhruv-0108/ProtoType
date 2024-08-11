using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Security.Cryptography;

namespace ProtoType
{
    public partial class DETAILS : System.Web.UI.Page
    {
        public static string scon = ConfigurationManager.ConnectionStrings["LTprojectdb"].ConnectionString;
        SqlConnection con = new SqlConnection(scon);
        SqlDataAdapter adp = new SqlDataAdapter();
        DataSet ds = new DataSet();
        DataSet ds2 = new DataSet();
        SqlCommand cmd = new SqlCommand();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (con.State == ConnectionState.Broken || con.State == ConnectionState.Closed)
            {
                con.Open();

            }
            if (!IsPostBack)
            {
                filldept();
                fillgrid();
            }
        }
        public void filldept()
        {
            adp = new SqlDataAdapter("select distinct dept_description from depttb", con);
            ds2 = new DataSet();
            adp.Fill(ds2);
            if (ds2.Tables[0].Rows.Count > 0)
            {
                Ddldept.DataSource = ds2.Tables[0];
                Ddldept.DataValueField = "dept_description";
                Ddldept.DataTextField = "dept_description";
                Ddldept.DataBind();
            }
        }
        public void fillgrid()
        {
            adp = new SqlDataAdapter("select * from employeetb", con);
            ds = new DataSet();
            adp.Fill(ds);
            employeegrid.DataSource = ds;
            employeegrid.DataBind();
        }

        protected void employeegrid_RowEditing(object sender, GridViewEditEventArgs e)
        {
            employeegrid.EditIndex = e.NewEditIndex;
            fillgrid();
        }

        protected void employeegrid_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            employeegrid.EditIndex = -1;
            fillgrid();
        }

       

        protected void employeegrid_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int r = employeegrid.EditIndex;
            Label lid = (Label)employeegrid.Rows[r].FindControl("lblid2");
            TextBox tname = (TextBox)employeegrid.Rows[r].FindControl("txtname");
            TextBox tcity = (TextBox)employeegrid.Rows[r].FindControl("txtcity");
            TextBox tcontact = (TextBox)employeegrid.Rows[r].FindControl("txtcontact");
            TextBox temail = (TextBox)employeegrid.Rows[r].FindControl("txtemail");
            TextBox taddress = (TextBox)employeegrid.Rows[r].FindControl("txtaddress");
            TextBox tposition = (TextBox)employeegrid.Rows[r].FindControl("txtposition");
            TextBox tcredentials = (TextBox)employeegrid.Rows[r].FindControl("txtcredentials");
            TextBox tdeptcode = (TextBox)employeegrid.Rows[r].FindControl("txtdept");
            CheckBoxList cbl = (CheckBoxList)employeegrid.Rows[r].FindControl("cblstatus");
            int active_status = 0;
            if (cbl.SelectedItem.Text == "WORKING")
            {
                active_status = 1;
            }
            if (cbl.SelectedItem.Text == "LEFT")
            {
                active_status = 0;
            }

            cmd = new SqlCommand("update employeetb set name = '" + tname.Text + "', city = '" + tcity.Text + "', contact = '" + tcontact.Text + "',email = '" + temail.Text + "',address = '" + taddress.Text + "',position = '" + tposition.Text + "',credentials = '" + tcredentials.Text + "' ,status = " + active_status + " ,deptcode = '" + tdeptcode.Text + "' where Id = " + Convert.ToInt32(lid.Text) + " ", con);
            cmd.ExecuteNonQuery();
            employeegrid.EditIndex = -1;
            fillgrid();
        }

        protected void enterbtn_Click(object sender, EventArgs e)
        {
            string name = tname.Text;
            string city = Ddlcity.SelectedItem.Text;
            string contact = txtmobileNo.Text;
            string email = temail.Text;
            string address = taddress.Text;
            string position = Ddlposition.SelectedItem.Text;
            string credentials = tcred.Text;

            lblErroMsg.Visible = false;

            if(string.IsNullOrEmpty(name))
            {
                lblErroMsg.Text = "Please enter name";
                lblErroMsg.Visible = true;
                return;
            }
            if (Ddlcity.SelectedIndex == 0)
            {
                lblErroMsg.Text = "Please select city";
                lblErroMsg.Visible = true;
                return;
            }
            if (string.IsNullOrEmpty(contact))
            {
                lblErroMsg.Text = "Please enter contact";
                lblErroMsg.Visible = true;
                return;
            }
            if (string.IsNullOrEmpty(email))
            {
                lblErroMsg.Text = "Please enter email";
                lblErroMsg.Visible = true;
                return;
            }
            if (string.IsNullOrEmpty(address))
            {
                lblErroMsg.Text = "Please enter address";
                lblErroMsg.Visible = true;
                return;
            }
            if (Ddlposition.SelectedIndex == 0)
            {
                lblErroMsg.Text = "Please select position";
                lblErroMsg.Visible = true;
                return;
            }
            if (string.IsNullOrEmpty(credentials))
            {
                lblErroMsg.Text = "Please enter credentials";
                lblErroMsg.Visible = true;
                return;
            }
            if (Chlstatus.SelectedIndex == -1)
            {
                lblErroMsg.Text = "Please select status";
                lblErroMsg.Visible = true;
                return;
            }

            int status = 0;
                if (Chlstatus.SelectedItem.Text == "WORKING")
                {
                    status = 1;
                }
                if (Chlstatus.SelectedItem.Text == "LEFT")
                {
                    status = 0;
                }

                adp = new SqlDataAdapter("select function_code from equipmenttb where function_desc = '" + Ddldept.SelectedItem.Text + "' ", con);
                ds = new DataSet();
                adp.Fill(ds);
                string deptcode = " ";
                if (ds.Tables[0].Rows.Count > 0)
                {
                    deptcode = ds.Tables[0].Rows[0]["function_code"].ToString();
                }

                cmd = new SqlCommand("insert into employeetb(name,city,contact,email,address,position,credentials,status,deptcode) values('" + name + "','" + city + "','" + contact + "','" + email + "','" + address + "','" + position + "','" + credentials + "'," + status + ",'" + deptcode + "')", con);
                cmd.ExecuteNonQuery();
                fillgrid();
            

        }

        protected void employeegrid_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            fillgrid();
            int r = Convert.ToInt32(ds.Tables[0].Rows[e.RowIndex].ItemArray[0]);
            cmd = new SqlCommand("delete from employeetb where Id = "+r+" ", con);
            cmd.ExecuteNonQuery();
            fillgrid();

        }
    }
}