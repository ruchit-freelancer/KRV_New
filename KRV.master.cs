using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Configuration;

public partial class KRV : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        MembershipUser user = Membership.GetUser();
        if (user == null)
        {
            SignOut();
        }
        //lblCompanyName.Text = ConfigurationManager.AppSettings["CompanyName"].ToString();
    }

    protected void LoginStatus1_LoggingOut(object sender, LoginCancelEventArgs e)
    {
        SignOut();
    }

    void SignOut()
    {
        FormsAuthentication.SignOut();
        Session.Clear();
        Session.Abandon();
        Response.Clear();
        Response.Redirect(FormsAuthentication.LoginUrl);
    }
}
