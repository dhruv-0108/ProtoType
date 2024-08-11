using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Reflection.Emit;
using System.Text;
using Newtonsoft.Json;
using System.Web.Services;
using System.Runtime.InteropServices;
using System.Globalization;
using System.Diagnostics;


namespace ProtoType
{
    public partial class SupervisorDataProcess : System.Web.UI.Page
    {
        public static string scon = ConfigurationManager.ConnectionStrings["LTprojectdb"].ConnectionString;
        SqlConnection con = new SqlConnection(scon);
        DataSet ds = new DataSet();
        DataSet dsm = new DataSet();
        DataSet dsc= new DataSet();
        DataSet dsrd = new DataSet();
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
                fillmaint();
                fillcause();
                fillresdept();
            }

        }

        

        protected void BindGrid()
        {
            adp = new SqlDataAdapter("select * from MAIN_DATA_R where record_id = " + Convert.ToInt32(Session["rid"]) + " ", con);
            ds = new DataSet();
            adp.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0)
            {
                GVDprocess.DataSource = ds.Tables[0];
                GVDprocess.DataBind();
            }
        }
        protected void btnreturn_Click(object sender, EventArgs e)
        {
            HttpContext.Current.Session["rid"] = "";
            Response.Redirect("~/DataDisplay.aspx");
        }

        protected void btnupload_Click(object sender, EventArgs e)
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
                    bool allCellsFilled = true;

                    foreach (GridViewRow row in GVDprocess.Rows)
                    {
                    TextBox rid = (TextBox)row.FindControl("lblrid");
                    TextBox sdate = (TextBox)row.FindControl("lblsdate");
                    TextBox stime = (TextBox)row.FindControl("lblstime");
                    TextBox edate = (TextBox)row.FindControl("lbledate");
                    TextBox etime = (TextBox)row.FindControl("lbletime");
                    TextBox mcode = (TextBox)row.FindControl("lblmcode");
                    TextBox ccode = (TextBox)row.FindControl("lblccode");
                    TextBox dcode = (TextBox)row.FindControl("lblrdcode");
                    for (int i = 0; i < row.Cells.Count; i++)
                    {
                         if (string.IsNullOrEmpty(rid.Text) || string.IsNullOrEmpty(sdate.Text) || string.IsNullOrEmpty(stime.Text)|| string.IsNullOrEmpty(edate.Text) || string.IsNullOrEmpty(etime.Text) || string.IsNullOrEmpty(mcode.Text) || string.IsNullOrEmpty(ccode.Text) || string.IsNullOrEmpty(dcode.Text))
                         {
                             allCellsFilled = false;
                             break;
                         }
                     
                    }

                    if (!allCellsFilled)
                    {
                         break;
                    }
                }

                if (allCellsFilled)
                {
                    // All cells are filled, update the resolve value to 1
                    int recordId = Convert.ToInt32(Session["rid"]);

                    cmd = new SqlCommand("update MAIN_DATA_P set resolve = 1 where record_id = @rid", con);
                    cmd.Parameters.Add("@rid", SqlDbType.Int).Value = Convert.ToInt32(Session["rid"]);
                    cmd.ExecuteNonQuery();

                    HttpContext.Current.Session["rid"] = "";
                    Response.Redirect("~/DataDisplay.aspx");
                }
                else
                {
                    // Handle the case where there are empty cells
                    string script = "setTimeout(function(){ alert('ALL DATA ARE NOT UPDATED, SOME OF THE DATA ARE YET TO PROCESS'); }, 100);";
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
                }
            }
            else
            {
                string script = "setTimeout(function(){ alert('TOTAL TIME DOES NOT MATCH!! PROCESS ALL THE TIME FRAME PROPERLY.'); }, 100);";
                ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);

            }
        }

        protected void GVDprocess_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GVDprocess.EditIndex = e.NewEditIndex;
            int r = GVDprocess.EditIndex;
            ViewState["row"] = r;
            BindGrid();
        }

        protected void GVDprocess_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            //FETCHING EDITING ROW INDEX AND INDEX OF NEXT ROW
            int r = GVDprocess.EditIndex;
            int rn = r + 1;

            //FETCH VALUES OF ROW WHICH IS EDITED
            TextBox rid = (TextBox)GVDprocess.Rows[r].FindControl("lblrid2");
            TextBox sdate = (TextBox)GVDprocess.Rows[r].FindControl("lblsdate2");
            TextBox stime = (TextBox)GVDprocess.Rows[r].FindControl("lblstime2");
            TextBox edate = (TextBox)GVDprocess.Rows[r].FindControl("lbledate2");
            TextBox etime = (TextBox)GVDprocess.Rows[r].FindControl("lbletime2");
            TextBox mcode = (TextBox)GVDprocess.Rows[r].FindControl("lblmcode2");
            TextBox ccode = (TextBox)GVDprocess.Rows[r].FindControl("lblccode2");
            TextBox dcode = (TextBox)GVDprocess.Rows[r].FindControl("lblrdcode2");

            //CHECKING IF ALL REQUIRED CODE ARE PRESENT AND UPDATING DATABASE WITH IT

            if(!string.IsNullOrEmpty(mcode.Text) && !string.IsNullOrEmpty(dcode.Text) && !string.IsNullOrEmpty(ccode.Text))
            {

                cmd = new SqlCommand("update MAIN_DATA_R set maint_code = @mcode, dept_code = @dcode, cause_code = @ccode, update_by = @uby, update_time = @utime  where rid = @rid ", con);

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
            } // CHECKING IF START DATE TIME AND END DATE TIME IS NOT EMPTY
            else if(!string.IsNullOrEmpty(sdate.Text) && !string.IsNullOrEmpty(stime.Text) && !string.IsNullOrEmpty(edate.Text) && !string.IsNullOrEmpty(etime.Text))
            {
                //
                string sd = sdate.Text.Trim();
                string st = stime.Text.Trim();
                string sdst = sd + " " + st;
                DateTime sdd = DateTime.ParseExact(sdst, "dd-MM-yyyy HH:mm:ss", CultureInfo.InvariantCulture);
                string formattedStartDate = sdd.ToString("yyyy-MM-dd");
                string formattedsTime = sdd.ToString("hh:mm:ss");

                // FETCHING END DATE TIME TO ENTER AS START DATE TIME OF NEW RECORD
                string ed = edate.Text.Trim();
                string et = etime.Text.Trim();
                string edet = ed + " " + et;
                DateTime de = DateTime.ParseExact(edet, "dd-MM-yyyy HH:mm:ss", CultureInfo.InvariantCulture);
                string formattedEndDate = de.ToString("yyyy-MM-dd");
                string formattedeTime = de.ToString("hh:mm:ss");

                //FOR DURATION CALCULATION
                TimeSpan t = de - sdd;

                //FETCHING END DATE FROM PROBLEM TABLE WHICH IS ENTERED BY ENGINEER
                adp = new SqlDataAdapter("select function_desc,end_date,end_time,equip_code from MAIN_DATA_P where record_id = " + Convert.ToInt32(Session["rid"]) + " ", con);
                ds = new DataSet();
                adp.Fill(ds);

                string ed_f = "";
                string et_f = "";
                string fdesc = "";
                string ecode = "";
                if (ds.Tables[0].Rows.Count > 0)
                {
                    string endDateString = ds.Tables[0].Rows[0]["end_date"].ToString();
                    string[] parts = endDateString.Split(new[] { ' ' }, 2, StringSplitOptions.RemoveEmptyEntries);
                    ed_f = parts[0];
                    et_f = ds.Tables[0].Rows[0]["end_time"].ToString();
                    fdesc = ds.Tables[0].Rows[0]["function_desc"].ToString();
                    ecode = ds.Tables[0].Rows[0]["equip_code"].ToString();
                }

                //CONVERSION FOR END DATE FOR NEW RECORD

                string df_dt = ed_f + " " + et_f;
                DateTime de_f = DateTime.ParseExact(df_dt, "dd-MM-yyyy HH:mm:ss", CultureInfo.InvariantCulture);
                string formattedEndDatef = de_f.ToString("yyyy-MM-dd");
                string formattedeTimef = de_f.ToString("hh:mm:ss");

                int v = DateTime.Compare(de,de_f);

                if(v < 0)
                {
                    //UPDATING EDITING ROW'S END DATE TIME AND DURATION
                    cmd = new SqlCommand("update MAIN_DATA_R set end_date = @edate, end_time = @etime , duration_min = @durr where rid = @rid", con);
                    cmd.Parameters.Add("@edate", SqlDbType.Date).Value = formattedEndDate;
                    cmd.Parameters.Add("@etime", SqlDbType.Time).Value = formattedeTime;
                    cmd.Parameters.Add("@durr", SqlDbType.Int).Value = t.TotalMinutes;
                    cmd.Parameters.Add("@rid", SqlDbType.Int).Value = Convert.ToInt32(rid.Text);
                    cmd.ExecuteNonQuery();

                    // CHECKING IF NEXT ROW EXISTS OR NOT
                    if (rn <= GVDprocess.Rows.Count)
                    {
                        // FETHCING RID AND END DATE OF NEXT ROW
                        TextBox rid_next = (TextBox)GVDprocess.Rows[rn].FindControl("lblrid");
                        TextBox edate_next = (TextBox)GVDprocess.Rows[rn].FindControl("lbledate");
                        TextBox etime_next = (TextBox)GVDprocess.Rows[rn].FindControl("lbletime");

                        // CHECKING IF THE NEXT ROW HAS NO END DATE TIME THEN NO DURATION IS CALCULATED
                        if (string.IsNullOrEmpty(edate_next.Text) && string.IsNullOrEmpty(etime_next.Text))
                        {
                            SqlCommand cmd1 = new SqlCommand();
                            cmd1 = new SqlCommand("update MAIN_DATA_R set  start_date = @sdate , start_time = @stime where rid = @rid", con);
                            cmd1.Parameters.Add("@sdate", SqlDbType.Date).Value = formattedEndDate;
                            cmd1.Parameters.Add("@stime", SqlDbType.Time).Value = formattedeTime;
                            cmd1.Parameters.Add("@rid", SqlDbType.Int).Value = Convert.ToInt32(rid_next.Text);
                            cmd1.ExecuteNonQuery();
                        }
                        //CHECKING IF END DAET TIME OF NEXT ROW EXISTS SO UPDATING DURATION
                        if (!string.IsNullOrEmpty(edate_next.Text) && !string.IsNullOrEmpty(etime_next.Text))
                        {
                            string edf = edate_next.Text.Trim();
                            string etf = etime_next.Text.Trim();
                            string edfetf = edf + " " + etf;
                            DateTime finalend = DateTime.ParseExact(edfetf, "dd-MM-yyyy HH:mm:ss", CultureInfo.InvariantCulture);
                            string formatED = finalend.ToString("yyyy-MM-dd");
                            string formatET = finalend.ToString("hh:mm:ss");

                            TimeSpan TF = finalend - de;

                            SqlCommand cmd1 = new SqlCommand();
                            cmd1 = new SqlCommand("update MAIN_DATA_R set  start_date = @sdate , start_time = @stime, duration_min = @durr where rid = @rid", con);
                            cmd1.Parameters.Add("@sdate", SqlDbType.Date).Value = formattedEndDate;
                            cmd1.Parameters.Add("@stime", SqlDbType.Time).Value = formattedeTime;
                            cmd1.Parameters.Add("@durr", SqlDbType.Int).Value = TF.TotalMinutes;
                            cmd1.Parameters.Add("@rid", SqlDbType.Int).Value = Convert.ToInt32(rid_next.Text);
                            cmd1.ExecuteNonQuery();
                        }

                    }

                    GVDprocess.EditIndex = -1;
                    BindGrid();
                }
                else
                {
                    string script = "setTimeout(function(){ alert('ENTERED TIME IS GREATER THEN END TIME'); }, 100);";
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
                }
            }
            else
            {
                GVDprocess.EditIndex = -1;
                BindGrid();
            }
        }

        protected void GVDprocess_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Insert")
            {
                //FETCHING WHICH ROW IS PROCESSED
                int rowIndex = GVDprocess.EditIndex;
                int r_next = rowIndex + 1;
                GridViewRow row = GVDprocess.Rows[rowIndex];
                //FETCH VALUES FROM GRIDVIEW
                TextBox rid = (TextBox)row.FindControl("lblrid2");

                TextBox sdate = (TextBox)row.FindControl("lblsdate2");
                TextBox stime = (TextBox)row.FindControl("lblstime2");
                TextBox edesc = (TextBox)row.FindControl("lblequip2");
                TextBox edate = (TextBox)row.FindControl("lbledate2");
                TextBox etime = (TextBox)row.FindControl("lbletime2");

                //FETCHING END DATE FROM PROBLEM TABLE WHICH IS ENTERED BY ENGINEER
                adp = new SqlDataAdapter("select function_desc,end_date,end_time,equip_code from MAIN_DATA_P where record_id = " + Convert.ToInt32(Session["rid"]) + " ", con);
                ds = new DataSet();
                adp.Fill(ds);

                string ed_f = "";
                string et_f = "";
                string fdesc = "";
                string ecode = "";
                if (ds.Tables[0].Rows.Count > 0)
                {
                    string endDateString = ds.Tables[0].Rows[0]["end_date"].ToString();
                    string[] parts = endDateString.Split(new[] { ' ' }, 2, StringSplitOptions.RemoveEmptyEntries);
                    ed_f = parts[0];
                    et_f = ds.Tables[0].Rows[0]["end_time"].ToString();
                    fdesc = ds.Tables[0].Rows[0]["function_desc"].ToString();
                    ecode = ds.Tables[0].Rows[0]["equip_code"].ToString();
                }

                //CONVERSION FOR END DATE FOR NEW RECORD

                string df_dt = ed_f + " " + et_f;
                DateTime de_f = DateTime.ParseExact(df_dt, "dd-MM-yyyy HH:mm:ss", CultureInfo.InvariantCulture);
                string formattedEndDatef = de_f.ToString("yyyy-MM-dd");
                string formattedeTimef = de_f.ToString("hh:mm:ss");

                //IF START DATE ,START TIME, END DATE, END TIME IS NOT NULL THEN ENTER NEW RECORD WITH END DATE ADN REMOVE THE END DAET OF EXISITING RECORD
                //FIRST SPLIT

                if (!string.IsNullOrEmpty(sdate.Text) && !string.IsNullOrEmpty(edate.Text) && !string.IsNullOrEmpty(stime.Text) && !string.IsNullOrEmpty(etime.Text))
                {
                
                    cmd = new SqlCommand("insert into MAIN_DATA_R(record_id,function_desc,equip_desc,end_date,end_time,equip_code) values(@recid,@fdesc,@edesc,@edate,@etime,@ecode)", con);
                    cmd.Parameters.Add("@recid", SqlDbType.Int).Value = Convert.ToInt32(Session["rid"]);
                    cmd.Parameters.Add("@fdesc", SqlDbType.VarChar, 50).Value = fdesc;
                    cmd.Parameters.Add("@edesc", SqlDbType.VarChar, 50).Value = edesc.Text;
                    cmd.Parameters.Add("@edate", SqlDbType.Date).Value = formattedEndDatef;
                    cmd.Parameters.Add("@etime", SqlDbType.Time).Value = formattedeTimef;
                    cmd.Parameters.Add("@ecode", SqlDbType.VarChar, 50).Value = ecode;
                    cmd.ExecuteNonQuery();

                    // REMOVING END DATE OF CURRENT RECORD
                    SqlCommand cmd1 = new SqlCommand();
                    cmd1 = new SqlCommand("update MAIN_DATA_R set end_date = NULL , end_time = NULL , duration_min = NULL where rid = @rid ", con);
                    cmd1.Parameters.Add("@rid", SqlDbType.Int).Value = Convert.ToInt32(rid.Text);
                    cmd1.ExecuteNonQuery(); 

                    BindGrid();
                }

                if (r_next < GVDprocess.Rows.Count)
                {
                    
                    GridViewRow row_next = GVDprocess.Rows[r_next];

                    TextBox rid_next = (TextBox)row_next.FindControl("lblrid");
                    if (!string.IsNullOrEmpty(sdate.Text) && string.IsNullOrEmpty(edate.Text) && !string.IsNullOrEmpty(stime.Text) && string.IsNullOrEmpty(etime.Text))
                    {
                        cmd = new SqlCommand("insert into MAIN_DATA_R(record_id,function_desc,equip_desc,end_date,end_time,equip_code) values(@recid,@fdesc,@edesc,@edate,@etime,@ecode)", con);
                        cmd.Parameters.Add("@recid", SqlDbType.Int).Value = Convert.ToInt32(Session["rid"]);
                        cmd.Parameters.Add("@fdesc", SqlDbType.VarChar, 50).Value = fdesc;
                        cmd.Parameters.Add("@edesc", SqlDbType.VarChar, 50).Value = edesc.Text;
                        cmd.Parameters.Add("@edate", SqlDbType.Date).Value = formattedEndDatef;
                        cmd.Parameters.Add("@etime", SqlDbType.Time).Value = formattedeTimef;
                        cmd.Parameters.Add("@ecode", SqlDbType.VarChar, 50).Value = ecode;
                        cmd.ExecuteNonQuery();

                        SqlCommand cmd1 = new SqlCommand();
                        cmd1 = new SqlCommand("update MAIN_DATA_R set end_date = NULL , end_time = NULL , duration_min = NULL where rid = @rid ", con);
                        cmd1.Parameters.Add("@rid", SqlDbType.Int).Value = Convert.ToInt32(rid_next.Text);
                        cmd1.ExecuteNonQuery();

                        BindGrid();
                    }

                }
                
            }
        }

        public void fillmaint()
        {
            string query = "SELECT maint_code,maint_description from maintenancetb";
            adp = new SqlDataAdapter(query, con);
            dsm = new DataSet();
            adp.Fill(dsm);
            if (dsm.Tables[0].Rows.Count > 0)
            {
                ddlmaint.DataSource = dsm.Tables[0];
                ddlmaint.DataTextField = "maint_description";
                ddlmaint.DataValueField = "maint_code";
                ddlmaint.DataBind();
            }
        }

        public void fillcause()
        {
            string query = "SELECT cause_code,cause_description from causetb";
            adp = new SqlDataAdapter(query, con);
            dsc = new DataSet();
            adp.Fill(dsc);
            if (dsm.Tables[0].Rows.Count > 0)
            {
                ddlcause.DataSource = dsc.Tables[0];
                ddlcause.DataTextField = "cause_description";
                ddlcause.DataValueField = "cause_code";
                ddlcause.DataBind();
            }
        }

        public void fillresdept()
        {
            string query = "SELECT dept_code,dept_description from depttb";
            adp = new SqlDataAdapter(query, con);
            dsrd = new DataSet();
            adp.Fill(dsrd);
            if (dsrd.Tables[0].Rows.Count > 0)
            {
                ddlResponsible.DataSource = dsrd.Tables[0];
                ddlResponsible.DataTextField = "dept_description";
                ddlResponsible.DataValueField = "dept_code";
                ddlResponsible.DataBind();
            }
        }

       

        protected void ddlmaint_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                if (ViewState["row"] != null)
                {
                    int rowindex = (int)ViewState["row"];
                    TextBox maintcode = (TextBox)GVDprocess.Rows[rowindex].FindControl("lblmcode2");

                    maintcode.Text = ddlmaint.SelectedValue;
                }
                else
                {
                    string script = "setTimeout(function(){ alert('Please select a row to update first.'); }, 100);";
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
                }
            }
            catch (Exception ex)
            {
                string script = "setTimeout(function(){ alert('An error occurred: " + ex.Message.Replace("'", "\\'") + "'); }, 100);";
                ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
            }
        }

        protected void ddlcause_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                if (ViewState["row"] != null)
                {
                    int rowindex = (int)ViewState["row"];
                    TextBox causecode = (TextBox)GVDprocess.Rows[rowindex].FindControl("lblccode2");

                    causecode.Text = ddlcause.SelectedValue;
                }
                else
                {
                    string script = "setTimeout(function(){ alert('Please select a row to update first.'); }, 100);";
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
                }
            }
            catch (Exception ex)
            {
                string script = "setTimeout(function(){ alert('An error occurred: " + ex.Message.Replace("'", "\\'") + "'); }, 100);";
                ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
            }
        }

        protected void ddlResponsible_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                if (ViewState["row"] != null)
                {
                    int rowindex = (int)ViewState["row"];
                    TextBox rescode = (TextBox)GVDprocess.Rows[rowindex].FindControl("lblrdcode2");

                    rescode.Text = ddlResponsible.SelectedValue;
                }
                else
                {
                    string script = "setTimeout(function(){ alert('Please select a row to update first.'); }, 100);";
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
                }
            }
            catch (Exception ex)
            {
                string script = "setTimeout(function(){ alert('An error occurred: " + ex.Message.Replace("'", "\\'") + "'); }, 100);";
                ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
            }
        }
    }
}