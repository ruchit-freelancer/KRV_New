using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Web.Security;

public partial class DriverExpenses : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void rgDriverExpense_ItemDataBound(object sender, GridItemEventArgs e)
    {
        try
        {
            if (e.Item is GridEditFormInsertItem)
            {
                GridEditFormInsertItem insertForm = (GridEditFormInsertItem)e.Item;
                RadDatePicker rdtpExpenseDate = (RadDatePicker)insertForm.FindControl("rdtpExpenseDate");
                rdtpExpenseDate.SelectedDate = DateTime.Now;
            }
        }
        catch (Exception ae)
        {
            DisplayMessage(rgDriverExpense, false, "Loading Failed. Reason: " + ae.Message);
        }
    }

    protected void imgActiveDriverExpenses_Click(object sender, EventArgs e)
    {
        MembershipUser user = Membership.GetUser();
        if (user != null)
        {
            string id = ((ImageButton)sender).CommandArgument.ToString();
            sdsSoftDeleteDriverExpenses.UpdateParameters["ExpenseID"].DefaultValue = id;
            sdsSoftDeleteDriverExpenses.UpdateParameters["UserName"].DefaultValue = user.UserName;
            sdsSoftDeleteDriverExpenses.Update();
            rgDriverExpense.Rebind();
        }
    }

    protected void rgDriverExpenses_ItemDeleted(object source, GridDeletedEventArgs e)
    {
        String id = e.Item.GetDataKeyValue("ExpenseID").ToString();
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            DisplayMessage(rgDriverExpense, false, "Driver Expense " + id + " cannot be deleted. Reason: " + e.Exception.Message);
        }
        else
        {
            if (e.AffectedRows > 0)
            {
                DisplayMessage(rgDriverExpense, true, "Driver Expense " + id + " deleted.");
            }
            else
            {
                DisplayMessage(rgDriverExpense, false, "Driver Expense " + id + " cannot be deleted. Reason: It is in active state");
            }
        }
    }

    protected void rgDriverExpenses_InsertCommand(object source, GridCommandEventArgs e)
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
                        RadDatePicker rdtpExpenseDate = (RadDatePicker)item.FindControl("rdtpExpenseDate");
                        RadComboBox rcmbExpenseTypes = (RadComboBox)item.FindControl("rcmbExpenseTypes");
                        RadComboBox rcmbDrivers = (RadComboBox)item.FindControl("rcmbDrivers");
                        RadNumericTextBox txtTotalAmount = (RadNumericTextBox)item.FindControl("txtTotalAmount");
                        TextBox txtNotes = (TextBox)item.FindControl("txtNotes");

                        sdsDriverExpenses.InsertParameters["Notes"].DefaultValue = txtNotes.Text;
                        sdsDriverExpenses.InsertParameters["TripID"].DefaultValue = "0";
                        sdsDriverExpenses.InsertParameters["DriverID"].DefaultValue = rcmbDrivers.SelectedValue.ToString();

                        if (rdtpExpenseDate.SelectedDate.HasValue)
                        {
                            sdsDriverExpenses.InsertParameters["ExpenseDate"].DefaultValue = rdtpExpenseDate.SelectedDate.Value.ToShortDateString();
                        }
                        else
                        {
                            sdsDriverExpenses.InsertParameters["ExpenseDate"].DefaultValue = DBNull.Value.ToString();
                        }
                        if (txtTotalAmount.Value.HasValue)
                        {
                            sdsDriverExpenses.InsertParameters["TotalAmount"].DefaultValue = txtTotalAmount.Value.Value.ToString();
                        }
                        else
                        {
                            sdsDriverExpenses.InsertParameters["TotalAmount"].DefaultValue = "0";
                        }
                        sdsDriverExpenses.InsertParameters["ExpenseTypeID"].DefaultValue = rcmbExpenseTypes.SelectedValue.ToString();
                        sdsDriverExpenses.InsertParameters["UserName"].DefaultValue = user.UserName;
                        int result = sdsDriverExpenses.Insert();
                        DisplayMessage(rgDriverExpense, true, WebHelper.GetSaveSuccess());
                    }
                }
            }
            catch (Exception ex)
            {
                DisplayMessage(rgDriverExpense, false, WebHelper.GetSaveFail() + ". Reason: " + ex.Message);
                e.Canceled = true;
            }
        }
    }

    protected void rgDriverExpenses_UpdateCommand(object source, GridCommandEventArgs e)
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
                        string expenseID = item.GetDataKeyValue("ExpenseID").ToString();
                        //Access the textbox from the edit form template
                        RadDatePicker rdtpExpenseDate = (RadDatePicker)item.FindControl("rdtpExpenseDate");
                        RadComboBox rcmbExpenseTypes = (RadComboBox)item.FindControl("rcmbExpenseTypes");
                        RadComboBox rcmbDrivers = (RadComboBox)item.FindControl("rcmbDrivers");
                        RadNumericTextBox txtTotalAmount = (RadNumericTextBox)item.FindControl("txtTotalAmount");
                        TextBox txtNotes = (TextBox)item.FindControl("txtNotes");

                        sdsDriverExpenses.UpdateParameters["Notes"].DefaultValue = txtNotes.Text;
                        sdsDriverExpenses.UpdateParameters["ExpenseID"].DefaultValue = expenseID;
                        sdsDriverExpenses.UpdateParameters["DriverID"].DefaultValue = rcmbDrivers.SelectedValue.ToString();

                        if (rdtpExpenseDate.SelectedDate.HasValue)
                        {
                            sdsDriverExpenses.UpdateParameters["ExpenseDate"].DefaultValue = rdtpExpenseDate.SelectedDate.Value.ToShortDateString();
                        }
                        else
                        {
                            sdsDriverExpenses.UpdateParameters["ExpenseDate"].DefaultValue = DBNull.Value.ToString();
                        }
                        if (txtTotalAmount.Value.HasValue)
                        {
                            sdsDriverExpenses.UpdateParameters["TotalAmount"].DefaultValue = txtTotalAmount.Value.Value.ToString();
                        }
                        else
                        {
                            sdsDriverExpenses.UpdateParameters["TotalAmount"].DefaultValue = "0";
                        }
                        sdsDriverExpenses.UpdateParameters["ExpenseTypeID"].DefaultValue = rcmbExpenseTypes.SelectedValue.ToString();
                        sdsDriverExpenses.UpdateParameters["UserName"].DefaultValue = user.UserName;
                        int result = sdsDriverExpenses.Update();
                        DisplayMessage(rgDriverExpense, true, WebHelper.GetUpdateSuccess());
                    }
                }
            }
            catch (Exception ex)
            {
                DisplayMessage(rgDriverExpense, false, WebHelper.GetUpdateFail() + ". Reason: " + ex.Message);
                e.Canceled = true;
            }
        }
    }

    void DisplayMessage(RadGrid rgGrid, bool status, String message)
    {
        if (status)
        {
            rgGrid.Controls.Add(new LiteralControl(string.Format("<span style='color:Green'>{0}</span>", message)));
        }
        else
        {
            rgGrid.Controls.Add(new LiteralControl(string.Format("<span style='color:red'>{0}</span>", message)));
        }
    }
}
