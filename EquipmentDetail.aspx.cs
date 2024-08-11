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
    public partial class EquipmentDetail : System.Web.UI.Page
    {
        public static string scon = ConfigurationManager.ConnectionStrings["LTprojectdb"].ConnectionString;
        SqlConnection con = new SqlConnection(scon);
        SqlDataAdapter adp = new SqlDataAdapter();
        DataSet ds = new DataSet();
        DataSet ds2 = new DataSet();
        DataSet ds_fcode = new DataSet();
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
                filldept();
            }
        }

        public void filldept()
        {
            adp = new SqlDataAdapter("select distinct dept_description from depttb", con);
            ds2 = new DataSet();
            adp.Fill(ds2);
            if (ds2.Tables[0].Rows.Count>0)
            {
                Ddlfunctiondesc.DataSource = ds2.Tables[0];
                Ddlfunctiondesc.DataTextField = "dept_description";
                Ddlfunctiondesc.DataValueField = "dept_description";
                Ddlfunctiondesc.DataBind();
            }
        }
        public void fillgrid()
        {
            adp = new SqlDataAdapter("select * from equipmenttb", con);
            ds = new DataSet();
            adp.Fill(ds);
            equipgrid.DataSource = ds;
            equipgrid.DataBind();
        }

        protected void equipgrid_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            equipgrid.EditIndex = -1;
            fillgrid();
        }

        protected void equipgrid_RowEditing(object sender, GridViewEditEventArgs e)
        {
            equipgrid.EditIndex = e.NewEditIndex;
            fillgrid();
        }

        protected void enterbtn_Click(object sender, EventArgs e)
        {
            // Perform validation for ddlfunctiondesc
            if (string.IsNullOrEmpty(Ddlfunctiondesc.SelectedValue))
            {
                lblErroMsg.Text = "Please select a function description.";
                lblErroMsg.Visible = true;
                return;
            }

            // Perform validation for tcode
            if (string.IsNullOrEmpty(tcode.Text.Trim()))
            {
                lblErroMsg.Text = "Please enter a code.";
                lblErroMsg.Visible = true;
                return;
            }

            // Perform validation for tdesc
            if (string.IsNullOrEmpty(tdesc.Text.Trim()))
            {
                lblErroMsg.Text = "Please enter a description.";
                lblErroMsg.Visible = true;
                return;
            }

            // Perform validation for ddlequipclass
            if (string.IsNullOrEmpty(Ddlequipclass.SelectedValue))
            {
                lblErroMsg.Text = "Please select an equipment class.";
                lblErroMsg.Visible = true;
                return;
            }

            // Perform validation for chlstatus
            if (Chlstatus.SelectedIndex == -1)
            {
                lblErroMsg.Text = "Please select a status.";
                lblErroMsg.Visible = true;
                return;
            }

            
            string function_desc = Ddlfunctiondesc.SelectedItem.Text;
            int fetchedno = 1;
            adp = new SqlDataAdapter("select record_id from depttb where dept_description = '"+function_desc+"' ", con);
            ds_fcode = new DataSet();
            adp.Fill(ds_fcode);
            if (ds_fcode.Tables[0].Rows.Count> 0 )
            {
                fetchedno = Convert.ToInt32(ds_fcode.Tables[0].Rows[0]["record_id"].ToString()) + 110;
            }
            
            string function_code = fetchedno.ToString();
               
            string equip_code = tcode.Text;
            string equip_desc = tdesc.Text;
            string equip_class = Ddlequipclass.SelectedItem.Text;
            
            int s = 0;
            if (Chlstatus.SelectedItem.Text == "OK")
            {
                s = 1;
            }
            if (Chlstatus.SelectedItem.Text == "NOT OK")
            {
                s = 0;
            }
            cmd = new SqlCommand("insert into equipmenttb(function_code,function_desc,equip_code,equip_desc,equip_class,active_status) values('" + function_code + "','" + function_desc + "','" + equip_code + "','" + equip_desc + "','" + equip_class + "'," + s + ")", con);
            cmd.ExecuteNonQuery();
            tcode.Text = " ";
            tdesc.Text = " ";
            Ddlequipclass.SelectedIndex = 0;
            Ddlfunctiondesc.SelectedIndex = 0;
            Chlstatus.SelectedIndex = -1;
            fillgrid();
            
        }

        protected void equipgrid_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int r = equipgrid.EditIndex;
            Label lid = (Label)equipgrid.Rows[r].FindControl("lblid2");
            TextBox tfcode = (TextBox)equipgrid.Rows[r].FindControl("txtfcode");
            TextBox tfdesc = (TextBox)equipgrid.Rows[r].FindControl("txtfdesc");
            TextBox tecode = (TextBox)equipgrid.Rows[r].FindControl("txtecode");
            TextBox tedesc = (TextBox)equipgrid.Rows[r].FindControl("txtedesc");
            TextBox tclass = (TextBox)equipgrid.Rows[r].FindControl("txtclass");
            CheckBoxList cbl = (CheckBoxList)equipgrid.Rows[r].FindControl("cblstatus");
            int active_status = 0;
            if (cbl.SelectedItem.Text == "OK")
            {
                active_status = 1;
            }
            if (cbl.SelectedItem.Text == "NOT OK")
            {
                active_status = 0;
            }

            cmd = new SqlCommand("update equipmenttb set function_code='" + tfcode.Text + "',function_desc='" + tfdesc.Text + "',equip_code = '"+tecode.Text+"' ,equip_desc='"+tedesc.Text+"',equip_class = '"+tclass.Text+"',active_status=" + active_status + "  where record_id = " + Convert.ToInt32(lid.Text) + "", con);
            cmd.ExecuteNonQuery();
            equipgrid.EditIndex = -1;
            fillgrid();
        }
    }
}