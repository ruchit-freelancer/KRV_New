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
using System.Drawing;

public partial class UctMessageDetails : System.Web.UI.UserControl
{    
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    public void SetMessage(bool isSuccess, string message)
    {
        if (isSuccess == false)
        {
            lblMessage.CssClass = "FailerMessage";
            lblMessage.Text = message;
        }
        else
        {
            lblMessage.CssClass = "SuccessMessage";
            lblMessage.Text = message;
        }
    }
}
