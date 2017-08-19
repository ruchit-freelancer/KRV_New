using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using Telerik.Web.UI;

public partial class FuelHistory : System.Web.UI.Page
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
                RadDatePicker rdtpFuelingDate = (RadDatePicker)insertForm.FindControl("rdtpFuelingDate");
                rdtpFuelingDate.SelectedDate = DateTime.Now;
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
            sdsSoftDelete.UpdateParameters["FuelID"].DefaultValue = id;
            sdsSoftDelete.UpdateParameters["UserName"].DefaultValue = user.UserName;
            sdsSoftDelete.Update();
            rgSearch.Rebind();
        }
    }

    protected void RadGrid1_ItemDeleted(object source, GridDeletedEventArgs e)
    {
        String id = e.Item.GetDataKeyValue("FuelID").ToString();
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            DisplayMessage(false, "Fuel " + id + " cannot be deleted. Reason: " + e.Exception.Message);
        }
        else
        {
            if (e.AffectedRows > 0)
            {
                DisplayMessage(true, "Fuel " + id + " deleted.");
            }
            else
            {
                DisplayMessage(false, "Fuel " + id + " cannot be deleted. Reason: It is in active state");
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
                        RadComboBox rcmbDriver = (RadComboBox)item.FindControl("rcmbDriver");
                        RadDatePicker rdtpFuelingDate = (RadDatePicker)item.FindControl("rdtpFuelingDate");
                        TextBox txtVendorName = (TextBox)item.FindControl("txtVendorName");
                        RadComboBox rcmbStateName = (RadComboBox)item.FindControl("rcmbStateName");
                        RadNumericTextBox txtUnitPrice = (RadNumericTextBox)item.FindControl("txtUnitPrice");
                        RadNumericTextBox txtTotalCost = (RadNumericTextBox)item.FindControl("txtTotalCost");
                        RadNumericTextBox txtGallons = (RadNumericTextBox)item.FindControl("txtGallons");
                        RadNumericTextBox txtDEFUnitPrice = (RadNumericTextBox)item.FindControl("txtDEFUnitPrice");
                        RadNumericTextBox txtDEFGallons = (RadNumericTextBox)item.FindControl("txtDEFGallons");
                        RadNumericTextBox txtDEFTotalCost = (RadNumericTextBox)item.FindControl("txtDEFTotalCost");

                        sdsAddEditRecords.InsertParameters["TruckID"].DefaultValue = rcmbTrucks.SelectedValue.ToString();
                        sdsAddEditRecords.InsertParameters["DriverID"].DefaultValue = rcmbDriver.SelectedValue.ToString();
                        if (rdtpFuelingDate.SelectedDate.HasValue)
                        {
                            sdsAddEditRecords.InsertParameters["FuelingDate"].DefaultValue = rdtpFuelingDate.SelectedDate.Value.ToShortDateString();
                        }
                        else
                        {
                            sdsAddEditRecords.InsertParameters["FuelingDate"].DefaultValue = DBNull.Value.ToString();
                        }
                        sdsAddEditRecords.InsertParameters["FuelVendor"].DefaultValue = txtVendorName.Text;
                        sdsAddEditRecords.InsertParameters["StateID"].DefaultValue = rcmbStateName.SelectedValue.ToString();

                        if (txtUnitPrice.Value.HasValue)
                        {
                            sdsAddEditRecords.InsertParameters["UnitPrice"].DefaultValue = txtUnitPrice.Value.Value.ToString();
                        }
                        else
                        {
                            sdsAddEditRecords.InsertParameters["UnitPrice"].DefaultValue = "0";
                        }

                        if (txtGallons.Value.HasValue)
                        {
                            sdsAddEditRecords.InsertParameters["Gallons"].DefaultValue = txtGallons.Value.Value.ToString();
                        }
                        else
                        {
                            sdsAddEditRecords.InsertParameters["Gallons"].DefaultValue = "0";
                        }

                        if (txtTotalCost.Value.HasValue)
                        {
                            sdsAddEditRecords.InsertParameters["TotalCost"].DefaultValue = txtTotalCost.Value.Value.ToString();
                        }
                        else
                        {
                            sdsAddEditRecords.InsertParameters["TotalCost"].DefaultValue = "0";
                        }

                        if (txtDEFUnitPrice.Value.HasValue)
                        {
                            sdsAddEditRecords.InsertParameters["DEFUnitPrice"].DefaultValue = txtDEFUnitPrice.Value.Value.ToString();
                        }
                        else
                        {
                            sdsAddEditRecords.InsertParameters["DEFUnitPrice"].DefaultValue = "0";
                        }

                        if (txtDEFGallons.Value.HasValue)
                        {
                            sdsAddEditRecords.InsertParameters["DEFGallons"].DefaultValue = txtDEFGallons.Value.Value.ToString();
                        }
                        else
                        {
                            sdsAddEditRecords.InsertParameters["DEFGallons"].DefaultValue = "0";
                        }

                        if (txtDEFTotalCost.Value.HasValue)
                        {
                            sdsAddEditRecords.InsertParameters["TotalDEF"].DefaultValue = txtDEFTotalCost.Value.Value.ToString();
                        }
                        else
                        {
                            sdsAddEditRecords.InsertParameters["TotalDEF"].DefaultValue = "0";
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
                        string fuelID = item.GetDataKeyValue("FuelID").ToString();
                        //Access the textbox from the edit form template
                        RadComboBox rcmbTrucks = (RadComboBox)item.FindControl("rcmbTrucks");
                        RadComboBox rcmbDriver = (RadComboBox)item.FindControl("rcmbDriver");
                        RadDatePicker rdtpFuelingDate = (RadDatePicker)item.FindControl("rdtpFuelingDate");
                        TextBox txtVendorName = (TextBox)item.FindControl("txtVendorName");
                        RadComboBox rcmbStateName = (RadComboBox)item.FindControl("rcmbStateName");
                        RadNumericTextBox txtUnitPrice = (RadNumericTextBox)item.FindControl("txtUnitPrice");
                        RadNumericTextBox txtTotalCost = (RadNumericTextBox)item.FindControl("txtTotalCost");
                        RadNumericTextBox txtGallons = (RadNumericTextBox)item.FindControl("txtGallons");
                        RadNumericTextBox txtDEFUnitPrice = (RadNumericTextBox)item.FindControl("txtDEFUnitPrice");
                        RadNumericTextBox txtDEFGallons = (RadNumericTextBox)item.FindControl("txtDEFGallons");
                        RadNumericTextBox txtDEFTotalCost = (RadNumericTextBox)item.FindControl("txtDEFTotalCost");

                        sdsAddEditRecords.UpdateParameters["FuelID"].DefaultValue = fuelID;
                        sdsAddEditRecords.UpdateParameters["TruckID"].DefaultValue = rcmbTrucks.SelectedValue.ToString();
                        sdsAddEditRecords.UpdateParameters["DriverID"].DefaultValue = rcmbDriver.SelectedValue.ToString();
                        if (rdtpFuelingDate.SelectedDate.HasValue)
                        {
                            sdsAddEditRecords.UpdateParameters["FuelingDate"].DefaultValue = rdtpFuelingDate.SelectedDate.Value.ToShortDateString();
                        }
                        else
                        {
                            sdsAddEditRecords.UpdateParameters["FuelingDate"].DefaultValue = DBNull.Value.ToString();
                        }
                        sdsAddEditRecords.UpdateParameters["FuelVendor"].DefaultValue = txtVendorName.Text;
                        sdsAddEditRecords.UpdateParameters["StateID"].DefaultValue = rcmbStateName.SelectedValue.ToString();

                        if (txtUnitPrice.Value.HasValue)
                        {
                            sdsAddEditRecords.UpdateParameters["UnitPrice"].DefaultValue = txtUnitPrice.Value.Value.ToString();
                        }
                        else
                        {
                            sdsAddEditRecords.UpdateParameters["UnitPrice"].DefaultValue = "0";
                        }

                        if (txtGallons.Value.HasValue)
                        {
                            sdsAddEditRecords.UpdateParameters["Gallons"].DefaultValue = txtGallons.Value.Value.ToString();
                        }
                        else
                        {
                            sdsAddEditRecords.UpdateParameters["Gallons"].DefaultValue = "0";
                        }

                        if (txtTotalCost.Value.HasValue)
                        {
                            sdsAddEditRecords.UpdateParameters["TotalCost"].DefaultValue = txtTotalCost.Value.Value.ToString();
                        }
                        else
                        {
                            sdsAddEditRecords.UpdateParameters["TotalCost"].DefaultValue = "0";
                        }

                        if (txtDEFUnitPrice.Value.HasValue)
                        {
                            sdsAddEditRecords.UpdateParameters["DEFUnitPrice"].DefaultValue = txtDEFUnitPrice.Value.Value.ToString();
                        }
                        else
                        {
                            sdsAddEditRecords.UpdateParameters["DEFUnitPrice"].DefaultValue = "0";
                        }

                        if (txtDEFGallons.Value.HasValue)
                        {
                            sdsAddEditRecords.UpdateParameters["DEFGallons"].DefaultValue = txtDEFGallons.Value.Value.ToString();
                        }
                        else
                        {
                            sdsAddEditRecords.UpdateParameters["DEFGallons"].DefaultValue = "0";
                        }

                        if (txtDEFTotalCost.Value.HasValue)
                        {
                            sdsAddEditRecords.UpdateParameters["TotalDEF"].DefaultValue = txtDEFTotalCost.Value.Value.ToString();
                        }
                        else
                        {
                            sdsAddEditRecords.UpdateParameters["TotalDEF"].DefaultValue = "0";
                        }
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
