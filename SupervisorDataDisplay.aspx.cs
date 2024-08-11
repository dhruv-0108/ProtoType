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
    public partial class SupervisorDataDisplay : System.Web.UI.Page
    {
        public static string scon = ConfigurationManager.ConnectionStrings["LTprojectdb"].ConnectionString;
        SqlConnection con = new SqlConnection(scon);
        DataSet ds = new DataSet();
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

        protected void GVDevent_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            BindGrid();
            Session["rid"] = ds.Tables[0].Rows[e.RowIndex].ItemArray[0].ToString();
            Session["equip"] = ds.Tables[0].Rows[e.RowIndex].ItemArray[4].ToString();
            Response.Redirect("SupervisorDataProcess.aspx");
        }
    }
}