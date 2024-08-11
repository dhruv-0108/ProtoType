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
    public partial class UserEntryPage : System.Web.UI.Page
    {
        public static string scon = ConfigurationManager.ConnectionStrings["LTprojectdb"].ConnectionString;
        SqlConnection con = new SqlConnection(scon);
        DataSet ds = new DataSet();
        DataSet ds2 = new DataSet();
        DataSet ds3 = new DataSet();
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
                BindHr();
                BindMin();
                BindEquip();
                BindGrid();
            }

        }
       
        protected void BindHr()
        {
          
            for (int i = 0; i < 24; i++)
            {
                DdlStartHr.Items.Insert(i , new ListItem(i.ToString(), i.ToString()));
                DdlEndHr.Items.Insert(i, new ListItem(i.ToString(), i.ToString()));
            }
        }
        protected void BindMin()
        {

            for (int i = 0; i < 60; i++)
            {
                DdlStartMin.Items.Insert(i, new ListItem(Convert.ToString(i), Convert.ToString(i)));
                DdlEndMin.Items.Insert(i , new ListItem(Convert.ToString(i), Convert.ToString(i)));
            }


        }

        protected void BindGrid()
        {
            adp = new SqlDataAdapter("select top 10 * from MAIN_DATA_P  where function_code = '" + Session["function_code"] + "' order by record_id desc ", con);
            ds = new DataSet();
            adp.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0)
            {
                EventGrid.DataSource = ds.Tables[0];
                EventGrid.DataBind();
            }
        }
        protected void BindEquip()
        {
            adp = new SqlDataAdapter("select distinct equip_desc from equipmenttb where function_code = '" + Session["function_code"].ToString() + "'", con);
            ds2 = new DataSet();
            adp.Fill(ds2);
            if (ds2.Tables[0].Rows.Count > 0)
            {
                DataRow initialRow = ds2.Tables[0].NewRow();
                initialRow["equip_desc"] = "SELECT EQUIPMENT";
                ds2.Tables[0].Rows.InsertAt(initialRow, 0);

                equipddl.DataSource = ds2.Tables[0];
                equipddl.DataTextField = "equip_desc";
                equipddl.DataValueField = "equip_desc";
                equipddl.DataBind();
            }
        }

        protected void UPLOAD_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {

                string iStrtDtString = txtExecStartDate.Text;
                string iEndDtString = txtExecEndDate.Text;

                if (!String.IsNullOrEmpty(iStrtDtString) && !String.IsNullOrEmpty(iEndDtString) && !string.IsNullOrEmpty(DdlStartHr.SelectedItem.Text) && !string.IsNullOrEmpty(DdlEndHr.SelectedItem.Text) && !string.IsNullOrEmpty(DdlStartMin.SelectedItem.Text) && !string.IsNullOrEmpty(DdlEndMin.SelectedItem.Text))
                {
                    string e_desc = equipddl.SelectedItem.Text;

                    adp = new SqlDataAdapter("select * from equipmenttb where equip_desc = '" + e_desc + "' ", con);
                    ds3 = new DataSet();
                    adp.Fill(ds3);
                    string function_desc = " ";
                    string equip_code = " ";
                    if (ds3.Tables[0].Rows.Count > 0)
                    {
                        function_desc = ds3.Tables[0].Rows[0]["function_desc"].ToString();
                        equip_code = ds3.Tables[0].Rows[0]["equip_code"].ToString();
                    }


                    DateTime oStrtDate = DateTime.ParseExact(iStrtDtString, "MM/dd/yyyy", System.Globalization.CultureInfo.InvariantCulture);
                    int Strtyear = oStrtDate.Year;
                    int Strtmonth = oStrtDate.Month;
                    int Strtday = oStrtDate.Day;
                    int Strthour = Convert.ToInt32(DdlStartHr.SelectedItem.Value);
                    int Strtminute = Convert.ToInt32(DdlStartMin.SelectedItem.Value);

                    DateTime oEndDate = DateTime.ParseExact(iEndDtString, "MM/dd/yyyy", System.Globalization.CultureInfo.InvariantCulture);
                    int Endyear = oEndDate.Year;
                    int Endmonth = oEndDate.Month;
                    int Endday = oEndDate.Day;
                    int Endhour = Convert.ToInt32(DdlEndHr.SelectedItem.Value);
                    int Endminute = Convert.ToInt32(DdlEndMin.SelectedItem.Value);

                    DateTime dtStrtDate = new DateTime(Strtyear, Strtmonth, Strtday, Strthour, Strtminute, 0);
                    DateTime dtEndDate = new DateTime(Endyear, Endmonth, Endday, Endhour, Endminute, 0);
                    int value = DateTime.Compare(dtStrtDate, dtEndDate);
                    int Nowvalue = DateTime.Compare(dtEndDate, DateTime.Now);

                    TimeSpan ts = new TimeSpan(Strthour, Strtminute, 0);
                    TimeSpan te = new TimeSpan(Endhour, Endminute, 0);

                    if (value >= 0)
                    {
                        string script = "setTimeout(function(){ alert('END DATE IS LESS THEN START DATE!!'); }, 100);";
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
                    }

                    if (Nowvalue >= 0)
                    {
                        string script = "setTimeout(function(){ alert('END DATE IS EXCEEEDDING TODAYS DATE!!'); }, 100);";
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
                    }

                    if (value < 0 && Nowvalue < 0)
                    {
                        TimeSpan min_diff = dtEndDate - dtStrtDate;

                        cmd = new SqlCommand("insert into MAIN_DATA_P(function_code,function_desc,equip_code,equip_desc,Id,start_date,start_time,end_date,end_time,resolve,duration_min) values('" + Session["function_code"] + "','" + function_desc + "','" + equip_code + "','" + e_desc + "'," + Convert.ToInt32(Session["id"]) + ",'" + txtExecStartDate.Text + "','" + ts.ToString() + "','" + txtExecEndDate.Text + "','" + te.ToString() + "',0," + (decimal)min_diff.TotalMinutes + "); SELECT SCOPE_IDENTITY()", con);
                        int generatedKey = Convert.ToInt32(cmd.ExecuteScalar());

                        SqlCommand cmd1 = new SqlCommand();
                        cmd1 = new SqlCommand("insert into MAIN_DATA_R(record_id,function_desc,equip_desc,start_date,start_time,end_date,end_time,duration_min,equip_code) values(" + generatedKey + ",'" + function_desc + "','" + e_desc + "','" + txtExecStartDate.Text + "','" + ts.ToString() + "','" + txtExecEndDate.Text + "','" + te.ToString() + "'," + (decimal)min_diff.TotalMinutes + ",'" + equip_code + "')", con);
                        cmd1.ExecuteNonQuery();

                        string script = "setTimeout(function(){ alert('DATA ADDED SUCCESSFULLY'); }, 100);";
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);

                        txtExecEndDate.Text = " ";
                        txtExecStartDate.Text = " ";

                        BindGrid();
                    }

                }
                else
                {
                    string script = "setTimeout(function(){ alert('PLEASE ENTER END DATE AND START DATE'); }, 100);";
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
                }

            }

        }
    }
}