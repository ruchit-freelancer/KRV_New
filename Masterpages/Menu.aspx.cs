using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using Telerik.Web.UI;

public partial class Masterpages_Menu : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    public void MoveUp(object sender, CommandEventArgs e)
    {
        sdsParent.UpdateParameters["ID"].DefaultValue = e.CommandArgument.ToString();
        sdsParent.UpdateParameters["UP"].DefaultValue = "1";
        sdsParent.Update();
        rgMenu.Rebind();
    }

    public void MoveDown(object sender, CommandEventArgs e)
    {
        sdsParent.UpdateParameters["ID"].DefaultValue = e.CommandArgument.ToString();
        sdsParent.UpdateParameters["UP"].DefaultValue = "-1";
        sdsParent.Update();
        rgMenu.Rebind();
    }

    protected void imgActive_Click(object sender, EventArgs e)
    {
        MembershipUser user = Membership.GetUser();
        if (user != null)
        {
            string id = ((ImageButton)sender).CommandArgument.ToString();
            sdsSoftDelete.UpdateParameters["MenuID"].DefaultValue = id;
            sdsSoftDelete.UpdateParameters["UserName"].DefaultValue = user.UserName;
            sdsSoftDelete.Update();
            rgMenu.Rebind();
        }
    }

    protected void RadGrid1_ItemDeleted(object source, GridDeletedEventArgs e)
    {
        String id = e.Item.GetDataKeyValue("MenuID").ToString();
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            DisplayMessage(false, "Menu " + id + " cannot be deleted. Reason: " + e.Exception.Message);
        }
        else
        {
            if (e.AffectedRows > 0)
            {
                DisplayMessage(true, "Menu " + id + " deleted.");
            }
            else
            {
                DisplayMessage(false, "Menu " + id + " cannot be deleted. Reason: It is in active state");
            }
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
                        TextBox txtTitle = (TextBox)item.FindControl("txtTitle");
                        RadComboBox rcmbRoles = (RadComboBox)item.FindControl("rcmbRoles");
                        TextBox txtLink = (TextBox)item.FindControl("txtLink");
                        RadTreeView rtrvParent = (RadTreeView)item.FindControl("rtrvParent");

                        string selectedNode = "NULL";
                        if (rtrvParent.SelectedNode != null)
                        {
                            selectedNode = rtrvParent.SelectedNode.Value.ToString();
                        }

                        sdsAddEditRecords.InsertParameters["Title"].DefaultValue = txtTitle.Text;
                        sdsAddEditRecords.InsertParameters["Link"].DefaultValue = txtLink.Text;
                        sdsAddEditRecords.InsertParameters["ParentID"].DefaultValue = selectedNode;
                        sdsAddEditRecords.InsertParameters["RoleID"].DefaultValue = rcmbRoles.SelectedValue.ToString();
                        sdsAddEditRecords.InsertParameters["UserName"].DefaultValue = user.UserName;
                        int result = sdsAddEditRecords.Insert();
                        DisplayMessage(true, WebHelper.GetSaveSuccess());
                        Response.Redirect(Request.RawUrl);
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
                        string menuID = item.GetDataKeyValue("MenuID").ToString();
                        //Access the textbox from the edit form template
                        TextBox txtTitle = (TextBox)item.FindControl("txtTitle");
                        RadComboBox rcmbRoles = (RadComboBox)item.FindControl("rcmbRoles");
                        TextBox txtLink = (TextBox)item.FindControl("txtLink");
                        RadTreeView rtrvParent = (RadTreeView)item.FindControl("rtrvParent");

                        string selectedNode = "0";
                        if (rtrvParent.SelectedNode != null)
                        {
                            selectedNode = rtrvParent.SelectedNode.Value.ToString();
                        }

                        sdsAddEditRecords.UpdateParameters["MenuID"].DefaultValue = menuID;
                        sdsAddEditRecords.UpdateParameters["Title"].DefaultValue = txtTitle.Text;
                        sdsAddEditRecords.UpdateParameters["Link"].DefaultValue = txtLink.Text;
                        sdsAddEditRecords.UpdateParameters["ParentID"].DefaultValue = selectedNode;
                        sdsAddEditRecords.UpdateParameters["RoleID"].DefaultValue = rcmbRoles.SelectedValue.ToString();
                        sdsAddEditRecords.UpdateParameters["UserName"].DefaultValue = user.UserName;
                        int result = sdsAddEditRecords.Update();
                        DisplayMessage(true, WebHelper.GetUpdateSuccess());
                        Response.Redirect(Request.RawUrl);
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
            rgMenu.Controls.Add(new LiteralControl(string.Format("<span style='color:Green'>{0}</span>", message)));
        }
        else
        {
            rgMenu.Controls.Add(new LiteralControl(string.Format("<span style='color:red'>{0}</span>", message)));
        }
    }

    protected void RadGrid1_ItemDataBound(object sender, GridItemEventArgs e)
    {
        try
        {
            if (e.Item is GridEditFormInsertItem)
            {
                GridEditFormInsertItem insertForm = (GridEditFormInsertItem)e.Item;
                RadTreeView rtrvParent = (RadTreeView)insertForm.FindControl("rtrvParent");
                //RadComboBox rcmbRoles = (RadComboBox)insertForm.FindControl("rcmbRoles");
                //rcmbRoles.Items.FindItemByText("Employee").Selected = true;
                rtrvParent.Nodes[0].Selected = true;
            }
            else if (e.Item is GridEditFormItem && e.Item.IsInEditMode)
            {
                GridEditFormItem editForm = (GridEditFormItem)e.Item;
                RadTreeView rtrvParent = (RadTreeView)editForm.FindControl("rtrvParent");
                HiddenField hfMenuID = (HiddenField)editForm.FindControl("hfMenuID");

                rtrvParent.FindNodeByValue(hfMenuID.Value).ParentNode.Selected = true;
                rtrvParent.FindNodeByValue(hfMenuID.Value).Enabled = false;
            }
        }
        catch (Exception) { }
    }
}
