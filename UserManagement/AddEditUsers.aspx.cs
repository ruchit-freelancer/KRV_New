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


public partial class UserManagement_AddEditUsers : Telerik.Web.UI.RadAjaxPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        MembershipUser myObject = Membership.GetUser();
        if (myObject != null)
        {
            if (!Roles.IsUserInRole(myObject.UserName, "Admin"))
            {
                Response.Redirect(WebHelper.ApplicationPath(Request) + "/Default.aspx");
            }
        }
    }

    protected void imgLock_Click(object sender, EventArgs e)
    {
        string id = ((ImageButton)sender).CommandArgument;
        MembershipUser user = Membership.GetUser(id);
        if (user != null)
        {
            bool status = user.IsApproved;
            if (status)
            {
                user.IsApproved = false;
                Membership.UpdateUser(user);
                rgSearch.Rebind();
                DisplayMessage(true, "User " + user.UserName + " get locked");
            }
            else
            {
                user.IsApproved = true;
                Membership.UpdateUser(user);
                rgSearch.Rebind();
                DisplayMessage(true, "User " + user.UserName + " get unlocked");
            }
        }
    }

    protected void imgReset_Click(object sender, EventArgs e)
    {
        string id = ((ImageButton)sender).CommandArgument;
        MembershipUser user = Membership.GetUser(id);
        if (user != null)
        {
            string pass = user.ResetPassword();
            user.ChangePassword(user.GetPassword(), pass);
            string body = "<b>Your password has been changed!!</b><br>";
            body += "<hr><br><b>UserName:</b>" + user.UserName;
            body += "<br><b>Password:</b>" + pass;
            WebHelper.SendEmail(user.Email, user.UserName, "Password Changed", body, 0, "", 0, "", 0, "");
            rgSearch.Rebind();
            DisplayMessage(true, "Password changed successfully!!");
        }
    }

    protected void RadGrid1_InsertCommand(object source, GridCommandEventArgs e)
    {
        MembershipUser user = Membership.GetUser();
        if (user != null)
        {
            try
            {
                if (e.CommandName == "PerformInsert")
                {
                    if (e.Item is GridEditFormItem)
                    {
                        //Get the GridEditableItem of the RadGrid    
                        GridEditFormItem item = (GridEditFormItem)e.Item;

                        //Access the textbox from the edit form template
                        TextBox txtUserName = (TextBox)item.FindControl("txtUserName");
                        TextBox txtPassword = (TextBox)item.FindControl("txtPassword");
                        TextBox txtEmail = (TextBox)item.FindControl("txtEmail");
                        RadComboBox rcbRole = (RadComboBox)item.FindControl("rcbRole");

                        MembershipUser newUser = Membership.CreateUser(txtUserName.Text.Trim(), txtPassword.Text.Trim(), txtEmail.Text.Trim());
                        if (newUser != null)
                        {
                            Roles.AddUserToRole(txtUserName.Text.Trim(), rcbRole.SelectedItem.Text);
                            DisplayMessage(true, WebHelper.GetSaveSuccess());
                            rgSearch.Rebind();
                        }
                        else
                        {
                            DisplayMessage(false, WebHelper.GetSaveFail());
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                DisplayMessage(false, WebHelper.GetSaveFail() + ". Reason: " + ex.Message);
                e.Canceled = true;
            }
        }
    }

    protected void RadGrid1_UpdateCommand(object source, GridCommandEventArgs e)
    {
        MembershipUser user = Membership.GetUser();
        if (user != null)
        {
            try
            {
                if (e.CommandName == RadGrid.UpdateCommandName)
                {
                    if (e.Item is GridEditFormItem)
                    {
                        //Get the GridEditableItem of the RadGrid    
                        GridEditFormItem item = (GridEditFormItem)e.Item;

                        //Get the primary key value using the DataKeyValue.    
                        string userID = item.GetDataKeyValue("UserID").ToString();
                        //Access the textbox from the edit form template
                        TextBox txtUserName = (TextBox)item.FindControl("txtUserName");
                        RadComboBox rcbRole = (RadComboBox)item.FindControl("rcbRole");
                        HiddenField hfRoleName = (HiddenField)item.FindControl("hfRoleName");
                        TextBox txtEmail = (TextBox)item.FindControl("txtEmail");

                        MembershipUser cuser = Membership.GetUser(txtUserName.Text.Trim());
                        if (cuser != null)
                        {
                            MembershipUserCollection uc1 = Membership.FindUsersByEmail(txtEmail.Text.Trim());
                            string euser = "";
                            foreach (MembershipUser u in uc1)
                            {
                                euser = u.UserName;
                            }
                            if (uc1.Count >= 0 && euser == cuser.UserName)
                            {
                                if (!Roles.IsUserInRole(cuser.UserName, rcbRole.SelectedItem.Text))
                                {
                                    Roles.RemoveUserFromRole(cuser.UserName, hfRoleName.Value.ToString());
                                    Roles.AddUserToRole(txtUserName.Text.Trim(), rcbRole.SelectedItem.Text);
                                }
                                if (cuser.Email != txtEmail.Text.Trim())
                                {
                                    MembershipUserCollection uc = Membership.FindUsersByEmail(txtEmail.Text.Trim());
                                    if (uc.Count <= 0)
                                    {
                                        cuser.Email = txtEmail.Text.Trim();
                                        Membership.UpdateUser(cuser);
                                    }
                                }
                                Response.Redirect(Request.RawUrl);
                            }
                            else
                            {
                                DisplayMessage(false, "Email ID already in used");
                            }
                        }
                        else
                        {
                            DisplayMessage(false, WebHelper.GetUpdateFail());
                        }
                    }
                }

            }
            catch (Exception ex)
            {
                DisplayMessage(false, WebHelper.GetUpdateFail() + ". Reason: " + ex.Message);
                e.Canceled = true;
            }
        }
    }

    void DisplayMessage(bool status, String message)
    {
        if (status)
        {
            rgSearch.Controls.Add(new LiteralControl(string.Format("<span style='color:Green'>{0}</span>", message)));
        }
        else
        {
            rgSearch.Controls.Add(new LiteralControl(string.Format("<span style='color:red'>{0}</span>", message)));
        }
    }

    protected void RadGrid1_ItemDataBound(object sender, GridItemEventArgs e)
    {
        try
        {
            if (e.Item is GridEditFormInsertItem)
            {
                GridEditFormInsertItem insertForm = (GridEditFormInsertItem)e.Item;
                RadComboBox rcbRoles = (RadComboBox)insertForm.FindControl("rcbRoles");
                rcbRoles.Items.FindItemByText("Employee").Selected = true;
            }
            else if (e.Item is GridEditFormItem && e.Item.IsInEditMode)
            {
                GridEditFormItem editForm = (GridEditFormItem)e.Item;
                TextBox txtUserName = (TextBox)editForm.FindControl("txtUserName");
                Panel pnlUsers = (Panel)editForm.FindControl("pnlUsers");
                pnlUsers.Visible = false;
                txtUserName.Enabled = false;
            }
        }
        catch (Exception) { }
    }
}
