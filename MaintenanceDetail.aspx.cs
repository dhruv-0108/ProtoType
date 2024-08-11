using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ProtoType
{
    public partial class MaintenanceDetail : System.Web.UI.Page
    {
        public static string scon = ConfigurationManager.ConnectionStrings["LTprojectdb"].ConnectionString;
        SqlConnection con = new SqlConnection(scon);
        SqlDataAdapter adp = new SqlDataAdapter();
        DataSet ds = new DataSet();
        SqlCommand cmd = new SqlCommand();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (con.State == ConnectionState.Broken || con.State == ConnectionState.Closed)
            {
                con.Open();

            }
            if (!IsPostBack)
            {
                fillgrid();
            }
        }

        public void fillgrid()
        {
            adp = new SqlDataAdapter("select * from maintenancetb", con);
            ds = new DataSet();
            adp.Fill(ds);
            maintenancegrid.DataSource = ds;
            maintenancegrid.DataBind();
        }

        protected void maintenancegrid_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            maintenancegrid.EditIndex = -1;
            fillgrid();
        }

        protected void maintenancegrid_RowEditing(object sender, GridViewEditEventArgs e)
        {
            maintenancegrid.EditIndex = e.NewEditIndex;
            fillgrid();
        }

        protected void maintenancegrid_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int r = maintenancegrid.EditIndex;
            Label lid = (Label)maintenancegrid.Rows[r].FindControl("lblid2");
            TextBox tcode = (TextBox)maintenancegrid.Rows[r].FindControl("txtcode");
            TextBox tdesc = (TextBox)maintenancegrid.Rows[r].FindControl("txtdesc");
            CheckBoxList cbl = (CheckBoxList)maintenancegrid.Rows[r].FindControl("cblstatus");
            int active_status = 0;
            if (cbl.SelectedItem.Text == "ACTIVE")
            {
                active_status = 1;
            }
            if (cbl.SelectedItem.Text == "INACTIVE")
            {
                active_status = 0;
            }

            cmd = new SqlCommand("update maintenancetb set maint_code='" + tcode.Text + "',maint_description='" + tdesc.Text + "',active_status=" + active_status + "  where record_id = " + Convert.ToInt32(lid.Text) + "", con);
            cmd.ExecuteNonQuery();
            maintenancegrid.EditIndex = -1;
            fillgrid();
        }

        protected void enterbtn_Click(object sender, EventArgs e)
        {
            lblErroMsg.Visible = false;

            // Validate tcode textbox
            if (string.IsNullOrWhiteSpace(tcode.Text))
            {
                lblErroMsg.Text = "Please enter a value for CODE.";
                lblErroMsg.Visible = true;
                return; // Stop further processing
            }

            // Validate tdesc textbox
            if (string.IsNullOrWhiteSpace(tdesc.Text))
            {
                lblErroMsg.Text = "Please enter a value for DESCRIPTION.";
                lblErroMsg.Visible = true;
                return; // Stop further processing
            }

            // Validate Chlstatus checkboxlist
            bool isChecked = false;
            foreach (ListItem item in Chlstatus.Items)
            {
                if (item.Selected)
                {
                    isChecked = true;
                    break;
                }
            }

            if (!isChecked)
            {
                lblErroMsg.Text = "Please select a value for STATUS.";
                lblErroMsg.Visible = true;
                return; // Stop further processing
            }
            int s = 0;
                if (Chlstatus.SelectedItem.Text == "OK")
                {
                    s = 1;
                }
                if (Chlstatus.SelectedItem.Text == "NOT OK")
                {
                    s = 0;
                }
                cmd = new SqlCommand("insert into maintenancetb(maint_code,maint_description,active_status) values('" + tcode.Text + "','" + tdesc.Text + "'," + s + ")", con);
                cmd.ExecuteNonQuery();

                tcode.Text = " ";
                tdesc.Text = " ";
                fillgrid();
            
        }
    }
}