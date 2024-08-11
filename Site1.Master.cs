using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ProtoType
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
            lblUser.Text = Session["user"].ToString();
            if (!IsPostBack)
            {
                if (Session["position"] != null)
                {
                    string position = Session["position"].ToString();

                    // Check the user's position and hide the "MANAGE" menu item accordingly
                    if (position == "ENGINEER" || position == "DEPARTMENT HEAD")
                    {
                        var supervisorMenuItem = FindMenuItemByText(NavigationMenu.Items, "SUPERVISOR");
                        if (supervisorMenuItem != null)
                        {
                            var manageMenuItem = FindMenuItemByText(supervisorMenuItem.ChildItems, "MANAGE");
                            if (manageMenuItem != null)
                            {
                                supervisorMenuItem.ChildItems.Remove(manageMenuItem);
                            }

                            var HeadMenuItem = FindMenuItemByText(supervisorMenuItem.ChildItems, "HEAD");
                            if (HeadMenuItem != null)
                            {
                                supervisorMenuItem.ChildItems.Remove(HeadMenuItem);
                            }

                            var ReportMenuItem = FindMenuItemByText(supervisorMenuItem.ChildItems, "REPORT");
                            if (ReportMenuItem != null)
                            {
                                supervisorMenuItem.ChildItems.Remove(ReportMenuItem);
                            }
                        }
                    }
                }
            }
        }
        private MenuItem FindMenuItemByText(MenuItemCollection items, string text)
        {
            foreach (MenuItem item in items)
            {
                if (item.Text.Equals(text, StringComparison.OrdinalIgnoreCase))
                {
                    return item;
                }

                var childItem = FindMenuItemByText(item.ChildItems, text);
                if (childItem != null)
                {
                    return childItem;
                }
            }

            return null;
        }
        protected void logoutlink_ServerClick(object sender, EventArgs e)
        {
            HttpContext.Current.Session["user"] = "";
            HttpContext.Current.Session["position"] = "";
            HttpContext.Current.Session.Clear();
            HttpContext.Current.Session.Abandon();
            Response.Redirect("~/Login.aspx");
        }
    }
}