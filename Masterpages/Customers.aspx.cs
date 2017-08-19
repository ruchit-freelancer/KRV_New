using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using Telerik.Web.UI;

public partial class Masterpages_Customers : System.Web.UI.Page
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
            sdsSoftDelete.UpdateParameters["CustomerID"].DefaultValue = id;
            sdsSoftDelete.UpdateParameters["UserName"].DefaultValue = user.UserName;
            sdsSoftDelete.Update();
            rgSearch.Rebind();
        }
    }

    protected void RadGrid1_ItemDeleted(object source, GridDeletedEventArgs e)
    {
        String id = e.Item.GetDataKeyValue("CustomerID").ToString();
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            DisplayMessage(false, "Customer " + id + " cannot be deleted. Reason: " + e.Exception.Message);
        }
        else
        {
            if (e.AffectedRows > 0)
            {
                DisplayMessage(true, "Customer " + id + " deleted.");
            }
            else
            {
                DisplayMessage(false, "Customer " + id + " cannot be deleted. Reason: It is in active state");
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
                        TextBox txtCustomerName = (TextBox)item.FindControl("txtCustomerName");
                        TextBox txtCustomerCode = (TextBox)item.FindControl("txtCustomerCode");
                        TextBox txtCity = (TextBox)item.FindControl("txtCity");
                        RadComboBox rcmbStateName = (RadComboBox)item.FindControl("rcmbStateName");
                        RadComboBox rcmbLocations = (RadComboBox)item.FindControl("rcmbLocations");
                        TextBox txtPhoneNo = (TextBox)item.FindControl("txtPhoneNo");
                        TextBox txtContactPerson = (TextBox)item.FindControl("txtContactPerson");
                        TextBox txtEmail = (TextBox)item.FindControl("txtEmail");

                        sdsAddEditRecords.InsertParameters["CustomerName"].DefaultValue = txtCustomerName.Text;
                        sdsAddEditRecords.InsertParameters["CustomerCode"].DefaultValue = txtCustomerCode.Text;
                        sdsAddEditRecords.InsertParameters["City"].DefaultValue = txtCity.Text;
                        sdsAddEditRecords.InsertParameters["StateID"].DefaultValue = rcmbStateName.SelectedValue.ToString();
                        sdsAddEditRecords.InsertParameters["LocationID"].DefaultValue = rcmbLocations.SelectedValue.ToString();
                        sdsAddEditRecords.InsertParameters["PhoneNo"].DefaultValue = txtPhoneNo.Text;
                        sdsAddEditRecords.InsertParameters["ContactPerson"].DefaultValue = txtContactPerson.Text;
                        sdsAddEditRecords.InsertParameters["Email"].DefaultValue = txtEmail.Text;
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
                        string CustomerID = item.GetDataKeyValue("CustomerID").ToString();
                        //Access the textbox from the edit form template
                        TextBox txtCustomerName = (TextBox)item.FindControl("txtCustomerName");
                        TextBox txtCustomerCode = (TextBox)item.FindControl("txtCustomerCode");
                        TextBox txtCity = (TextBox)item.FindControl("txtCity");
                        RadComboBox rcmbStateName = (RadComboBox)item.FindControl("rcmbStateName");
                        TextBox txtPhoneNo = (TextBox)item.FindControl("txtPhoneNo");
                        TextBox txtContactPerson = (TextBox)item.FindControl("txtContactPerson");
                        TextBox txtEmail = (TextBox)item.FindControl("txtEmail");
                        RadComboBox rcmbLocations = (RadComboBox)item.FindControl("rcmbLocations");

                        sdsAddEditRecords.UpdateParameters["CustomerID"].DefaultValue = CustomerID;
                        sdsAddEditRecords.UpdateParameters["CustomerName"].DefaultValue = txtCustomerName.Text;
                        sdsAddEditRecords.UpdateParameters["CustomerCode"].DefaultValue = txtCustomerCode.Text;
                        sdsAddEditRecords.UpdateParameters["City"].DefaultValue = txtCity.Text;
                        sdsAddEditRecords.UpdateParameters["StateID"].DefaultValue = rcmbStateName.SelectedValue.ToString();
                        sdsAddEditRecords.UpdateParameters["PhoneNo"].DefaultValue = txtPhoneNo.Text;
                        sdsAddEditRecords.UpdateParameters["ContactPerson"].DefaultValue = txtContactPerson.Text;
                        sdsAddEditRecords.UpdateParameters["Email"].DefaultValue = txtEmail.Text;
                        sdsAddEditRecords.UpdateParameters["UserName"].DefaultValue = user.UserName;
                        sdsAddEditRecords.UpdateParameters["LocationID"].DefaultValue = rcmbLocations.SelectedValue.ToString();
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