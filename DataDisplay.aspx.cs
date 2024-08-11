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
using System.Globalization;

namespace ProtoType
{
    public partial class DataDisplay : System.Web.UI.Page
    {
        public static string scon = ConfigurationManager.ConnectionStrings["LTprojectdb"].ConnectionString;
        SqlConnection con = new SqlConnection(scon);
        DataSet ds = new DataSet();
        DataSet ds1 = new DataSet();
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
            adp = new SqlDataAdapter("select * from MAIN_DATA_P where resolve = 0", con);
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
            int r = e.RowIndex;
            TextBox rid = (TextBox)GVDevent.Rows[r].FindControl("lblid");
            TextBox dur = (TextBox)GVDevent.Rows[r].FindControl("lbldur");
            Session["rid"] = rid.Text;
            Session["dur"] = dur.Text;
            Response.Redirect("SupervisorDataProcess.aspx");
        }
    }
}