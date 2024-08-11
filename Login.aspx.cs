using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace ProtoType
{
    public partial class Login : System.Web.UI.Page
    {
        public static string scon = ConfigurationManager.ConnectionStrings["LTprojectdb"].ConnectionString;
        SqlConnection con = new SqlConnection(scon);
        SqlDataAdapter adp = new SqlDataAdapter();
        DataSet ds = new DataSet();
        protected void Page_Load(object sender, EventArgs e)
        {
            if(con.State == ConnectionState.Closed || con.State == ConnectionState.Broken)
            {
                con.Open();
            }
        }

        protected void ForgotPassword_Click(object sender, EventArgs e)
        {
            Response.Redirect("ForgotPassword.aspx");
        }

        protected void cmdLogin_Click(object sender, EventArgs e)
        {
            adp = new SqlDataAdapter("select * from employeetb where name='"+txtUser.Text+"' and credentials = '"+txtPassword.Text+"' ", con);
            ds = new DataSet();
            adp.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0)
            {
                if(ds.Tables[0].Rows[0]["position"].ToString() == "ENGINEER")
                {
                    Session["id"] = ds.Tables[0].Rows[0]["Id"].ToString();
                    Session["user"] = ds.Tables[0].Rows[0]["name"].ToString();
                    Session["position"] = ds.Tables[0].Rows[0]["position"].ToString();
                    Session["function_code"] = ds.Tables[0].Rows[0]["deptcode"].ToString();
                    Response.Redirect("UserEntryPage.aspx");
                }
                if (ds.Tables[0].Rows[0]["position"].ToString() == "SUPERVISOR")
                {
                    Session["id"] = ds.Tables[0].Rows[0]["Id"].ToString();
                    Session["user"] = ds.Tables[0].Rows[0]["name"].ToString();
                    Session["position"] = ds.Tables[0].Rows[0]["position"].ToString();
                    Session["function_code"] = ds.Tables[0].Rows[0]["deptcode"].ToString();
                    Response.Redirect("DataDisplay.aspx");
                }
                if (ds.Tables[0].Rows[0]["position"].ToString() == "DEPARTMENT HEAD")
                {
                    Session["id"] = ds.Tables[0].Rows[0]["Id"].ToString();
                    Session["user"] = ds.Tables[0].Rows[0]["name"].ToString();
                    Session["position"] = ds.Tables[0].Rows[0]["position"].ToString();
                    Session["function_code"] = ds.Tables[0].Rows[0]["deptcode"].ToString();
                    Response.Redirect("DepartmentHead.aspx");
                }
            }
                
            
        }
    }
}