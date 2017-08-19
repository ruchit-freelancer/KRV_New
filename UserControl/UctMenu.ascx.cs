using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using Telerik.Web.UI;

public partial class UserControls_UctMenu : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            MembershipUser user = Membership.GetUser();
            if (user != null)
            {
                sdsMenu.SelectParameters["UserName"].DefaultValue = user.UserName;
            }
        }
    }

    protected void RadMenu1_ItemDataBound(object sender, RadMenuEventArgs e)
    {
        DataRowView row = (DataRowView)e.Item.DataItem;
        e.Item.NavigateUrl = WebHelper.ApplicationPath(Request) + "/" + row["Link"].ToString();
    }

    protected void RadMenu1_ItemClick(object sender, RadMenuEventArgs e)
    {
        e.Item.HighlightPath();
    }
}
