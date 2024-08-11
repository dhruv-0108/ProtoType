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
    public partial class StdReportHalfYear : System.Web.UI.Page
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
                BindGrid();
            }
        }
        protected void BindGrid()
        {
            adp = new SqlDataAdapter("SELECT (1 - (SUM(duration_min)/DATEDIFF(MINUTE, DATEADD(MONTH, -6, GETDATE()), GETDATE())))*100 as AVAILABLE,function_desc FROM MAIN_DATA_R WHERE start_date >= DATEADD(MONTH,-6,GETDATE()) AND start_date <= GETDATE() GROUP BY function_desc", con);
            ds = new DataSet();
            adp.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0)
            {
                GVDreport.DataSource = ds.Tables[0];
                GVDreport.DataBind();
            }
        }

        protected void btncolumn_Click(object sender, EventArgs e)
        {
            Response.Redirect("HalfYearlyColumn.aspx");
        }

        protected void btnpie_Click(object sender, EventArgs e)
        {
            Response.Redirect("HalfYearlyPie.aspx");
        }

        protected void refreshbtn_Click(object sender, EventArgs e)
        {
            BindGrid();
        }
    }
}