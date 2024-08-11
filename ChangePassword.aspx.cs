using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;

namespace ProtoType
{
    public partial class ChangePassword : System.Web.UI.Page
    {
        public static string scon = ConfigurationManager.ConnectionStrings["LTprojectdb"].ConnectionString;
        SqlConnection con = new SqlConnection(scon);
        SqlDataAdapter adp = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();
        DataSet ds = new DataSet();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (con.State == ConnectionState.Closed || con.State == ConnectionState.Broken)
            {
                con.Open();
                txtUser.Text = Session["user"].ToString();
            }
        }

        protected void cmdLogin_Click(object sender, EventArgs e)
        {
            adp = new SqlDataAdapter("select credentials from employeetb where name = '" + Session["user"] + "' ", con);
            ds = new DataSet();
            adp.Fill(ds);
            string oldpass = " ";
            if (ds.Tables[0].Rows.Count > 0)
            {
                oldpass = ds.Tables[0].Rows[0]["credentials"].ToString();
            }

            if(oldpass !=txtOldPassword.Text)
            {
                string message = "OLD PASSWORD IS WRONG";
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                sb.Append("<script type = 'text/javascript'>");
                sb.Append("window.onload=function(){");
                sb.Append("alert('");
                sb.Append(message);
                sb.Append("')};");
                sb.Append("</script>");
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", sb.ToString());
            }
            if(txtNewPassword.Text != txtRetypePassword.Text)
            {
                string message = "PASSWORDS DOES NOT MATCH";
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                sb.Append("<script type = 'text/javascript'>");
                sb.Append("window.onload=function(){");
                sb.Append("alert('");
                sb.Append(message);
                sb.Append("')};");
                sb.Append("</script>");
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", sb.ToString());
            }
            if(txtNewPassword.Text == txtRetypePassword.Text && oldpass==txtOldPassword.Text)
            {
                    cmd = new SqlCommand("update employeetb set credentials = '"+txtRetypePassword.Text+"' where name = '" + Session["user"].ToString() +"' ",con);
                    cmd.ExecuteNonQuery();
                    Response.Redirect("Profile.aspx");
            }
        }
    }
}