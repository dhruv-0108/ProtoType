using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Globalization;
using System.Data.Common;

namespace ProtoType
{
    public partial class DataProcess : System.Web.UI.Page
    {
        public static string scon = ConfigurationManager.ConnectionStrings["LTprojectdb"].ConnectionString;
        SqlConnection con = new SqlConnection(scon);
        DataSet ds = new DataSet();
        SqlDataAdapter adp = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();
        public static int rid;
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
            adp = new SqlDataAdapter("select * from MAIN_DATA_R where record_id = " + Convert.ToInt32(Session["rid"])+" ", con);
            ds = new DataSet();
            adp.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0)
            {
                GVDprocess.DataSource = ds.Tables[0];
                GVDprocess.DataBind();
            }
        }

        protected void GVDprocess_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int r = GVDprocess.EditIndex;
            TextBox rid = (TextBox)GVDprocess.Rows[r].FindControl("lblrid2");
            TextBox edesc = (TextBox)GVDprocess.Rows[r].FindControl("lblequip2");
            TextBox sdate = (TextBox)GVDprocess.Rows[r].FindControl("lblsdate2");
            TextBox stime = (TextBox)GVDprocess.Rows[r].FindControl("lblstime2");
            TextBox edate = (TextBox)GVDprocess.Rows[r].FindControl("lbledate2");
            TextBox etime = (TextBox)GVDprocess.Rows[r].FindControl("lbletime2");
            TextBox mcode = (TextBox)GVDprocess.Rows[r].FindControl("lblmcode2");
            TextBox ccode = (TextBox)GVDprocess.Rows[r].FindControl("lblccode2");
            TextBox dcode = (TextBox)GVDprocess.Rows[r].FindControl("lblrdcode2");

            string sd = sdate.Text.Trim();
            string st = stime.Text.Trim();
            string sdst = sd + " " + st;
            DateTime sdd = DateTime.ParseExact(sdst, "dd-MM-yyyy HH:mm:ss", CultureInfo.InvariantCulture);
            string formattedStartDate = sdd.ToString("yyyy-MM-dd");
            string formattedsTime = sdd.ToString("hh:mm:ss");


            string ed = edate.Text.Trim();
            string et = etime.Text.Trim();
            string edet = ed + " " + et;
            DateTime de = DateTime.ParseExact(edet, "dd-MM-yyyy HH:mm:ss", CultureInfo.InvariantCulture);
            string formattedEndDate = de.ToString("yyyy-MM-dd");
            string formattedeTime = de.ToString("hh:mm:ss");

            TimeSpan t = de - sdd;

            cmd = new SqlCommand("update MAIN_DATA_R set start_date = @sdate, start_time = @stime, end_date= @edate,end_time= @etime,maint_code = @mcode, dept_code = @dcode, cause_code = @ccode, duration_min = @durr, update_by = @uby, update_time = @utime  where rid = @rid ", con);
            
            cmd.Parameters.Add("@sdate", SqlDbType.Date).Value = formattedStartDate;
            cmd.Parameters.Add("@stime", SqlDbType.Time).Value = formattedsTime;
            cmd.Parameters.Add("@edate", SqlDbType.Date).Value = formattedEndDate;
            cmd.Parameters.Add("@etime", SqlDbType.Time).Value = formattedeTime;
            cmd.Parameters.Add("@durr", SqlDbType.Int).Value = t.TotalMinutes;
            cmd.Parameters.Add("@mcode", SqlDbType.VarChar, 50).Value = mcode.Text;
            cmd.Parameters.Add("@dcode", SqlDbType.VarChar, 50).Value = dcode.Text;
            cmd.Parameters.Add("@ccode", SqlDbType.VarChar, 50).Value = ccode.Text;
            cmd.Parameters.Add("@uby", SqlDbType.Int).Value = Convert.ToInt32(Session["id"]);
            cmd.Parameters.Add("@utime", SqlDbType.Time).Value = DateTime.Now.ToString("HH:mm:ss");
            cmd.Parameters.Add("@rid", SqlDbType.Int).Value = Convert.ToInt32(rid.Text);
            
            cmd.ExecuteNonQuery();
            
            Response.Write("<script> alert('data updated" + rid.Text + "') ;</script>");
            
            GVDprocess.EditIndex = -1;
            BindGrid();
        }

        protected void GVDprocess_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GVDprocess.EditIndex = e.NewEditIndex;
            int r = GVDprocess.EditIndex;
            TextBox edate = (TextBox)GVDprocess.Rows[r].FindControl("lbledate");
            TextBox etime = (TextBox)GVDprocess.Rows[r].FindControl("lbletime");
            Session["edate"] = edate.Text.Trim();
            Session["etime"] = etime.Text.Trim();

            GridViewRow row = GVDprocess.Rows[e.NewEditIndex];
            Button splitButton = (Button)row.FindControl("btnsplit");

            if (splitButton != null)
            {
                splitButton.Visible = (e.NewEditIndex == GVDprocess.Rows.Count - 1);
            }

            BindGrid();
        }

        protected void GVDprocess_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if(e.CommandName == "Insert")
            {
                // 1 SPLIT ==> NO NEXT ROW AND BOTH START DATE TIME, END DATE TIME PRESENT ==}
                // LAST ROW SPLIT ==> THERE IS ONE ROW ABOVE AND NO NEXT ROW START DATE TIME IS NULL ==}
                // START DATE PRESENT NO END DATE NEXT ROW WITH ONLY END DATE ==}
                // START DATE PRESENT END DATE PRESENT ==}
                // START DATE PRESENT NO END DATE, NEXT ROW WITH NO END DATE START DATE ==}
                int lastRowIndex = GVDprocess.Rows.Count - 1;
                Button btnSplit = GVDprocess.Rows[lastRowIndex].FindControl("btnsplit") as Button;
                if (btnSplit != null)
                {
                    btnSplit.Visible = true;
                }
            }
        }

        protected void btnreturn_Click(object sender, EventArgs e)
        {
            HttpContext.Current.Session["rid"] = "";
            Response.Redirect("~/DataDisplay.aspx");
        }

        protected void btnupload_Click(object sender, EventArgs e)
        {
            

            try
            {
                adp = new SqlDataAdapter("select SUM(duration_min) as DUR from MAIN_DATA_R where record_id = " + Convert.ToInt32(Session["rid"]) + " ", con);
                ds = new DataSet();
                adp.Fill(ds);
                decimal durr = 0;
                if (ds.Tables[0].Rows.Count > 0)
                {
                    durr = Convert.ToDecimal(ds.Tables[0].Rows[0]["DUR"].ToString());
                }
                if (Convert.ToDecimal(Session["dur"]) == durr)
                {
                    cmd = new SqlCommand("update MAIN_DATA_P set resolve = 1 where record_id = " + Convert.ToInt32(Session["rid"]) + " ", con);
                    cmd.ExecuteNonQuery();
                    HttpContext.Current.Session["rid"] = "";
                    Response.Redirect("~/DataDisplay.aspx");
                }
            }
            
            catch
            {
                string message = "This is an alert message.";
                string script = $@"<script type='text/javascript'>alert('{message}');</script>";

                if (Page != null && !Page.ClientScript.IsStartupScriptRegistered("alertScript"))
                {
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "alertScript", script);
                }
            }
        }

       
    }
}