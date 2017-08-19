using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using Telerik.Web.UI;

public partial class Masterpages_Drivers : System.Web.UI.Page
{
    const int MaxTotalBytes = 1048576; // 1 MB
    int totalBytes;
    byte[] fileData = null;

    public bool? IsRadAsyncValid
    {
        get
        {
            if (Session["IsRadAsyncValid"] == null)
            {
                Session["IsRadAsyncValid"] = true;
            }

            return Convert.ToBoolean(Session["IsRadAsyncValid"].ToString());
        }
        set
        {
            Session["IsRadAsyncValid"] = value;
        }
    }

    protected override void OnLoad(EventArgs e)
    {
        base.OnLoad(e);

        IsRadAsyncValid = null;
    }

    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void imgActive_Click(object sender, EventArgs e)
    {
        MembershipUser user = Membership.GetUser();
        if (user != null)
        {
            string id = ((ImageButton)sender).CommandArgument.ToString();
            sdsSoftDelete.UpdateParameters["DriverID"].DefaultValue = id;
            sdsSoftDelete.UpdateParameters["UserName"].DefaultValue = user.UserName;
            sdsSoftDelete.Update();
            rgSearch.Rebind();
        }
    }

    protected void RadGrid1_ItemDeleted(object source, GridDeletedEventArgs e)
    {
        String id = e.Item.GetDataKeyValue("DriverID").ToString();
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            DisplayMessage(false, "Driver " + id + " cannot be deleted. Reason: " + e.Exception.Message);
        }
        else
        {
            if (e.AffectedRows > 0)
            {
                DisplayMessage(true, "Driver " + id + " deleted.");
            }
            else
            {
                DisplayMessage(false, "Driver " + id + " cannot be deleted. Reason: It is in active state");
            }
        }
    }

    protected void RadGrid1_InsertCommand(object source, GridCommandEventArgs e)
    {
        if (!IsRadAsyncValid.Value)
        {
            e.Canceled = true;
            DisplayMessage(false, "The length of the uploaded file must be less than 1 MB");
            return;
        }

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
                        TextBox txtDriverName = (TextBox)item.FindControl("txtDriverName");
                        RadComboBox rcmbLocation = (RadComboBox)item.FindControl("rcmbLocation");
                        TextBox txtMobileNo = (TextBox)item.FindControl("txtMobileNo");
                        TextBox txtLicenseNo = (TextBox)item.FindControl("txtLicenseNo");
                        RadDatePicker rdtpLicenseExpiry = (RadDatePicker)item.FindControl("rdtpLicenseExpiry");
                        //RadNumericTextBox txtSalary = (RadNumericTextBox)item.FindControl("txtSalary");
                        TextBox txtNotes = (TextBox)item.FindControl("txtNotes");
                        RadDatePicker rdtpMedicalExpiry = (RadDatePicker)item.FindControl("rdtpMedicalExpiry");
                        TextBox txtInactiveNotes = (TextBox)item.FindControl("txtInactiveNote");

                        //RadAsyncUpload AsyncUpload1 = (RadAsyncUpload)item.FindControl("AsyncUpload1");
                        //if (AsyncUpload1.UploadedFiles.Count > 0)
                        //{
                        //    UploadedFile file = AsyncUpload1.UploadedFiles[0];
                        //    fileData = new byte[file.InputStream.Length];
                        //    file.InputStream.Read(fileData, 0, (int)file.InputStream.Length);
                        //}

                        sdsAddEditRecords.InsertParameters["DriverName"].DefaultValue = txtDriverName.Text;
                        sdsAddEditRecords.InsertParameters["LocationID"].DefaultValue = rcmbLocation.SelectedValue.ToString();
                        sdsAddEditRecords.InsertParameters["MobileNo"].DefaultValue = txtMobileNo.Text;
                        sdsAddEditRecords.InsertParameters["LicenseNo"].DefaultValue = txtLicenseNo.Text;
                        if (rdtpLicenseExpiry.SelectedDate.HasValue)
                        {
                            sdsAddEditRecords.InsertParameters["LicenseExpiry"].DefaultValue = rdtpLicenseExpiry.SelectedDate.Value.ToShortDateString();
                        }
                        else
                        {
                            sdsAddEditRecords.InsertParameters["LicenseExpiry"].DefaultValue = DBNull.Value.ToString();
                        }
                        if (rdtpMedicalExpiry.SelectedDate.HasValue)
                        {
                            sdsAddEditRecords.InsertParameters["MedicalExpiry"].DefaultValue = rdtpMedicalExpiry.SelectedDate.Value.ToShortDateString();
                        }
                        else
                        {
                            sdsAddEditRecords.InsertParameters["MedicalExpiry"].DefaultValue = rdtpMedicalExpiry.SelectedDate.Value.ToShortDateString();
                        }
                        //if (txtSalary.Value.HasValue)
                        //{
                        //    sdsAddEditRecords.InsertParameters["Salary"].DefaultValue = txtSalary.Value.Value.ToString();
                        //}
                        //else
                        //{
                        //    sdsAddEditRecords.InsertParameters["Salary"].DefaultValue = "0";
                        //}

                        sdsAddEditRecords.InsertParameters["Notes"].DefaultValue = txtNotes.Text;
                        sdsAddEditRecords.InsertParameters["UserName"].DefaultValue = user.UserName;
                        sdsAddEditRecords.InsertParameters["InactiveNote"].DefaultValue = txtInactiveNotes.Text;

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
        if (!IsRadAsyncValid.Value)
        {
            e.Canceled = true;
            DisplayMessage(false, "The length of the uploaded file must be less than 1 MB");
            return;
        }

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
                        string DriverID = item.GetDataKeyValue("DriverID").ToString();
                        //Access the textbox from the edit form template
                        TextBox txtDriverName = (TextBox)item.FindControl("txtDriverName");
                        RadComboBox rcmbLocation = (RadComboBox)item.FindControl("rcmbLocation");
                        TextBox txtMobileNo = (TextBox)item.FindControl("txtMobileNo");
                        TextBox txtLicenseNo = (TextBox)item.FindControl("txtLicenseNo");
                        TextBox txtNotes = (TextBox)item.FindControl("txtNotes");
                        RadDatePicker rdtpLicenseExpiry = (RadDatePicker)item.FindControl("rdtpLicenseExpiry");
                        RadDatePicker rdtpMedicalExpiry = (RadDatePicker)item.FindControl("rdtpMedicalExpiry");
                        TextBox txtInactiveNotes = (TextBox)item.FindControl("txtInactiveNote");
                        //RadNumericTextBox txtSalary = (RadNumericTextBox)item.FindControl("txtSalary");
                        
                        //RadAsyncUpload AsyncUpload1 = (RadAsyncUpload)item.FindControl("AsyncUpload1");
                        //if (AsyncUpload1.UploadedFiles.Count > 0)
                        //{
                        //    UploadedFile file = AsyncUpload1.UploadedFiles[0];
                        //    fileData = new byte[file.InputStream.Length];
                        //    file.InputStream.Read(fileData, 0, (int)file.InputStream.Length);
                        //}

                        sdsAddEditRecords.UpdateParameters["DriverName"].DefaultValue = txtDriverName.Text;
                        sdsAddEditRecords.UpdateParameters["LocationID"].DefaultValue = rcmbLocation.SelectedValue.ToString();
                        sdsAddEditRecords.UpdateParameters["MobileNo"].DefaultValue = txtMobileNo.Text;
                        sdsAddEditRecords.UpdateParameters["LicenseNo"].DefaultValue = txtLicenseNo.Text;
                        if (rdtpLicenseExpiry.SelectedDate.HasValue)
                        {
                            sdsAddEditRecords.UpdateParameters["LicenseExpiry"].DefaultValue = rdtpLicenseExpiry.SelectedDate.Value.ToShortDateString();
                        }
                        else
                        {
                            sdsAddEditRecords.UpdateParameters["LicenseExpiry"].DefaultValue = DBNull.Value.ToString();
                        }

                        if (rdtpMedicalExpiry.SelectedDate.HasValue)
                        {
                            sdsAddEditRecords.UpdateParameters["MedicalExpiry"].DefaultValue = rdtpMedicalExpiry.SelectedDate.Value.ToShortDateString();
                        }
                        else
                        {
                            sdsAddEditRecords.UpdateParameters["MedicalExpiry"].DefaultValue = DBNull.Value.ToString();
                        }
                        //if (txtSalary.Value.HasValue)
                        //{
                        //    sdsAddEditRecords.UpdateParameters["Salary"].DefaultValue = txtSalary.Value.Value.ToString();
                        //}
                        //else
                        //{
                        //    sdsAddEditRecords.UpdateParameters["Salary"].DefaultValue = "0";
                        //}
                        sdsAddEditRecords.UpdateParameters["Notes"].DefaultValue = txtNotes.Text;
                        sdsAddEditRecords.UpdateParameters["UserName"].DefaultValue = user.UserName;
                        sdsAddEditRecords.UpdateParameters["InactiveNote"].DefaultValue = txtInactiveNotes.Text;
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

    protected void sdsAddEditRecords_Updating(object sender, SqlDataSourceCommandEventArgs e)
    {
        //e.Command.Parameters["@Photo"].Value = fileData;
    }

    protected void sdsAddEditRecords_Inserting(object sender, SqlDataSourceCommandEventArgs e)
    {
        //e.Command.Parameters["@Photo"].Value = fileData;
    }

    public void RadAsyncUpload1_ValidatingFile(object sender, Telerik.Web.UI.Upload.ValidateFileEventArgs e)
    {
        if ((totalBytes < MaxTotalBytes) && (e.UploadedFile.ContentLength < MaxTotalBytes))
        {
            e.IsValid = true;
            totalBytes += (int)e.UploadedFile.ContentLength;
            IsRadAsyncValid = true;
        }
        else
        {
            e.IsValid = false;
            IsRadAsyncValid = false;
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
