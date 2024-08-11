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
    public partial class CauseDetails : System.Web.UI.Page
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
            adp = new SqlDataAdapter("select * from causetb", con);
            ds = new DataSet();
            adp.Fill(ds);
            causegrid.DataSource = ds;
            causegrid.DataBind();
        }

        protected void causegrid_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            causegrid.EditIndex = -1;
            fillgrid();
        }

        protected void causegrid_RowEditing(object sender, GridViewEditEventArgs e)
        {
            causegrid.EditIndex = e.NewEditIndex;
            fillgrid();

        }

        protected void causegrid_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int r = causegrid.EditIndex;
            Label lid = (Label)causegrid.Rows[r].FindControl("lblid2");
            TextBox tcode = (TextBox)causegrid.Rows[r].FindControl("txtcode");
            TextBox tdesc = (TextBox)causegrid.Rows[r].FindControl("txtdesc");
            CheckBoxList cbl = (CheckBoxList)causegrid.Rows[r].FindControl("cblstatus");
            int active_status = 0;
            if (cbl.SelectedItem.Text == "ACTIVE")
            {
                active_status = 1;
            }
            if (cbl.SelectedItem.Text == "INACTIVE")
            {
                active_status = 0;
            }

            cmd = new SqlCommand("update causetb set cause_code='" + tcode.Text + "',cause_description='" + tdesc.Text + "',active_status=" + active_status + "  where record_id = " + Convert.ToInt32(lid.Text) + "", con);
            cmd.ExecuteNonQuery();
            causegrid.EditIndex = -1;
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
                if (Chlstatus.SelectedItem.Text == "ACTIVE")
                {
                    s = 1;
                }
                if (Chlstatus.SelectedItem.Text == "INACTIVE")
                {
                    s = 0;
                }
                cmd = new SqlCommand("insert into causetb(cause_code,cause_description,active_status) values('" + tcode.Text + "','" + tdesc.Text + "'," + s + ")", con);
                cmd.ExecuteNonQuery();
                tcode.Text = " ";
                tdesc.Text = " ";

                fillgrid();
           
        }
    }
}