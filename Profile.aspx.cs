using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
namespace ProtoType
{
    public partial class Profile : System.Web.UI.Page
    {
        public static string scon = ConfigurationManager.ConnectionStrings["LTprojectdb"].ConnectionString;
        SqlConnection con = new SqlConnection(scon);
        SqlDataAdapter adp = new SqlDataAdapter();
        DataSet ds = new DataSet();
        DataTable dt = new DataTable();
        SqlCommand cmd = new SqlCommand();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (con.State == ConnectionState.Broken || con.State == ConnectionState.Closed)
            {
                con.Open();

            }
            if (!IsPostBack)
            {

                BindProfile();
            }
        }

        public void BindProfile()
        {
            adp = new SqlDataAdapter("select * from employeetb where name= '" + Session["user"].ToString() + "' ", con);
            ds = new DataSet();
            adp.Fill(ds);

            string name = " ";
            string city = " ";
            string contact = " ";
            string email = " ";
            string address = " ";
            string position = " ";
            string credentials = " ";

            if (ds.Tables[0].Rows.Count > 0)
            {
                name = ds.Tables[0].Rows[0]["name"].ToString();
                city = ds.Tables[0].Rows[0]["city"].ToString();
                contact = ds.Tables[0].Rows[0]["contact"].ToString();
                email = ds.Tables[0].Rows[0]["email"].ToString();
                address = ds.Tables[0].Rows[0]["address"].ToString();
                position = ds.Tables[0].Rows[0]["position"].ToString();
                credentials = ds.Tables[0].Rows[0]["credentials"].ToString();
            }



            txtname.Text = name;
            txtcity.Text = city;
            txtcontact.Text = contact;
            txtemail.Text = email;
            txtaddress.Text = address;
            txtposition.Text = position;
            txtcredentials.Text = credentials;
        }

        protected void enterbtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("ChangePassword.aspx");
        }
    }
}