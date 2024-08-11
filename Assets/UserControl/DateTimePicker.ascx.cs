using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ProtoType.Assets.UserControl
{
    public partial class DateTimePicker : System.Web.UI.UserControl
    {
        private static bool _flag;
        public bool sTime { get; set; }
        public bool showLabel { get; set; }

        public string Text
        {
            get { return TextBox1.Text; }
            set { TextBox1.Text = value; }
        }

        public string placeholder
        {
            get { return TextBox1.Attributes["placeholder"]; }
            set { TextBox1.Attributes["placeholder"] = value; }
        }

        public string ucLabelText
        {
            get { return TextBox1.Attributes["ucLabelText"]; }
            set { TextBox1.Attributes["ucLabelText"] = value; }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;
            _flag = true;
            if (!string.IsNullOrEmpty(Attributes["Text"]))
            {
                Text = Attributes["Text"];
                Calendar1.SelectedDate = Convert.ToDateTime(Attributes["Text"]);
            }
            //if (!string.IsNullOrEmpty(Attributes["Validate"])) Validate = Convert.ToBoolean(Attributes["Validate"]);
            //if (!string.IsNullOrEmpty(Attributes["ValidationGroup"])) ValidationGroup = Attributes["ValidationGroup"];
            if (!string.IsNullOrEmpty(Attributes["placeholder"])) TextBox1.Attributes["placeholder"] = Attributes["placeholder"];
            lblUCDate.Visible = showLabel;
            if (!string.IsNullOrEmpty(ucLabelText)) lblUCDate.Text = ucLabelText;

        }

        protected void Button1_Click(object sender, ImageClickEventArgs e)
        {
            Calendar1.Visible = _flag;
            _flag = !_flag;
        }

        protected void Calendar1_SelectionChanged(object sender, EventArgs e)
        {
            TextBox1.Text = Calendar1.SelectedDate.ToString("MM/dd/yyyy", System.Globalization.CultureInfo.InvariantCulture);
            Calendar1.Visible = false;
            _flag = !_flag;
        }

        protected void Calendar1_DayRender(object sender, DayRenderEventArgs e)
        {
            if (e.Day.Date.Equals(DateTime.Today))
            {
                e.Cell.Font.Bold = true;
                e.Cell.BackColor = ColorTranslator.FromHtml("#C8C8C8");
                e.Cell.ForeColor = ColorTranslator.FromHtml("#8B1B4A");
            }
        }
    }
}