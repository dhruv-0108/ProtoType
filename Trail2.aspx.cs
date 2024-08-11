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
    public partial class Trail2 : System.Web.UI.Page
    {
       
        SqlConnection con = new SqlConnection(@"Data Source=localhost\SQLEXPRESS01;Initial Catalog=test_one;Integrated Security=True");
        SqlDataAdapter adp = new SqlDataAdapter();
        DataSet ds = new DataSet();
        public string lineData;
        protected void Page_Load(object sender, EventArgs e)
        {
            if(con.State == ConnectionState.Closed || con.State == ConnectionState.Broken)
            {
                con.Open();
                LoadData();
            }
        }

        public void LoadData()
        {
            adp = new SqlDataAdapter("select * from MAIN_DATA", con);
            DataSet dt = new DataSet();
            adp.Fill(dt);
            if (dt.Tables[0].Rows.Count > 0)
            {
                mytrial.DataSource = dt.Tables[0];
                mytrial.DataBind();
            }
           
        }
    }
}