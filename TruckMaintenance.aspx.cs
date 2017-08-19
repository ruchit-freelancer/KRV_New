using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using Telerik.Web.UI;

public partial class TruckMaintenance : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void RadGrid1_ItemDataBound(object sender, GridItemEventArgs e)
    {
        try
        {
            if (e.Item is GridEditFormInsertItem)
            {
                GridEditFormInsertItem insertForm = (GridEditFormInsertItem)e.Item;
                //insertForm.Attributes.Add("onClick", "return confirm('Are you sure you want to Delete ?');");
                RadDatePicker rdtpMaintenanceDate = (RadDatePicker)insertForm.FindControl("rdtpMaintenanceDate");
                rdtpMaintenanceDate.SelectedDate = DateTime.Now;
            }
        }
        catch (Exception) { }
    }

    protected void imgActive_Click(object sender, EventArgs e)
    {
        MembershipUser user = Membership.GetUser();
        if (user != null)
        {
            string id = ((ImageButton)sender).CommandArgument.ToString();
            sdsSoftDelete.UpdateParameters["MaintenanceID"].DefaultValue = id;
            sdsSoftDelete.UpdateParameters["UserName"].DefaultValue = user.UserName;
            sdsSoftDelete.Update();
            rgSearch.Rebind();
        }
    }

    protected void RadGrid1_ItemDeleted(object source, GridDeletedEventArgs e)
    {
        String id = e.Item.GetDataKeyValue("MaintenanceID").ToString();
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            DisplayMessage(false, "Maintenance " + id + " cannot be deleted. Reason: " + e.Exception.Message);
        }
        else
        {
            if (e.AffectedRows > 0)
            {
                DisplayMessage(true, "Maintenance " + id + " deleted.");
            }
            else
            {
                DisplayMessage(false, "Maintenance " + id + " cannot be deleted. Reason: It is in active state");
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
                        RadComboBox rcmbTrucks = (RadComboBox)item.FindControl("rcmbTrucks");
                        RadComboBox rcmbMaintenanceTypes = (RadComboBox)item.FindControl("rcmbMaintenanceTypes");
                        RadDatePicker rdtpMaintenanceDate = (RadDatePicker)item.FindControl("rdtpMaintenanceDate");
                        TextBox txtVendorName = (TextBox)item.FindControl("txtVendorName");
                        TextBox txtNotes = (TextBox)item.FindControl("txtNotes");
                        RadNumericTextBox txtTotalCost = (RadNumericTextBox)item.FindControl("txtTotalCost");
                        RadNumericTextBox txtOutOfService = (RadNumericTextBox)item.FindControl("txtOutOfService");
                        RadNumericTextBox txtOdometer = (RadNumericTextBox)item.FindControl("txtOdometer");

                        sdsAddEditRecords.InsertParameters["TruckID"].DefaultValue = rcmbTrucks.SelectedValue.ToString();
                        sdsAddEditRecords.InsertParameters["MaintenanceTypeID"].DefaultValue = rcmbMaintenanceTypes.SelectedValue.ToString();
                        if (rdtpMaintenanceDate.SelectedDate.HasValue)
                        {
                            sdsAddEditRecords.InsertParameters["MaintenanceDate"].DefaultValue = rdtpMaintenanceDate.SelectedDate.Value.ToShortDateString();
                        }
                        else
                        {
                            sdsAddEditRecords.InsertParameters["MaintenanceDate"].DefaultValue = DBNull.Value.ToString();
                        }
                        sdsAddEditRecords.InsertParameters["VendorName"].DefaultValue = txtVendorName.Text;
                        sdsAddEditRecords.InsertParameters["Notes"].DefaultValue = txtNotes.Text;
                        if (txtTotalCost.Value.HasValue)
                        {
                            sdsAddEditRecords.InsertParameters["TotalCost"].DefaultValue = txtTotalCost.Value.Value.ToString();
                        }
                        else
                        {
                            sdsAddEditRecords.InsertParameters["TotalCost"].DefaultValue = "0";
                        }
                        if (txtOdometer.Value.HasValue)
                        {
                            sdsAddEditRecords.InsertParameters["Odometer"].DefaultValue = txtOdometer.Value.Value.ToString();
                        }
                        
                        if (txtOutOfService.Value.HasValue)
                        {
                            sdsAddEditRecords.InsertParameters["OutOfService"].DefaultValue = txtOutOfService.Value.Value.ToString();
                        }
                        else
                        {
                            sdsAddEditRecords.InsertParameters["OutOfService"].DefaultValue = "0";
                        }
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
                        string maintenanceID = item.GetDataKeyValue("MaintenanceID").ToString();
                        //Access the textbox from the edit form template
                        RadComboBox rcmbTrucks = (RadComboBox)item.FindControl("rcmbTrucks");
                        RadComboBox rcmbMaintenanceTypes = (RadComboBox)item.FindControl("rcmbMaintenanceTypes");
                        RadDatePicker rdtpMaintenanceDate = (RadDatePicker)item.FindControl("rdtpMaintenanceDate");
                        TextBox txtVendorName = (TextBox)item.FindControl("txtVendorName");
                        TextBox txtNotes = (TextBox)item.FindControl("txtNotes");
                        RadNumericTextBox txtTotalCost = (RadNumericTextBox)item.FindControl("txtTotalCost");
                        RadNumericTextBox txtOutOfService = (RadNumericTextBox)item.FindControl("txtOutOfService");
                        RadNumericTextBox txtOdometer = (RadNumericTextBox)item.FindControl("txtOdometer");

                        sdsAddEditRecords.UpdateParameters["MaintenanceID"].DefaultValue = maintenanceID;
                        sdsAddEditRecords.UpdateParameters["TruckID"].DefaultValue = rcmbTrucks.SelectedValue.ToString();
                        sdsAddEditRecords.UpdateParameters["MaintenanceTypeID"].DefaultValue = rcmbMaintenanceTypes.SelectedValue.ToString();
                        if (rdtpMaintenanceDate.SelectedDate.HasValue)
                        {
                            sdsAddEditRecords.UpdateParameters["MaintenanceDate"].DefaultValue = rdtpMaintenanceDate.SelectedDate.Value.ToShortDateString();
                        }
                        else
                        {
                            sdsAddEditRecords.UpdateParameters["MaintenanceDate"].DefaultValue = DBNull.Value.ToString();
                        }
                        sdsAddEditRecords.UpdateParameters["VendorName"].DefaultValue = txtVendorName.Text;
                        if (txtTotalCost.Value.HasValue)
                        {
                            sdsAddEditRecords.UpdateParameters["TotalCost"].DefaultValue = txtTotalCost.Value.Value.ToString();
                        }
                        else
                        {
                            sdsAddEditRecords.UpdateParameters["TotalCost"].DefaultValue = "0";
                        }
                        if (txtOdometer.Value.HasValue)
                        {
                            sdsAddEditRecords.UpdateParameters["Odometer"].DefaultValue = txtOdometer.Value.Value.ToString();
                        }
                        if (txtOutOfService.Value.HasValue)
                        {
                            sdsAddEditRecords.UpdateParameters["OutOfService"].DefaultValue = txtOutOfService.Value.Value.ToString();
                        }
                        else
                        {
                            sdsAddEditRecords.UpdateParameters["OutOfService"].DefaultValue = "0";
                        }
                        sdsAddEditRecords.UpdateParameters["UserName"].DefaultValue = user.UserName;
                        sdsAddEditRecords.UpdateParameters["Notes"].DefaultValue = txtNotes.Text;
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
