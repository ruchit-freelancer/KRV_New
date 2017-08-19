using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using Telerik.Web.UI;

public partial class Masterpages_Trucks : System.Web.UI.Page
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
            sdsSoftDelete.UpdateParameters["TruckID"].DefaultValue = id;
            sdsSoftDelete.UpdateParameters["UserName"].DefaultValue = user.UserName;
            sdsSoftDelete.Update();
            rgSearch.Rebind();
        }
    }

    protected void RadGrid1_ItemDeleted(object source, GridDeletedEventArgs e)
    {
        String id = e.Item.GetDataKeyValue("TruckID").ToString();
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            DisplayMessage(false, "Truck " + id + " cannot be deleted. Reason: " + e.Exception.Message);
        }
        else
        {
            if (e.AffectedRows > 0)
            {
                DisplayMessage(true, "Truck " + id + " deleted.");
            }
            else
            {
                DisplayMessage(false, "Truck " + id + " cannot be deleted. Reason: It is in active state");
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
                        TextBox txtTruckNo = (TextBox)item.FindControl("txtTruckNo");
                        RadComboBox rcmbLocation = (RadComboBox)item.FindControl("rcmbLocation");
                        TextBox txtTruckTagNo = (TextBox)item.FindControl("txtTruckTagNo");
                        TextBox txtMake = (TextBox)item.FindControl("txtMake");
                        TextBox txtModel = (TextBox)item.FindControl("txtModel");
                        TextBox txtColor = (TextBox)item.FindControl("txtColor");
                        RadDatePicker rdtpDOP = (RadDatePicker)item.FindControl("rdtpDOP");
                        TextBox txtNotes = (TextBox)item.FindControl("txtNotes");
                        RadNumericTextBox txtSlabCapacity = (RadNumericTextBox)item.FindControl("txtSlabCapacity");
                        TextBox txtVINNumber = (TextBox)item.FindControl("txtVINNumber");
                        RadNumericTextBox txtAxles = (RadNumericTextBox)item.FindControl("txtAxles");
                        RadNumericTextBox txtIftaDecal = (RadNumericTextBox)item.FindControl("txtIftaDecal");
                        RadNumericTextBox txtYear = (RadNumericTextBox)item.FindControl("txtYear");
                        RadNumericTextBox txtMTWeight = (RadNumericTextBox)item.FindControl("txtMTWeight");
                        RadNumericTextBox txtLicensedWeight = (RadNumericTextBox)item.FindControl("txtLicensedWeight");
                        RadNumericTextBox txtPMMilage = (RadNumericTextBox)item.FindControl("txtPMMilage");

                        sdsAddEditRecords.InsertParameters["TruckNo"].DefaultValue = txtTruckNo.Text;
                        sdsAddEditRecords.InsertParameters["LocationID"].DefaultValue = rcmbLocation.SelectedValue.ToString();
                        sdsAddEditRecords.InsertParameters["TruckTagNo"].DefaultValue = txtTruckTagNo.Text;
                        sdsAddEditRecords.InsertParameters["Make"].DefaultValue = txtMake.Text;
                        sdsAddEditRecords.InsertParameters["Model"].DefaultValue = txtModel.Text;
                        sdsAddEditRecords.InsertParameters["Color"].DefaultValue = txtColor.Text;
                        sdsAddEditRecords.InsertParameters["Notes"].DefaultValue = txtNotes.Text;
                        sdsAddEditRecords.InsertParameters["VINNumber"].DefaultValue = txtVINNumber.Text;

                        if (rdtpDOP.SelectedDate.HasValue)
                        {
                            sdsAddEditRecords.InsertParameters["DOP"].DefaultValue = rdtpDOP.SelectedDate.Value.ToShortDateString();
                        }
                        else
                        {
                            sdsAddEditRecords.InsertParameters["DOP"].DefaultValue = DBNull.Value.ToString();
                        }
                        if (txtSlabCapacity.Value.HasValue)
                        {
                            sdsAddEditRecords.InsertParameters["SlabCapacity"].DefaultValue = txtSlabCapacity.Value.Value.ToString();
                        }
                        else
                        {
                            sdsAddEditRecords.InsertParameters["SlabCapacity"].DefaultValue = "0";
                        }
                        if (txtAxles.Value.HasValue)
                        {
                            sdsAddEditRecords.InsertParameters["Axles"].DefaultValue = txtAxles.Value.Value.ToString();
                        }
                        
                        if (txtIftaDecal.Value.HasValue)
                        {
                            sdsAddEditRecords.InsertParameters["IftaDecal"].DefaultValue = txtIftaDecal.Value.Value.ToString();
                        }
                        
                        if (txtYear.Value.HasValue)
                        {
                            sdsAddEditRecords.InsertParameters["Year"].DefaultValue = txtYear.Value.Value.ToString();
                        }
                        

                        if (txtMTWeight.Value.HasValue)
                        {
                            sdsAddEditRecords.InsertParameters["MTWeight"].DefaultValue = txtMTWeight.Value.Value.ToString();
                        }
                        

                        if (txtLicensedWeight.Value.HasValue)
                        {
                            sdsAddEditRecords.InsertParameters["LicensedWeight"].DefaultValue = txtLicensedWeight.Value.Value.ToString();
                        }
                        

                        if (txtPMMilage.Value.HasValue)
                        {
                            sdsAddEditRecords.InsertParameters["PMMilage"].DefaultValue = txtPMMilage.Value.Value.ToString();
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
                        string truckID = item.GetDataKeyValue("TruckID").ToString();
                        //Access the textbox from the edit form template
                        TextBox txtTruckNo = (TextBox)item.FindControl("txtTruckNo");
                        RadComboBox rcmbLocation = (RadComboBox)item.FindControl("rcmbLocation");
                        TextBox txtTruckTagNo = (TextBox)item.FindControl("txtTruckTagNo");
                        TextBox txtMake = (TextBox)item.FindControl("txtMake");
                        TextBox txtModel = (TextBox)item.FindControl("txtModel");
                        TextBox txtColor = (TextBox)item.FindControl("txtColor");
                        RadDatePicker rdtpDOP = (RadDatePicker)item.FindControl("rdtpDOP");
                        TextBox txtNotes = (TextBox)item.FindControl("txtNotes");
                        RadNumericTextBox txtSlabCapacity = (RadNumericTextBox)item.FindControl("txtSlabCapacity");
                        TextBox txtVINNumber = (TextBox)item.FindControl("txtVINNumber");
                        RadNumericTextBox txtAxles = (RadNumericTextBox)item.FindControl("txtAxles");
                        RadNumericTextBox txtIftaDecal = (RadNumericTextBox)item.FindControl("txtIftaDecal");
                        RadNumericTextBox txtYear = (RadNumericTextBox)item.FindControl("txtYear");
                        RadNumericTextBox txtMTWeight = (RadNumericTextBox)item.FindControl("txtMTWeight" );
                        RadNumericTextBox txtLicensedWeight = (RadNumericTextBox)item.FindControl("txtLicensedWeight");
                        RadNumericTextBox txtPMMilage = (RadNumericTextBox)item.FindControl("txtPMMilage");

                        sdsAddEditRecords.UpdateParameters["TruckID"].DefaultValue = truckID;
                        sdsAddEditRecords.UpdateParameters["TruckNo"].DefaultValue = txtTruckNo.Text;
                        sdsAddEditRecords.UpdateParameters["LocationID"].DefaultValue = rcmbLocation.SelectedValue.ToString();
                        sdsAddEditRecords.UpdateParameters["TruckTagNo"].DefaultValue = txtTruckTagNo.Text;
                        sdsAddEditRecords.UpdateParameters["Make"].DefaultValue = txtMake.Text;
                        sdsAddEditRecords.UpdateParameters["Model"].DefaultValue = txtModel.Text;
                        sdsAddEditRecords.UpdateParameters["Color"].DefaultValue = txtColor.Text;
                        sdsAddEditRecords.UpdateParameters["Notes"].DefaultValue = txtNotes.Text;
                        sdsAddEditRecords.UpdateParameters["VINNumber"].DefaultValue = txtVINNumber.Text;

                        if (rdtpDOP.SelectedDate.HasValue)
                        {
                            sdsAddEditRecords.UpdateParameters["DOP"].DefaultValue = rdtpDOP.SelectedDate.Value.ToShortDateString();
                        }
                        else
                        {
                            sdsAddEditRecords.UpdateParameters["DOP"].DefaultValue = DBNull.Value.ToString();
                        }
                        if (txtSlabCapacity.Value.HasValue)
                        {
                            sdsAddEditRecords.UpdateParameters["SlabCapacity"].DefaultValue = txtSlabCapacity.Value.Value.ToString();
                        }
                        else
                        {
                            sdsAddEditRecords.UpdateParameters["SlabCapacity"].DefaultValue = "0";
                        }
                        if (txtAxles.Value.HasValue)
                        {
                            sdsAddEditRecords.UpdateParameters["Axles"].DefaultValue = txtAxles.Value.Value.ToString();
                        }
                       
                        if (txtIftaDecal.Value.HasValue)
                        {
                            sdsAddEditRecords.UpdateParameters["IftaDecal"].DefaultValue = txtIftaDecal.Value.Value.ToString();
                        }
                        
                        if (txtYear.Value.HasValue)
                        {
                            sdsAddEditRecords.UpdateParameters["Year"].DefaultValue = txtYear.Value.Value.ToString();
                        }
                       

                        if (txtMTWeight.Value.HasValue)
                        {
                            sdsAddEditRecords.UpdateParameters["MTWeight"].DefaultValue = txtMTWeight.Value.Value.ToString();
                        }
                        

                        if (txtLicensedWeight.Value.HasValue)
                        {
                            sdsAddEditRecords.UpdateParameters["LicensedWeight"].DefaultValue = txtLicensedWeight.Value.Value.ToString();
                        }
                        

                        if (txtPMMilage.Value.HasValue)
                        {
                            sdsAddEditRecords.UpdateParameters["PMMilage"].DefaultValue = txtPMMilage.Value.Value.ToString();
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
