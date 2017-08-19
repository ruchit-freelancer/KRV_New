using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using Telerik.Web.UI;

public partial class Masterpages_Locations : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void imgActive_Click(object sender, EventArgs e)
    {
        MembershipUser user = Membership.GetUser();
        if (user != null)
        {
            string id = ((ImageButton)sender).CommandArgument.ToString();
            sdsSoftDelete.UpdateParameters["LocationID"].DefaultValue = id;
            sdsSoftDelete.UpdateParameters["UserName"].DefaultValue = user.UserName;
            sdsSoftDelete.Update();
            rgSearch.Rebind();
        }
    }

    protected void RadGrid1_ItemDeleted(object source, GridDeletedEventArgs e)
    {
        String id = e.Item.GetDataKeyValue("LocationID").ToString();
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            DisplayMessage(false, "Location " + id + " cannot be deleted. Reason: " + e.Exception.Message);
        }
        else
        {
            if (e.AffectedRows > 0)
            {
                DisplayMessage(true, "Location " + id + " deleted.");
            }
            else
            {
                DisplayMessage(false, "Location " + id + " cannot be deleted. Reason: It is in active state");
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
                        TextBox txtLocationName = (TextBox)item.FindControl("txtLocationName");
                        TextBox txtCity = (TextBox)item.FindControl("txtCity");
                        RadComboBox rcmbStateName = (RadComboBox)item.FindControl("rcmbStateName");
                        TextBox txtPhoneNo = (TextBox)item.FindControl("txtPhoneNo");

                        sdsAddEditRecords.InsertParameters["LocationName"].DefaultValue = txtLocationName.Text;
                        sdsAddEditRecords.InsertParameters["City"].DefaultValue = txtCity.Text;
                        sdsAddEditRecords.InsertParameters["StateID"].DefaultValue = rcmbStateName.SelectedValue.ToString();
                        sdsAddEditRecords.InsertParameters["PhoneNo"].DefaultValue = txtPhoneNo.Text;
                        sdsAddEditRecords.InsertParameters["UserName"].DefaultValue = user.UserName;
                        int result = sdsAddEditRecords.Insert();
                        DisplayMessage(true, WebHelper.GetSaveSuccess());
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
                        string LocationID = item.GetDataKeyValue("LocationID").ToString();
                        //Access the textbox from the edit form template
                        TextBox txtLocationName = (TextBox)item.FindControl("txtLocationName");
                        TextBox txtCity = (TextBox)item.FindControl("txtCity");
                        RadComboBox rcmbStateName = (RadComboBox)item.FindControl("rcmbStateName");
                        TextBox txtPhoneNo = (TextBox)item.FindControl("txtPhoneNo");

                        sdsAddEditRecords.UpdateParameters["LocationID"].DefaultValue = LocationID;
                        sdsAddEditRecords.UpdateParameters["LocationName"].DefaultValue = txtLocationName.Text;
                        sdsAddEditRecords.UpdateParameters["City"].DefaultValue = txtCity.Text;
                        sdsAddEditRecords.UpdateParameters["StateID"].DefaultValue = rcmbStateName.SelectedValue.ToString();
                        sdsAddEditRecords.UpdateParameters["PhoneNo"].DefaultValue = txtPhoneNo.Text;
                        sdsAddEditRecords.UpdateParameters["UserName"].DefaultValue = user.UserName;
                        int result = sdsAddEditRecords.Update();
                        DisplayMessage(true, WebHelper.GetUpdateSuccess());
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
}
