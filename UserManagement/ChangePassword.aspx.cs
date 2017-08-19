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


public partial class UserManagement_ChangePassword : Telerik.Web.UI.RadAjaxPage
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void ChangePasswordPushButton_Click(object sender, EventArgs e)
    {
        MembershipUser loggedUser = Membership.GetUser();
        if (loggedUser != null)
        {
            if (loggedUser.ChangePassword(CurrentPassword.Text, NewPassword.Text))
            {
                uctMessage.SetMessage(true, "Password changed Successfully");
                uctMessage.Visible = true;
            }
            else
            {
                uctMessage.SetMessage(false, "Invalid Password");
                uctMessage.Visible = true;
            }
        }
    }
}
