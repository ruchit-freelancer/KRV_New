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

public partial class UserControls_UctLogin : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        MembershipUser myObject = Membership.GetUser();
        if (myObject != null)
        {
            Response.Redirect(WebHelper.ApplicationPath(Request) + "/Default.aspx");
        }
    }

    protected void imgKey_OnInit(object sender, EventArgs e)
    {
        ((Image)sender).ImageUrl = WebHelper.ApplicationPath(Request) + WebHelper.GetThemeImage(Page, "key.jpg");
    }

    protected void Login1_Authenticate(object sender, AuthenticateEventArgs e)
    {
        string userName = Login1.UserName.ToString();
        string password = Login1.Password.ToString();
        string aspnetUserID = null;

        MembershipUser myObject = Membership.GetUser(userName);
        if (myObject != null)
        {
            aspnetUserID = "{" + myObject.ProviderUserKey.ToString() + "}";

            if (Membership.ValidateUser(userName, password))
            {
                Session["user"] = userName;
                e.Authenticated = true;
                FormsAuthentication.SetAuthCookie(Login1.UserName, true);

                if (Request.QueryString["ReturnUrl"] == null)
                {
                    Response.Redirect(WebHelper.ApplicationPath(Request) + "/Default.aspx");
                }
                else
                {
                    Response.Redirect(Request.QueryString["ReturnUrl"].ToString());
                }
            }
            else
            {
                MembershipUser mUser = Membership.GetUser(Login1.UserName);
                if (mUser != null)
                {
                    if (mUser.IsLockedOut)
                    {
                        // send mail to admin for locked user
                    }
                }

                e.Authenticated = false;
                Login1.FailureText = "<font color='RED'>" + ConfigurationManager.AppSettings["LoginFailure"].ToString() + "</font>";
            }
        }

    }

    protected void Login1_OnLoggedIn(object sender, EventArgs e)
    {
        MembershipUser mUser = Membership.GetUser(true);        
    }
}
