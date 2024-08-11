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
    public partial class SupervisorDataEntry : System.Web.UI.Page
    {
        public static string scon = ConfigurationManager.ConnectionStrings["LTprojectdb"].ConnectionString;
        SqlConnection con = new SqlConnection(scon);
        DataSet ds = new DataSet();
        DataSet ds_cause = new DataSet();
        DataSet ds_dept = new DataSet();
        DataSet ds_maint = new DataSet();
        SqlDataAdapter adp = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (con.State == ConnectionState.Closed || con.State == ConnectionState.Broken)
            {
                con.Open();
            }
            if (!IsPostBack)
            {
                BindMaintenance();
                BindCause();
                BindDepartment();
                BindGrid();
            }

        }
        protected void BindGrid()
        {
            adp = new SqlDataAdapter("select * from MAIN_DATA where maint_code IS NULL OR dept_code IS NULL OR cause_code IS NULL OR  update_by IS NULL OR update_time IS NULL", con);
            ds = new DataSet();
            adp.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0)
            {
                GVDevent.DataSource = ds.Tables[0];
                GVDevent.DataBind();
            }
        }
        protected void BindDepartment()
        {
            adp = new SqlDataAdapter("select distinct dept_description from depttb where active_status=1", con);
            ds_dept = new DataSet();
            adp.Fill(ds_dept);
            if (ds_dept.Tables[0].Rows.Count > 0)
            {
                DdlDepart.DataSource = ds_dept.Tables[0];
                DdlDepart.DataTextField = "dept_description";
                DdlDepart.DataValueField = "dept_description";
                DdlDepart.DataBind();
            }
        }
        protected void BindCause()
        {
            adp = new SqlDataAdapter("select distinct cause_description from causetb where active_status=1", con);
            ds_cause = new DataSet();
            adp.Fill(ds_cause);
            if (ds_cause.Tables[0].Rows.Count > 0)
            {
                DdlCausetype.DataSource = ds_cause.Tables[0];
                DdlCausetype.DataTextField = "cause_description";
                DdlCausetype.DataValueField = "cause_description";
                DdlCausetype.DataBind();
            }
        }
        protected void BindMaintenance()
        {
            adp = new SqlDataAdapter("select distinct maint_description from maintenancetb where active_status=1", con);
            ds_maint = new DataSet();
            adp.Fill(ds_maint);
            if (ds_maint.Tables[0].Rows.Count > 0)
            {
                DdlMaintType.DataSource = ds_maint.Tables[0];
                DdlMaintType.DataTextField = "maint_description";
                DdlMaintType.DataValueField = "maint_description";
                DdlMaintType.DataBind();
            }
        }
        protected void GVDevent_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridViewRow r = GVDevent.SelectedRow;
            txtrid.Text = r.Cells[0].Text;
            txtfcode.Text = r.Cells[1].Text;
            txtfdesc.Text = r.Cells[2].Text;
            txtecode.Text = r.Cells[3].Text;
            txtedesc.Text = r.Cells[4].Text;
            txteid.Text = r.Cells[5].Text;
            txtstartdate.Text = r.Cells[6].Text;
            txtstarttime.Text = r.Cells[7].Text;
            txtenddate.Text = r.Cells[8].Text;
            txtendtime.Text = r.Cells[9].Text;
            txttotalmin.Text = r.Cells[10].Text;
        }

        protected void btninsert_Click(object sender, EventArgs e)
        {
            cmd = new SqlCommand("update MAIN_DATA set maint_code = '" + ViewState["MaintCode"] + "',dept_code = '" + ViewState["DepartCode"] +"' , cause_code = '" + ViewState["CauseCode"] +"',update_by = " + Convert.ToInt32(Session["id"])+",update_time = '"+DateTime.Now.ToString("HH:mm:ss")+"'  where record_id = " + Convert.ToInt32(txtrid.Text) + " ", con);
            cmd.ExecuteNonQuery();
            Response.Write("<script> alert('DATA INSERTED SUCCESSFULLY') ;</script>");

            txtrid.Text = " ";
            txtfcode.Text = " ";
            txtfdesc.Text = " ";
            txtecode.Text = " ";
            txtedesc.Text = " ";
            txteid.Text = " ";
            txtstartdate.Text = " ";
            txtstarttime.Text = " ";
            txtenddate.Text = " ";
            txtendtime.Text = " ";
            txttotalmin.Text = " ";
            DdlCausetype.SelectedIndex = 0;
            DdlDepart.SelectedIndex = 0;
            DdlMaintType.SelectedIndex = 0;

            BindGrid();
        }

        protected void DdlMaintType_SelectedIndexChanged(object sender, EventArgs e)
        {
            adp = new SqlDataAdapter("select maint_code from maintenancetb where maint_description = '" + DdlMaintType.SelectedItem.Text + "' ", con);
            ds = new DataSet();
            adp.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0)
            {
                ViewState["MaintCode"] = ds.Tables[0].Rows[0]["maint_code"].ToString();
            }
        }

        protected void DdlCausetype_SelectedIndexChanged(object sender, EventArgs e)
        {
            adp = new SqlDataAdapter("select cause_code from causetb where cause_description = '" + DdlCausetype.SelectedItem.Text + "' ", con);
            ds = new DataSet();
            adp.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0)
            {
                ViewState["CauseCode"] = ds.Tables[0].Rows[0]["cause_code"].ToString();
            }
        }

        protected void DdlDepart_SelectedIndexChanged(object sender, EventArgs e)
        {
            adp = new SqlDataAdapter("select dept_code from depttb where dept_description = '" + DdlDepart.SelectedItem.Text + "' ", con);
            ds = new DataSet();
            adp.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0)
            {
                ViewState["DepartCode"] = ds.Tables[0].Rows[0]["dept_code"].ToString();
            }
        }
    }
}