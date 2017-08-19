using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using Telerik.Web.UI;
using System.Data;
using System.Configuration;
using System.IO;
using System.Data.SqlClient;

public partial class Trips : System.Web.UI.Page
{
    const int MaxTotalBytes = 1048576; // 1 MB
    Int64 totalBytes;
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

    protected void Page_Load(object sender, EventArgs e)
    {
        //IsRadAsyncValid = null;
    }

    protected void Page_PreRender(object sender, EventArgs e)
    {

    }
    void BindInnerGrid(string gridName)
    {
        foreach (GridDataItem item in rgSearch.EditItems)
        {
            GridEditableItem itemToEdit = (GridEditableItem)item.EditFormItem;
            RadGrid RadGrid1 = (RadGrid)itemToEdit.FindControl(gridName);
            if (RadGrid1 != null)
            {
                RadGrid1.Rebind();
            }
        }
    }

    protected void RadTabStrip1_TabClick(object sender, RadTabStripEventArgs e)
    {
        string a = e.Tab.PageViewID;
        switch (a)
        {
            case "rpvTripStops":
                sdsGetTruckLocation.SelectParameters["TruckNo"].DefaultValue = hfTruckNo.Value;
                hfLocationID.Value = ((DataView)sdsGetTruckLocation.Select(DataSourceSelectArguments.Empty)).Table.Rows[0]["LocationID"].ToString();
                sdsTripStops.SelectParameters["TripID"].DefaultValue = hfTripID.Value;
                break;
            case "rpvTripRoutes":
                sdsTripRoutes.SelectParameters["TripID"].DefaultValue = hfTripID.Value;
                sdsTripRouteNotSelected.SelectParameters["TripID"].DefaultValue = hfTripID.Value;
                break;
            case "rpvStateTravelled":
                sdsStateTravelled.SelectParameters["TripID"].DefaultValue = hfTripID.Value;
                break;
            case "rpvTripIncidents":
                sdsTripIncidents.SelectParameters["TripID"].DefaultValue = hfTripID.Value;
                break;
            case "rpvDriverExpense":
                sdsDriverExpenses.SelectParameters["TripID"].DefaultValue = hfTripID.Value;
                break;
            case "rpvTripPictures":
                sdsTripPictures.SelectParameters["TripID"].DefaultValue = hfTripID.Value;
                break;
        }

    }

    #region Trips



    protected void Trips_OnInserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        hfTripID.Value = e.Command.Parameters["@TripID"].Value.ToString();
    }

    protected void RadGrid1_ItemCommand(object sender, GridCommandEventArgs e)
    {
        RadGrid grid = (sender as RadGrid);
        if (e.CommandName == "Cancel")
        {
            hfTripID.Value = "0";
            hfTruckNo.Value = "0";
            hfLocationID.Value = "0";
        }
        else if (e.CommandName == RadGrid.InitInsertCommandName)
        {
            grid.MasterTableView.ClearEditItems();
        }
        else if (e.CommandName == RadGrid.EditCommandName)
        {
            grid.MasterTableView.ClearEditItems();
            e.Item.OwnerTableView.IsItemInserted = false;
            txtTripStartOdometer.Text = e.Item.Cells[9].Text;
        }
    }

    protected void RadGrid1_ItemDataBound(object sender, GridItemEventArgs e)
    {
        try
        {
            //if (e.Item is GridDataItem)
            //{
            //    if (hfTripID.Value == e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["TripID"].ToString())
            //    {
            //        e.Item.Edit = true;
            //        txtTripStartOdometer.Text = e.Item.Cells[9].Text;

            //        //Session["TripStartOdometer"] = e.Item.Cells[9].Text;
            //    }
            //}
            if (e.Item is GridEditFormInsertItem)
            {
                GridEditFormInsertItem insertForm = (GridEditFormInsertItem)e.Item;
                hfTripID.Value = "0";
                hfLocationID.Value = "0";
                hfTruckNo.Value = "0";
                RadTabStrip rtsTrips = (RadTabStrip)insertForm.FindControl("rtsTrips");
                RadDatePicker rdtpTripDate = (RadDatePicker)insertForm.FindControl("rdtpTripDate");
                rdtpTripDate.SelectedDate = DateTime.Now;
                rtsTrips.Tabs[1].Enabled = false;
                rtsTrips.Tabs[2].Enabled = false;
                rtsTrips.Tabs[3].Enabled = false;
                rtsTrips.Tabs[4].Enabled = false;
                rtsTrips.Tabs[5].Enabled = false;
            }
            else if (e.Item is GridEditFormItem && e.Item.IsInEditMode)
            {
                GridEditFormItem edititem = (GridEditFormItem)e.Item;
                GridDataItem item = (GridDataItem)edititem.ParentItem;
                hfTripID.Value = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["TripID"].ToString();
                if (item["StartOdometer"].Text != "&nbsp;")
                {
                    txtTripStartOdometer.Text = item["StartOdometer"].Text;//setting TextBox value based on cell value
                    hfTruckNo.Value = item["TruckNo"].Text;
                    //Session["TripStartOdometer"] = item["StartOdometer"].Text;
                }
            }
        }
        catch (Exception ae) { }
    }

    protected void imgActive_Click(object sender, EventArgs e)
    {
        MembershipUser user = Membership.GetUser();
        if (user != null)
        {
            string id = ((ImageButton)sender).CommandArgument.ToString();
            sdsSoftDelete.UpdateParameters["TripID"].DefaultValue = id;
            sdsSoftDelete.UpdateParameters["UserName"].DefaultValue = user.UserName;
            sdsSoftDelete.Update();
            rgSearch.Rebind();
        }
    }

    protected void RadGrid1_ItemDeleted(object source, GridDeletedEventArgs e)
    {
        String id = e.Item.GetDataKeyValue("TripID").ToString();
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            DisplayMessage(rgSearch, false, "Trip " + id + " cannot be deleted. Reason: " + e.Exception.Message);
        }
        else
        {
            if (e.AffectedRows > 0)
            {
                DisplayMessage(rgSearch, true, "Trip " + id + " deleted.");
            }
            else
            {
                DisplayMessage(rgSearch, false, "Trip " + id + " cannot be deleted. Reason: It is in active state");
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
                        RadGrid grid = (RadGrid)item.FindControl("rgSearch");

                        //Access the textbox from the edit form template
                        RadComboBox rcmbTrucks = (RadComboBox)item.FindControl("rcmbTrucks");
                        RadComboBox rcmbDriver = (RadComboBox)item.FindControl("rcmbDriver");
                        RadComboBox rcmbLocation = (RadComboBox)item.FindControl("rcmbLocation");
                        RadComboBox rcmbTripType = (RadComboBox)item.FindControl("rcmbTripType");
                        RadDatePicker rdtpTripDate = (RadDatePicker)item.FindControl("rdtpTripDate");
                        RadDateTimePicker rdtpTripStart = (RadDateTimePicker)item.FindControl("rdtpTripStart");
                        RadDateTimePicker rdtpTripEnd = (RadDateTimePicker)item.FindControl("rdtpTripEnd");
                        RadNumericTextBox txtStartOdometer = (RadNumericTextBox)item.FindControl("txtStartOdometer");
                        RadNumericTextBox txtEndOdometer = (RadNumericTextBox)item.FindControl("txtEndOdometer");

                        sdsAddEditRecords.InsertParameters["TruckID"].DefaultValue = rcmbTrucks.SelectedValue.ToString();
                        sdsAddEditRecords.InsertParameters["LocationID"].DefaultValue = rcmbLocation.SelectedValue.ToString();
                        sdsAddEditRecords.InsertParameters["DriverID"].DefaultValue = rcmbDriver.SelectedValue.ToString();
                        sdsAddEditRecords.InsertParameters["TripTypeID"].DefaultValue = rcmbTripType.SelectedValue.ToString();
                        if (rdtpTripDate.SelectedDate.HasValue)
                        {
                            sdsAddEditRecords.InsertParameters["TripDate"].DefaultValue = rdtpTripDate.SelectedDate.Value.ToShortDateString();
                        }
                        else
                        {
                            sdsAddEditRecords.InsertParameters["TripDate"].DefaultValue = DBNull.Value.ToString();
                        }

                        if (rdtpTripStart.SelectedDate.HasValue)
                        {
                            sdsAddEditRecords.InsertParameters["TripStart"].DefaultValue = rdtpTripStart.SelectedDate.Value.ToString();
                        }
                        else
                        {
                            sdsAddEditRecords.InsertParameters["TripStart"].DefaultValue = DBNull.Value.ToString();
                        }

                        if (rdtpTripEnd.SelectedDate.HasValue)
                        {
                            sdsAddEditRecords.InsertParameters["TripEnd"].DefaultValue = rdtpTripEnd.SelectedDate.Value.ToString();
                        }
                        else
                        {
                            sdsAddEditRecords.InsertParameters["TripEnd"].DefaultValue = DBNull.Value.ToString();
                        }

                        if (txtStartOdometer.Value.HasValue)
                        {
                            sdsAddEditRecords.InsertParameters["StartOdometer"].DefaultValue = txtStartOdometer.Value.Value.ToString();
                        }
                        else
                        {
                            sdsAddEditRecords.InsertParameters["StartOdometer"].DefaultValue = "0";
                        }

                        if (txtEndOdometer.Value.HasValue)
                        {
                            sdsAddEditRecords.InsertParameters["EndOdometer"].DefaultValue = txtEndOdometer.Value.Value.ToString();
                        }
                        else
                        {
                            sdsAddEditRecords.InsertParameters["EndOdometer"].DefaultValue = "0";
                        }
                        sdsAddEditRecords.InsertParameters["UserName"].DefaultValue = user.UserName;
                        int result = sdsAddEditRecords.Insert();
                        DisplayMessage(rgSearch, true, WebHelper.GetSaveSuccess());

                    }
                }

            }
            catch (Exception ex)
            {
                DisplayMessage(rgSearch, false, WebHelper.GetSaveFail() + ". Reason: " + ex.Message);
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
                        RadMultiPage radmultipage1 = (RadMultiPage)e.Item.FindControl("RadMultiPage1");
                        int selectedIndex = radmultipage1.SelectedIndex;
                        //Get the primary key value using the DataKeyValue.    
                        string tripID = item.GetDataKeyValue("TripID").ToString();
                        //Access the textbox from the edit form template
                        if (selectedIndex == 0)
                        {
                            RadComboBox rcmbTrucks = (RadComboBox)item.FindControl("rcmbTrucks");
                            RadComboBox rcmbDriver = (RadComboBox)item.FindControl("rcmbDriver");
                            RadComboBox rcmbLocation = (RadComboBox)item.FindControl("rcmbLocation");
                            RadComboBox rcmbTripType = (RadComboBox)item.FindControl("rcmbTripType");
                            RadDatePicker rdtpTripDate = (RadDatePicker)item.FindControl("rdtpTripDate");
                            RadDateTimePicker rdtpTripStart = (RadDateTimePicker)item.FindControl("rdtpTripStart");
                            RadDateTimePicker rdtpTripEnd = (RadDateTimePicker)item.FindControl("rdtpTripEnd");
                            RadNumericTextBox txtStartOdometer = (RadNumericTextBox)item.FindControl("txtStartOdometer");
                            RadNumericTextBox txtEndOdometer = (RadNumericTextBox)item.FindControl("txtEndOdometer");

                            sdsAddEditRecords.UpdateParameters["TripID"].DefaultValue = tripID;
                            sdsAddEditRecords.UpdateParameters["TruckID"].DefaultValue = rcmbTrucks.SelectedValue.ToString();
                            sdsAddEditRecords.UpdateParameters["DriverID"].DefaultValue = rcmbDriver.SelectedValue.ToString();
                            sdsAddEditRecords.UpdateParameters["LocationID"].DefaultValue = rcmbLocation.SelectedValue.ToString();
                            sdsAddEditRecords.UpdateParameters["TripTypeID"].DefaultValue = rcmbTripType.SelectedValue.ToString();
                            if (rdtpTripDate.SelectedDate.HasValue)
                            {
                                sdsAddEditRecords.UpdateParameters["TripDate"].DefaultValue = rdtpTripDate.SelectedDate.Value.ToShortDateString();
                            }
                            else
                            {
                                sdsAddEditRecords.UpdateParameters["TripDate"].DefaultValue = DBNull.Value.ToString();
                            }

                            if (rdtpTripStart.SelectedDate.HasValue)
                            {
                                sdsAddEditRecords.UpdateParameters["TripStart"].DefaultValue = rdtpTripStart.SelectedDate.Value.ToString();
                            }
                            else
                            {
                                sdsAddEditRecords.UpdateParameters["TripStart"].DefaultValue = DBNull.Value.ToString();
                            }

                            if (rdtpTripEnd.SelectedDate.HasValue)
                            {
                                sdsAddEditRecords.UpdateParameters["TripEnd"].DefaultValue = rdtpTripEnd.SelectedDate.Value.ToString();
                            }
                            else
                            {
                                sdsAddEditRecords.UpdateParameters["TripEnd"].DefaultValue = DBNull.Value.ToString();
                            }

                            if (txtStartOdometer.Value.HasValue)
                            {
                                sdsAddEditRecords.UpdateParameters["StartOdometer"].DefaultValue = txtStartOdometer.Value.Value.ToString();
                            }
                            else
                            {
                                sdsAddEditRecords.UpdateParameters["StartOdometer"].DefaultValue = "0";
                            }

                            if (txtEndOdometer.Value.HasValue)
                            {
                                sdsAddEditRecords.UpdateParameters["EndOdometer"].DefaultValue = txtEndOdometer.Value.Value.ToString();
                            }
                            else
                            {
                                sdsAddEditRecords.UpdateParameters["EndOdometer"].DefaultValue = "0";
                            }
                            sdsAddEditRecords.UpdateParameters["UserName"].DefaultValue = user.UserName;
                            int result = sdsAddEditRecords.Update();
                            DisplayMessage(rgSearch, true, WebHelper.GetUpdateSuccess());
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                DisplayMessage(rgSearch, false, WebHelper.GetUpdateFail() + ". Reason: " + ex.Message);
                e.Canceled = true;
            }
        }
    }

    #endregion

    #region Trip Stops

    protected void rgTripStops_ItemDataBound(object sender, GridItemEventArgs e)
    {
        try
        {
            if (e.Item is GridEditFormInsertItem)
            {
                GridEditFormInsertItem insertForm = (GridEditFormInsertItem)e.Item;
                RadNumericTextBox txtStopOdometer = (RadNumericTextBox)insertForm.FindControl("txtStopOdometer");
                RadComboBox rcmbCustomers = (RadComboBox)insertForm.FindControl("rcmbCustomers");
                RadComboBox rcmbLocations = (RadComboBox)insertForm.FindControl("rcmbLocations");
                TextBox txtTSO = (TextBox)insertForm.FindControl("txtTSO");
                txtStopOdometer.Text = txtTripStartOdometer.Text;
                txtTSO.Text = txtTripStartOdometer.Text;

                rcmbCustomers.Items.Clear();
                rcmbLocations.SelectedValue = hfLocationID.Value;
                sdsCustomers.SelectParameters["LocationID"].DefaultValue = hfLocationID.Value;
                rcmbCustomers.DataBind();
            }
            else if (e.Item is GridEditableItem && e.Item.IsInEditMode)
            {
                HiddenField hfCustomerID = (HiddenField)e.Item.FindControl("hfCustomerID");
                HiddenField hfLocationID1 = (HiddenField)e.Item.FindControl("hfLocationID");
                if (hfCustomerID != null && hfLocationID != null)
                {
                    GridEditFormItem editForm = (GridEditFormItem)e.Item;
                    RadComboBox rcmbCustomers = (RadComboBox)editForm.FindControl("rcmbCustomers");

                    rcmbCustomers.Items.Clear();
                    sdsCustomers.SelectParameters["LocationID"].DefaultValue = hfLocationID1.Value;
                    rcmbCustomers.DataBind();
                    rcmbCustomers.Items.FindItemByValue(hfCustomerID.Value).Selected = true;
                    rcmbCustomers.Focus();
                }
            }
        }
        catch (Exception ae) { }
    }

    protected void rcmbLocations_SelectedIndexChanged(object sender, EventArgs e)
    {
        RadComboBox rcmbLocations = (RadComboBox)sender;
        GridEditFormItem editItem = (GridEditFormItem)rcmbLocations.NamingContainer;
        RadComboBox rcmbCustomers = (RadComboBox)editItem.FindControl("rcmbCustomers"); // accessing the RadComboBox control
        if (rcmbCustomers != null)
        {
            rcmbCustomers.Items.Clear();
            if (rcmbLocations.SelectedIndex > 0)
            {
                sdsCustomers.SelectParameters["LocationID"].DefaultValue = rcmbLocations.SelectedValue.ToString();
            }
            else
            {
                sdsCustomers.SelectParameters["LocationID"].DefaultValue = "0";
            }
            rcmbCustomers.Items.Clear();
            rcmbCustomers.DataBind();
            rcmbCustomers.Text = "";
            rcmbCustomers.Focus();
        }
    }

    protected void imgActiveTripStops_Click(object sender, EventArgs e)
    {
        MembershipUser user = Membership.GetUser();
        if (user != null)
        {
            ImageButton imgActiveTripStops = (ImageButton)sender;
            string id = imgActiveTripStops.CommandArgument.ToString();
            sdsSoftDeleteTripStops.UpdateParameters["StopID"].DefaultValue = id;
            sdsSoftDeleteTripStops.UpdateParameters["UserName"].DefaultValue = user.UserName;
            sdsSoftDeleteTripStops.Update();
            BindInnerGrid("rgTripStops");
        }
    }

    protected void rgTripStops_ItemDeleted(object source, GridDeletedEventArgs e)
    {
        //RadGrid rgTripStops = (RadGrid)rgSearch.EditItems[0].FindControl("rgTripStops");
        String id = e.Item.GetDataKeyValue("StopID").ToString();
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            //DisplayMessage(rgTripStops, false, "Stop " + id + " cannot be deleted. Reason: " + e.Exception.Message);
        }
        //else
        //{
        //    if (e.AffectedRows > 0)
        //    {
        //        DisplayMessage(rgTripStops, true, "Stop " + id + " deleted.");
        //    }
        //    else
        //    {
        //        DisplayMessage(rgTripStops, false, "Stop " + id + " cannot be deleted. Reason: It is in active state");
        //    }
        //}
    }

    protected void rgTripStops_InsertCommand(object source, GridCommandEventArgs e)
    {
        //RadGrid rgTripStops = (RadGrid)rgSearch.EditItems[0].FindControl("rgTripStops");
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
                        RadComboBox rcmbCustomers = (RadComboBox)item.FindControl("rcmbCustomers");
                        RadComboBox rcmbStopTypes = (RadComboBox)item.FindControl("rcmbStopTypes");
                        TextBox txtStopIndex = (TextBox)item.FindControl("txtStopIndex");
                        TextBox txtBOLNumber = (TextBox)item.FindControl("txtBOLNumber");
                        RadTimePicker rtpArrivalTime = (RadTimePicker)item.FindControl("rtpArrivalTime");
                        RadTimePicker rtpDepartureTime = (RadTimePicker)item.FindControl("rtpDepartureTime");
                        RadNumericTextBox txtSlabsDelivered = (RadNumericTextBox)item.FindControl("txtSlabsDelivered");
                        RadNumericTextBox txtSlabsPickedUp = (RadNumericTextBox)item.FindControl("txtSlabsPickedUp");
                        RadNumericTextBox txtStopOdometer = (RadNumericTextBox)item.FindControl("txtStopOdometer");

                        sdsTripStops.InsertParameters["TripID"].DefaultValue = hfTripID.Value.ToString();
                        sdsTripStops.InsertParameters["StopIndex"].DefaultValue = txtStopIndex.Text.Trim();
                        sdsTripStops.InsertParameters["CustomerID"].DefaultValue = rcmbCustomers.SelectedValue.ToString();
                        sdsTripStops.InsertParameters["StopTypeID"].DefaultValue = rcmbStopTypes.SelectedValue.ToString();
                        sdsTripStops.InsertParameters["BOLNumber"].DefaultValue = txtBOLNumber.Text.Trim();

                        if (rtpArrivalTime.SelectedDate.HasValue)
                        {
                            sdsTripStops.InsertParameters["ArrivalTime"].DefaultValue = rtpArrivalTime.SelectedDate.Value.ToString();
                        }
                        else
                        {
                            sdsTripStops.InsertParameters["ArrivalTime"].DefaultValue = DBNull.Value.ToString();
                        }

                        if (rtpDepartureTime.SelectedDate.HasValue)
                        {
                            sdsTripStops.InsertParameters["DepartureTime"].DefaultValue = rtpDepartureTime.SelectedDate.Value.ToString();
                        }
                        else
                        {
                            sdsTripStops.InsertParameters["DepartureTime"].DefaultValue = DBNull.Value.ToString();
                        }

                        if (txtSlabsDelivered.Value.HasValue)
                        {
                            sdsTripStops.InsertParameters["SlabsDelivered"].DefaultValue = txtSlabsDelivered.Value.Value.ToString();
                        }
                        else
                        {
                            sdsTripStops.InsertParameters["SlabsDelivered"].DefaultValue = "0";
                        }

                        if (txtSlabsPickedUp.Value.HasValue)
                        {
                            sdsTripStops.InsertParameters["SlabsPickedUp"].DefaultValue = txtSlabsPickedUp.Value.Value.ToString();
                        }
                        else
                        {
                            sdsTripStops.InsertParameters["SlabsPickedUp"].DefaultValue = "0";
                        }

                        if (txtStopOdometer.Value.HasValue)
                        {
                            sdsTripStops.InsertParameters["StopOdometer"].DefaultValue = txtStopOdometer.Value.Value.ToString();
                        }
                        else
                        {
                            sdsTripStops.InsertParameters["StopOdometer"].DefaultValue = "0";
                        }
                        sdsTripStops.InsertParameters["UserName"].DefaultValue = user.UserName;
                        int result = sdsTripStops.Insert();
                        //DisplayMessage(rgTripStops, true, WebHelper.GetSaveSuccess());
                    }
                }
            }
            catch (Exception ex)
            {
                //DisplayMessage(rgTripStops, false, WebHelper.GetSaveFail() + ". Reason: " + ex.Message);
                e.Canceled = true;
            }
        }
    }

    protected void rgTripStops_UpdateCommand(object source, GridCommandEventArgs e)
    {
        //RadGrid rgTripStops = (RadGrid)rgSearch.EditItems[0].FindControl("rgTripStops");
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
                        string stopID = item.GetDataKeyValue("StopID").ToString();
                        //Access the textbox from the edit form template
                        RadComboBox rcmbCustomers = (RadComboBox)item.FindControl("rcmbCustomers");
                        RadComboBox rcmbStopTypes = (RadComboBox)item.FindControl("rcmbStopTypes");
                        TextBox txtStopIndex = (TextBox)item.FindControl("txtStopIndex");
                        TextBox txtBOLNumber = (TextBox)item.FindControl("txtBOLNumber");
                        RadTimePicker rtpArrivalTime = (RadTimePicker)item.FindControl("rtpArrivalTime");
                        RadTimePicker rtpDepartureTime = (RadTimePicker)item.FindControl("rtpDepartureTime");
                        RadNumericTextBox txtSlabsDelivered = (RadNumericTextBox)item.FindControl("txtSlabsDelivered");
                        RadNumericTextBox txtSlabsPickedUp = (RadNumericTextBox)item.FindControl("txtSlabsPickedUp");
                        RadNumericTextBox txtStopOdometer = (RadNumericTextBox)item.FindControl("txtStopOdometer");

                        sdsTripStops.UpdateParameters["StopID"].DefaultValue = stopID;
                        sdsTripStops.UpdateParameters["StopIndex"].DefaultValue = txtStopIndex.Text.Trim();
                        sdsTripStops.UpdateParameters["CustomerID"].DefaultValue = rcmbCustomers.SelectedValue.ToString();
                        sdsTripStops.UpdateParameters["StopTypeID"].DefaultValue = rcmbStopTypes.SelectedValue.ToString();
                        sdsTripStops.UpdateParameters["BOLNumber"].DefaultValue = txtBOLNumber.Text.Trim();

                        if (rtpArrivalTime.SelectedDate.HasValue)
                        {
                            sdsTripStops.UpdateParameters["ArrivalTime"].DefaultValue = rtpArrivalTime.SelectedDate.Value.ToString();
                        }
                        else
                        {
                            sdsTripStops.UpdateParameters["ArrivalTime"].DefaultValue = DBNull.Value.ToString();
                        }

                        if (rtpDepartureTime.SelectedDate.HasValue)
                        {
                            sdsTripStops.UpdateParameters["DepartureTime"].DefaultValue = rtpDepartureTime.SelectedDate.Value.ToString();
                        }
                        else
                        {
                            sdsTripStops.UpdateParameters["DepartureTime"].DefaultValue = DBNull.Value.ToString();
                        }

                        if (txtSlabsDelivered.Value.HasValue)
                        {
                            sdsTripStops.UpdateParameters["SlabsDelivered"].DefaultValue = txtSlabsDelivered.Value.Value.ToString();
                        }
                        else
                        {
                            sdsTripStops.UpdateParameters["SlabsDelivered"].DefaultValue = "0";
                        }

                        if (txtSlabsPickedUp.Value.HasValue)
                        {
                            sdsTripStops.UpdateParameters["SlabsPickedUp"].DefaultValue = txtSlabsPickedUp.Value.Value.ToString();
                        }
                        else
                        {
                            sdsTripStops.UpdateParameters["SlabsPickedUp"].DefaultValue = "0";
                        }

                        if (txtStopOdometer.Value.HasValue)
                        {
                            sdsTripStops.UpdateParameters["StopOdometer"].DefaultValue = txtStopOdometer.Value.Value.ToString();
                        }
                        else
                        {
                            sdsTripStops.UpdateParameters["StopOdometer"].DefaultValue = "0";
                        }
                        sdsTripStops.UpdateParameters["UserName"].DefaultValue = user.UserName;
                        int result = sdsTripStops.Update();
                        //DisplayMessage(rgTripStops, true, WebHelper.GetUpdateSuccess());

                    }
                }
            }
            catch (Exception ex)
            {
                //DisplayMessage(rgTripStops, false, WebHelper.GetUpdateFail() + ". Reason: " + ex.Message);
                e.Canceled = true;
            }
        }
    }

    #endregion

    #region Trip Routes

    protected void imgAddTripRoutes_Click(object sender, EventArgs e)
    {
        MembershipUser user = Membership.GetUser();
        if (user != null)
        {
            sdsTripRouteNotSelected.InsertParameters["TripID"].DefaultValue = hfTripID.Value;
            sdsTripRouteNotSelected.InsertParameters["RouteID"].DefaultValue = ((ImageButton)sender).CommandArgument.ToString();
            sdsTripRouteNotSelected.InsertParameters["UserName"].DefaultValue = user.UserName;
            sdsTripRouteNotSelected.Insert();
            BindInnerGrid("rgTripRoutesNotSelected");
            BindInnerGrid("rgTripRoutes");
        }
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        MembershipUser user = Membership.GetUser();
        if (user != null)
        {
            string routeIDs = "";
            foreach (GridDataItem item in rgSearch.EditItems)
            {
                GridEditableItem itemToEdit = (GridEditableItem)item.EditFormItem;
                RadGrid rgTripRoutesNotSelected = (RadGrid)itemToEdit.FindControl("rgTripRoutesNotSelected");
                if (rgTripRoutesNotSelected != null)
                {
                    foreach (GridDataItem selectItem in rgTripRoutesNotSelected.MasterTableView.Items)
                    {
                        if (selectItem.Selected)
                        {
                            routeIDs += ((HiddenField)selectItem.FindControl("hfRouteID")).Value + ",";
                        }
                    }
                }
            }
            sdsTripRouteNotSelected.InsertParameters["TripID"].DefaultValue = hfTripID.Value;
            sdsTripRouteNotSelected.InsertParameters["RouteIDs"].DefaultValue = routeIDs;
            sdsTripRouteNotSelected.InsertParameters["UserName"].DefaultValue = user.UserName;
            sdsTripRouteNotSelected.Insert();
            BindInnerGrid("rgTripRoutesNotSelected");
            BindInnerGrid("rgTripRoutes");
        }
    }

    protected void imgActiveTripRoutes_Click(object sender, EventArgs e)
    {
        MembershipUser user = Membership.GetUser();
        if (user != null)
        {
            string id = ((ImageButton)sender).CommandArgument.ToString();
            sdsTripRoutes.UpdateParameters["TripRouteID"].DefaultValue = id;
            sdsTripRoutes.UpdateParameters["UserName"].DefaultValue = user.UserName;
            sdsTripRoutes.Update();
            BindInnerGrid("rgTripRoutesNotSelected");
            BindInnerGrid("rgTripRoutes");
        }
    }

    protected void btnRemove_Click(object sender, EventArgs e)
    {
        MembershipUser user = Membership.GetUser();
        if (user != null)
        {
            string tripRouteIDs = "";
            foreach (GridDataItem item in rgSearch.EditItems)
            {
                GridEditableItem itemToEdit = (GridEditableItem)item.EditFormItem;
                RadGrid rgTripRoutes = (RadGrid)itemToEdit.FindControl("rgTripRoutes");
                if (rgTripRoutes != null)
                {
                    foreach (GridDataItem selectItem in rgTripRoutes.MasterTableView.Items)
                    {
                        if (selectItem.Selected)
                        {
                            tripRouteIDs += ((HiddenField)selectItem.FindControl("hfTripRouteID")).Value + ",";
                        }
                    }
                }
            }
            sdsTripRoutes.UpdateParameters["TripRouteIDs"].DefaultValue = tripRouteIDs;
            sdsTripRoutes.UpdateParameters["UserName"].DefaultValue = user.UserName;
            sdsTripRoutes.Update();
            BindInnerGrid("rgTripRoutesNotSelected");
            BindInnerGrid("rgTripRoutes");
        }
    }

    protected void rgTripRoutes_ItemDeleted(object source, GridDeletedEventArgs e)
    {
        String id = e.Item.GetDataKeyValue("TripRouteID").ToString();
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            //DisplayMessage(rgTripRoutes, false, "Trip-Route " + id + " cannot be deleted. Reason: " + e.Exception.Message);
        }
        else
        {
            BindInnerGrid("rgTripRoutesNotSelected");
            BindInnerGrid("rgTripRoutes");
            //    if (e.AffectedRows > 0)
            //    {
            //        rgTripRoutesNotSelected.Rebind();
            //        DisplayMessage(rgTripRoutes, true, "Trip-Route " + id + " deleted.");
            //    }
            //    else
            //    {
            //        DisplayMessage(rgTripRoutes, false, "Trip-Route " + id + " cannot be deleted. Reason: It is in active state");
            //    }
        }
    }

    #endregion

    #region Trip - State Travelled

    protected void rgStateTravelled_ItemDataBound(object sender, GridItemEventArgs e)
    {
        try
        {
            if (e.Item is GridEditFormInsertItem)
            {
                GridEditFormInsertItem insertForm = (GridEditFormInsertItem)e.Item;
                RadNumericTextBox txtStartOdometer = (RadNumericTextBox)insertForm.FindControl("txtStartOdometer");
                RadNumericTextBox txtEndOdometer = (RadNumericTextBox)insertForm.FindControl("txtEndOdometer");
                txtStartOdometer.Text = txtTripStartOdometer.Text;
                txtEndOdometer.Text = txtTripStartOdometer.Text;
            }
        }
        catch (Exception) { }
    }

    protected void imgActiveStateTravelled_Click(object sender, EventArgs e)
    {
        MembershipUser user = Membership.GetUser();
        if (user != null)
        {
            string id = ((ImageButton)sender).CommandArgument.ToString();
            sdsSoftDeleteStateTravelled.UpdateParameters["TravelledID"].DefaultValue = id;
            sdsSoftDeleteStateTravelled.UpdateParameters["UserName"].DefaultValue = user.UserName;
            sdsSoftDeleteStateTravelled.Update();
            BindInnerGrid("rgStateTravelled");
        }
    }

    protected void StateTravelled_ItemDeleted(object source, GridDeletedEventArgs e)
    {
        //RadGrid rgStateTravelled = (RadGrid)rgSearch.EditItems[0].FindControl("rgStateTravelled");
        String id = e.Item.GetDataKeyValue("TravelledID").ToString();
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            //DisplayMessage(rgStateTravelled, false, "Travelled " + id + " cannot be deleted. Reason: " + e.Exception.Message);
        }
        //else
        //{
        //    if (e.AffectedRows > 0)
        //    {
        //        DisplayMessage(rgStateTravelled, true, "Travelled " + id + " deleted.");
        //    }
        //    else
        //    {
        //        DisplayMessage(rgStateTravelled, false, "Travelled " + id + " cannot be deleted. Reason: It is in active state");
        //    }
        //}
    }

    protected void StateTravelled_InsertCommand(object source, GridCommandEventArgs e)
    {
        MembershipUser user = Membership.GetUser();
        if (user != null)
        {
            //RadGrid rgStateTravelled = (RadGrid)rgSearch.EditItems[0].FindControl("rgStateTravelled");
            try
            {
                if (e.CommandName == "PerformInsert")
                {
                    if (e.Item is GridEditFormItem)
                    {
                        //Get the GridEditableItem of the RadGrid    
                        GridEditFormItem item = (GridEditFormItem)e.Item;

                        //Access the textbox from the edit form template
                        RadComboBox rcmbStateName = (RadComboBox)item.FindControl("rcmbStateName");
                        RadNumericTextBox txtStartOdometer = (RadNumericTextBox)item.FindControl("txtStartOdometer");
                        RadNumericTextBox txtEndOdometer = (RadNumericTextBox)item.FindControl("txtEndOdometer");

                        sdsStateTravelled.InsertParameters["TripID"].DefaultValue = hfTripID.Value;
                        sdsStateTravelled.InsertParameters["StateID"].DefaultValue = rcmbStateName.SelectedValue.ToString();

                        if (txtStartOdometer.Value.HasValue)
                        {
                            sdsStateTravelled.InsertParameters["StartOdometer"].DefaultValue = txtStartOdometer.Value.Value.ToString();
                        }
                        else
                        {
                            sdsStateTravelled.InsertParameters["StartOdometer"].DefaultValue = "0";
                        }

                        if (txtEndOdometer.Value.HasValue)
                        {
                            sdsStateTravelled.InsertParameters["EndOdometer"].DefaultValue = txtEndOdometer.Value.Value.ToString();
                        }
                        else
                        {
                            sdsStateTravelled.InsertParameters["EndOdometer"].DefaultValue = "0";
                        }
                        sdsStateTravelled.InsertParameters["UserName"].DefaultValue = user.UserName;
                        int result = sdsStateTravelled.Insert();
                        //DisplayMessage(rgStateTravelled, true, WebHelper.GetSaveSuccess());
                    }
                }
            }
            catch (Exception ex)
            {
                //DisplayMessage(rgStateTravelled, false, WebHelper.GetSaveFail() + ". Reason: " + ex.Message);
                e.Canceled = true;
            }
        }
    }

    protected void StateTravelled_UpdateCommand(object source, GridCommandEventArgs e)
    {
        MembershipUser user = Membership.GetUser();
        if (user != null)
        {
            //RadGrid rgStateTravelled = (RadGrid)rgSearch.EditItems[0].FindControl("rgStateTravelled");
            try
            {
                if (e.CommandName == RadGrid.UpdateCommandName)
                {
                    if (e.Item is GridEditFormItem)
                    {
                        //Get the GridEditableItem of the RadGrid    
                        GridEditFormItem item = (GridEditFormItem)e.Item;

                        //Get the primary key value using the DataKeyValue.    
                        string travelledID = item.GetDataKeyValue("TravelledID").ToString();
                        //Access the textbox from the edit form template
                        RadComboBox rcmbStateName = (RadComboBox)item.FindControl("rcmbStateName");
                        RadNumericTextBox txtStartOdometer = (RadNumericTextBox)item.FindControl("txtStartOdometer");
                        RadNumericTextBox txtEndOdometer = (RadNumericTextBox)item.FindControl("txtEndOdometer");

                        sdsStateTravelled.UpdateParameters["TravelledID"].DefaultValue = travelledID;
                        sdsStateTravelled.UpdateParameters["StateID"].DefaultValue = rcmbStateName.SelectedValue.ToString();

                        if (txtStartOdometer.Value.HasValue)
                        {
                            sdsStateTravelled.UpdateParameters["StartOdometer"].DefaultValue = txtStartOdometer.Value.Value.ToString();
                        }
                        else
                        {
                            sdsStateTravelled.UpdateParameters["StartOdometer"].DefaultValue = "0";
                        }

                        if (txtEndOdometer.Value.HasValue)
                        {
                            sdsStateTravelled.UpdateParameters["EndOdometer"].DefaultValue = txtEndOdometer.Value.Value.ToString();
                        }
                        else
                        {
                            sdsStateTravelled.UpdateParameters["EndOdometer"].DefaultValue = "0";
                        }
                        sdsStateTravelled.UpdateParameters["UserName"].DefaultValue = user.UserName;
                        int result = sdsStateTravelled.Update();
                        //DisplayMessage(rgStateTravelled, true, WebHelper.GetUpdateSuccess());
                    }
                }
            }
            catch (Exception ex)
            {
                //DisplayMessage(rgStateTravelled, false, WebHelper.GetUpdateFail() + ". Reason: " + ex.Message);
                e.Canceled = true;
            }
        }
    }

    #endregion

    #region Trip - Incidents

    protected void rgTripIncidents_ItemDataBound(object sender, GridItemEventArgs e)
    {
        try
        {
            if (e.Item is GridEditFormInsertItem)
            {
                GridEditFormInsertItem insertForm = (GridEditFormInsertItem)e.Item;
                RadDatePicker rdtpIncidentDate = (RadDatePicker)insertForm.FindControl("rdtpIncidentDate");
                rdtpIncidentDate.SelectedDate = DateTime.Now;
            }
        }
        catch (Exception ae) { }
    }

    protected void imgActiveTripIncident_Click(object sender, EventArgs e)
    {
        MembershipUser user = Membership.GetUser();
        if (user != null)
        {
            string id = ((ImageButton)sender).CommandArgument.ToString();
            sdsSoftDeleteTripIncident.UpdateParameters["IncidentID"].DefaultValue = id;
            sdsSoftDeleteTripIncident.UpdateParameters["UserName"].DefaultValue = user.UserName;
            sdsSoftDeleteTripIncident.Update();
            BindInnerGrid("rgTripIncidents");
        }
    }

    protected void TripIncidents_ItemDeleted(object source, GridDeletedEventArgs e)
    {
        //RadGrid rgTripIncidents = (RadGrid)rgSearch.EditItems[0].FindControl("rgTripIncidents");
        String id = e.Item.GetDataKeyValue("IncidentID").ToString();
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            //DisplayMessage(rgTripIncidents, false, "Incident " + id + " cannot be deleted. Reason: " + e.Exception.Message);
        }
        //else
        //{
        //    if (e.AffectedRows > 0)
        //    {
        //        //DisplayMessage(rgTripIncidents, true, "Incident " + id + " deleted.");
        //    }
        //    else
        //    {
        //        //DisplayMessage(rgTripIncidents, false, "Incident " + id + " cannot be deleted. Reason: It is in active state");
        //    }
        //}
    }

    protected void TripIncidents_InsertCommand(object source, GridCommandEventArgs e)
    {
        MembershipUser user = Membership.GetUser();
        if (user != null)
        {
            //RadGrid rgStateTravelled = (RadGrid)rgSearch.EditItems[0].FindControl("rgStateTravelled");
            try
            {
                if (e.CommandName == "PerformInsert")
                {
                    if (e.Item is GridEditFormItem)
                    {
                        //Get the GridEditableItem of the RadGrid    
                        GridEditFormItem item = (GridEditFormItem)e.Item;

                        //Access the textbox from the edit form template
                        RadDatePicker rdtpIncidentDate = (RadDatePicker)item.FindControl("rdtpIncidentDate");
                        RadComboBox rcmbIncidentTypes = (RadComboBox)item.FindControl("rcmbIncidentTypes");
                        RadComboBox rcmbStateName = (RadComboBox)item.FindControl("rcmbStateName");
                        RadEditor reDescription = (RadEditor)item.FindControl("reDescription");

                        sdsTripIncidents.InsertParameters["TripID"].DefaultValue = hfTripID.Value;

                        if (rdtpIncidentDate.SelectedDate.HasValue)
                        {
                            sdsTripIncidents.InsertParameters["IncidentDate"].DefaultValue = rdtpIncidentDate.SelectedDate.Value.ToShortDateString();
                        }
                        else
                        {
                            sdsTripIncidents.InsertParameters["IncidentDate"].DefaultValue = DBNull.Value.ToString();
                        }
                        sdsTripIncidents.InsertParameters["IncidentTypeID"].DefaultValue = rcmbIncidentTypes.SelectedValue.ToString();
                        sdsTripIncidents.InsertParameters["StateID"].DefaultValue = rcmbStateName.SelectedValue.ToString();
                        sdsTripIncidents.InsertParameters["Remarks"].DefaultValue = reDescription.Content;
                        sdsTripIncidents.InsertParameters["UserName"].DefaultValue = user.UserName;
                        int result = sdsTripIncidents.Insert();
                        //DisplayMessage(rgStateTravelled, true, WebHelper.GetSaveSuccess());
                    }
                }
            }
            catch (Exception ex)
            {
                //DisplayMessage(rgStateTravelled, false, WebHelper.GetSaveFail() + ". Reason: " + ex.Message);
                e.Canceled = true;
            }
        }
    }

    protected void TripIncidents_UpdateCommand(object source, GridCommandEventArgs e)
    {
        MembershipUser user = Membership.GetUser();
        if (user != null)
        {
            //RadGrid rgStateTravelled = (RadGrid)rgSearch.EditItems[0].FindControl("rgStateTravelled");
            try
            {
                if (e.CommandName == RadGrid.UpdateCommandName)
                {
                    if (e.Item is GridEditFormItem)
                    {
                        //Get the GridEditableItem of the RadGrid    
                        GridEditFormItem item = (GridEditFormItem)e.Item;

                        //Get the primary key value using the DataKeyValue.    
                        string incidentID = item.GetDataKeyValue("IncidentID").ToString();
                        //Access the textbox from the edit form template
                        RadDatePicker rdtpIncidentDate = (RadDatePicker)item.FindControl("rdtpIncidentDate");
                        RadComboBox rcmbIncidentTypes = (RadComboBox)item.FindControl("rcmbIncidentTypes");
                        RadComboBox rcmbStateName = (RadComboBox)item.FindControl("rcmbStateName");
                        RadEditor reDescription = (RadEditor)item.FindControl("reDescription");

                        sdsTripIncidents.UpdateParameters["IncidentID"].DefaultValue = incidentID;
                        if (rdtpIncidentDate.SelectedDate.HasValue)
                        {
                            sdsTripIncidents.UpdateParameters["IncidentDate"].DefaultValue = rdtpIncidentDate.SelectedDate.Value.ToShortDateString();
                        }
                        else
                        {
                            sdsTripIncidents.UpdateParameters["IncidentDate"].DefaultValue = DBNull.Value.ToString();
                        }
                        sdsTripIncidents.UpdateParameters["IncidentTypeID"].DefaultValue = rcmbIncidentTypes.SelectedValue.ToString();
                        sdsTripIncidents.UpdateParameters["StateID"].DefaultValue = rcmbStateName.SelectedValue.ToString();
                        sdsTripIncidents.UpdateParameters["Remarks"].DefaultValue = reDescription.Content;
                        sdsTripIncidents.UpdateParameters["UserName"].DefaultValue = user.UserName;
                        int result = sdsStateTravelled.Update();
                        //DisplayMessage(rgStateTravelled, true, WebHelper.GetUpdateSuccess());
                    }
                }
            }
            catch (Exception ex)
            {
                //DisplayMessage(rgStateTravelled, false, WebHelper.GetUpdateFail() + ". Reason: " + ex.Message);
                e.Canceled = true;
            }
        }
    }

    #endregion

    #region Trip - Driver Expenses

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
        catch (Exception ae) { }
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
            BindInnerGrid("rgDriverExpense");
        }
    }

    protected void rgDriverExpenses_ItemDeleted(object source, GridDeletedEventArgs e)
    {
        //RadGrid rgTripIncidents = (RadGrid)rgSearch.EditItems[0].FindControl("rgTripIncidents");
        String id = e.Item.GetDataKeyValue("ExpenseID").ToString();
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            //DisplayMessage(rgTripIncidents, false, "Incident " + id + " cannot be deleted. Reason: " + e.Exception.Message);
        }
        //else
        //{
        //    if (e.AffectedRows > 0)
        //    {
        //        //DisplayMessage(rgTripIncidents, true, "Incident " + id + " deleted.");
        //    }
        //    else
        //    {
        //        //DisplayMessage(rgTripIncidents, false, "Incident " + id + " cannot be deleted. Reason: It is in active state");
        //    }
        //}
    }

    protected void rgDriverExpenses_InsertCommand(object source, GridCommandEventArgs e)
    {
        MembershipUser user = Membership.GetUser();
        if (user != null)
        {
            //RadGrid rgStateTravelled = (RadGrid)rgSearch.EditItems[0].FindControl("rgStateTravelled");
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
                        RadNumericTextBox txtTotalAmount = (RadNumericTextBox)item.FindControl("txtTotalAmount");
                        TextBox txtNotes = (TextBox)item.FindControl("txtNotes");

                        sdsDriverExpenses.InsertParameters["Notes"].DefaultValue = txtNotes.Text;
                        sdsDriverExpenses.InsertParameters["TripID"].DefaultValue = hfTripID.Value;
                        sdsDriverExpenses.InsertParameters["DriverID"].DefaultValue = "0";

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
                        //DisplayMessage(rgStateTravelled, true, WebHelper.GetSaveSuccess());
                    }
                }
            }
            catch (Exception ex)
            {
                //DisplayMessage(rgStateTravelled, false, WebHelper.GetSaveFail() + ". Reason: " + ex.Message);
                e.Canceled = true;
            }
        }
    }

    protected void rgDriverExpenses_UpdateCommand(object source, GridCommandEventArgs e)
    {
        MembershipUser user = Membership.GetUser();
        if (user != null)
        {
            //RadGrid rgStateTravelled = (RadGrid)rgSearch.EditItems[0].FindControl("rgStateTravelled");
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
                        RadNumericTextBox txtTotalAmount = (RadNumericTextBox)item.FindControl("txtTotalAmount");
                        TextBox txtNotes = (TextBox)item.FindControl("txtNotes");

                        sdsDriverExpenses.UpdateParameters["Notes"].DefaultValue = txtNotes.Text;
                        sdsDriverExpenses.UpdateParameters["ExpenseID"].DefaultValue = expenseID;
                        sdsDriverExpenses.UpdateParameters["DriverID"].DefaultValue = "0";

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
                        //DisplayMessage(rgStateTravelled, true, WebHelper.GetUpdateSuccess());
                    }
                }
            }
            catch (Exception ex)
            {
                //DisplayMessage(rgStateTravelled, false, WebHelper.GetUpdateFail() + ". Reason: " + ex.Message);
                e.Canceled = true;
            }
        }
    }

    #endregion

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

    #region Trip - Pictures

    protected void rgTripPictures_InsertCommand(object sender, GridCommandEventArgs e)
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
                        //LinkButton OpenImageGalleryLink = ((RadGrid)sender).Parent.FindControl("OpenImageGalleryLink") as LinkButton;
                        //OpenImageGalleryLink.Text = "View Image Gallery";
                        RadImageGallery RadImageGallery1 = ((RadGrid)sender).Parent.FindControl("RadImageGallery1") as RadImageGallery;
                        //RadImageGallery1.Visible = false; 
                        RadImageGallery1.Rebind();
                        RadAsyncUpload AsyncUpload1 = (RadAsyncUpload)item.FindControl("AsyncUpload1");
                        AsyncUpload1.TargetFolder = ConfigurationManager.AppSettings["ImagePathFolder"];
                        RadDatePicker rdtpImageDate = (RadDatePicker)item.FindControl("rdtpImageDate");
                        RadTextBox txbDescription = (RadTextBox)item.FindControl("txbDescription");
                        Label ErrorLabel = (Label)item.FindControl("ErrorLabel");
                        int result = 0;
                        if (AsyncUpload1.UploadedFiles.Count > 0)
                        {
                            try
                            {
                                string fileName = Convert.ToString(ViewState["fileName"]);
                                sdsTripPictures.InsertParameters.Add("TripID", DbType.Int32, hfTripID.Value);
                                sdsTripPictures.InsertParameters.Add("ImagePath", DbType.String, fileName);
                                sdsTripPictures.InsertParameters.Add("ImageTitle", DbType.String, (txbDescription.Text == string.Empty) ? DBNull.Value.ToString() : txbDescription.Text);
                                sdsTripPictures.InsertParameters.Add("UserName", DbType.String, user.UserName);
                                sdsTripPictures.InsertParameters.Add("ImageDate", DbType.Date, rdtpImageDate.SelectedDate.Value.ToShortDateString());
                                result = sdsTripPictures.Insert();
                            }
                            catch (Exception ex)
                            {

                            }
                            finally
                            {

                            }
                        }
                        else
                        {
                            ErrorLabel.Text = "Error";
                        }
                       
                        
                      
                    }
                    
                }
               
            }
            catch (Exception ex)
            {
                e.Canceled = true;
            }
        }
    }
    protected void rgTripPictures_UpdateCommand(object sender, GridCommandEventArgs e)
    {
        MembershipUser user = Membership.GetUser();
        if (user != null)
        {
            try
            {
                if (e.CommandName == "Update")
                {
                    if (e.Item is GridEditFormItem)
                    {
                        //Get the GridEditableItem of the RadGrid    
                        GridEditFormItem item = (GridEditFormItem)e.Item;
                        RadImageGallery RadImageGallery1 = ((RadGrid)sender).Parent.FindControl("RadImageGallery1") as RadImageGallery;
                        //RadImageGallery1.Visible = false; 
                        RadImageGallery1.Rebind();
                        RadDatePicker rdtpImageDate = (RadDatePicker)item.FindControl("rdtpImageDate");
                        RadTextBox txbDescription = (RadTextBox)item.FindControl("txbDescription");
                        string tripImageID = item.GetDataKeyValue("TripImageID").ToString();
                        int result = 0;

                        try
                        {
                            sdsTripPictures.UpdateParameters.Add("ImageTitle", DbType.String, (txbDescription.Text == string.Empty) ? DBNull.Value.ToString() : txbDescription.Text);
                            sdsTripPictures.UpdateParameters.Add("UserName", DbType.String, user.UserName);
                            sdsTripPictures.UpdateParameters.Add("TripImageID", DbType.Int32, tripImageID);
                            sdsTripPictures.UpdateParameters.Add("ImageDate", DbType.Date, rdtpImageDate.SelectedDate.Value.ToShortDateString());
                            result = sdsTripPictures.Update();
                        }
                        catch (Exception ex)
                        {

                        }
                        finally
                        {

                        }
                    }
                    else
                    {
                        DisplayMessage(rgSearch, false, ConfigurationManager.AppSettings["SaveFail"]);
                    }
                }
            }

            catch (Exception ex)
            {
                e.Canceled = true;
            }

        }
    }



    protected void rgTripPictures_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {
            GridDataItem edititem = (GridDataItem)e.Item;
            HiddenField hfTripImagePath = (HiddenField)edititem.FindControl("hfTripImagePath");
            RadBinaryImage RadBinaryImage1 = (RadBinaryImage)edititem.FindControl("RadBinaryImage1");
            HiddenField hfTripImageID = (HiddenField)edititem.FindControl("hfTripImageID");

            byte[] imageData = null;
            FileInfo fileInfo = new FileInfo(Server.MapPath(hfTripImagePath.Value));
            long imageFileLength = fileInfo.Length;
            FileStream fs = new FileStream(Server.MapPath(hfTripImagePath.Value), FileMode.Open, FileAccess.Read);
            BinaryReader br = new BinaryReader(fs);
            imageData = br.ReadBytes((int)imageFileLength);

            RadBinaryImage1.DataValue = imageData;
        }
        if (e.Item is GridEditFormItem && e.Item.IsInEditMode && !(e.Item is GridEditFormInsertItem))
        {
            ((GridEditableItem)e.Item)["Picture"].Parent.Visible = false;
            //RadAsyncUpload upload = ((GridEditableItem)e.Item)["Picture"].FindControl("AsyncUpload1") as RadAsyncUpload;
            //upload.Enabled = false;
        }
    }
    protected void rgTripPictures_ItemCommand(object sender, GridCommandEventArgs e)
    {

    }
    protected void rgTripPictures_ItemCreated(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            GridEditableItem editableItem = e.Item as GridEditableItem;
            RadAsyncUpload RadAsyncUpload1 = editableItem.FindControl("AsyncUpload1") as RadAsyncUpload;
            HiddenField1.Value = RadAsyncUpload1.ClientID;//to get the upload id
            CustomValidator CustomValidator1 = (CustomValidator)editableItem.FindControl("CustomValidator");
            HiddenField2.Value = CustomValidator1.ClientID;//to get the validator id
        }
    }
    protected void AsyncUpload1_FileUploaded(object sender, FileUploadedEventArgs e)
    {
        string controlId = string.Empty;
        string fileName = string.Empty;
        foreach (string ctl in Page.Request.Form)
        {
            if (ctl.EndsWith(".x") || ctl.EndsWith(".y"))
            {
                controlId = ctl.Substring(0, ctl.Length - 2);
            }
        }
        if (controlId.Contains("PerformInsert"))
        {
            if (((RadAsyncUpload)sender).UploadedFiles.Count > 0)
            {
                fileName =  hfTripID.Value + "_" + Convert.ToString(DateTime.Now.Day) + "_"
                    + Convert.ToString(DateTime.Now.Month) + "_" + Convert.ToString(DateTime.Now.Year) + "_" + Convert.ToString(DateTime.Now.Hour) + "_" +
                   Convert.ToString(DateTime.Now.Minute) + "_" + Convert.ToString(DateTime.Now.Second) + "_" + ((RadAsyncUpload)sender).UploadedFiles[0].FileName;
                e.File.SaveAs(Server.MapPath(ConfigurationManager.AppSettings["ImagePathFolder"]) + fileName);
                ViewState["fileName"] = ConfigurationManager.AppSettings["ImagePathFolder"] + fileName;
            }

        }
    }

    protected void imgTripPicturesActive_Click(object sender, ImageClickEventArgs e)
    {
        MembershipUser user = Membership.GetUser();
        if (user != null)
        {
            ImageButton imgTripPicturesActive = (ImageButton)sender;
            RadImageGallery RadImageGallery1 = imgTripPicturesActive.Parent.Parent.Parent.Parent.Parent.Parent.FindControl("RadImageGallery1") as RadImageGallery;
            RadImageGallery1.Rebind();
            string id = imgTripPicturesActive.CommandArgument.ToString();
            sdsSoftDeleteTripPictures.UpdateParameters["TripImageID"].DefaultValue = id;
            sdsSoftDeleteTripPictures.UpdateParameters["UserName"].DefaultValue = user.UserName;
            sdsSoftDeleteTripPictures.Update();
            BindInnerGrid("rgTripPictures");
        }
    }
    #endregion


    protected void rcmbDriver_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        RadComboBox rcmbDriver = (RadComboBox)sender;
        GridEditFormItem editItem = (GridEditFormItem)rcmbDriver.NamingContainer;
        RadComboBox rcmbLocation = (RadComboBox)editItem.FindControl("rcmbLocation");

        if (rcmbDriver.SelectedValue != "Select")
        {
            sdsGetDefaultLocation.SelectParameters["DriverID"].DefaultValue = rcmbDriver.SelectedValue;
            rcmbLocation.SelectedValue = ((DataView)sdsGetDefaultLocation.Select(DataSourceSelectArguments.Empty)).Table.Rows[0]["LocationID"].ToString();
        }
        else
        {
            rcmbLocation.SelectedValue = "Select";
        }
    }
    protected void OpenImageGalleryLink_Click(object sender, EventArgs e)
    {
        LinkButton OpenImageGalleryLink = (LinkButton)sender;
        GridEditFormItem editItem = (GridEditFormItem)OpenImageGalleryLink.NamingContainer;

        RadImageGallery RadImageGallery1 = (RadImageGallery)editItem.FindControl("RadImageGallery1");
       
        if (RadImageGallery1.Visible == false)
        {
            RadImageGallery1.LightBox.Modal = true;
            RadImageGallery1.LightBox.Width = Unit.Pixel(1000);
            RadImageGallery1.LightBox.Height = Unit.Pixel(800);
            RadImageGallery1.Rebind();
            RadImageGallery1.Visible = true;
            OpenImageGalleryLink.Text = "Hide Image Gallery";
        }
        else
        {
            OpenImageGalleryLink.Text = "View Image Gallery";
            RadImageGallery1.Visible = false;
        }
    }
    protected void RadImageGallery1_NeedDataSource(object sender, ImageGalleryNeedDataSourceEventArgs e)
    {
        string query = "SELECT ImagePath FROM [TripImages] where TripID = " + hfTripID.Value + "AND isActive = 1";

        string connectionString = SQLHelper.GetConnectionString;

        SqlConnection conn = new SqlConnection(connectionString);
        SqlDataAdapter adapter = new SqlDataAdapter();
        adapter.SelectCommand = new SqlCommand(query, conn);

        DataTable myDataTable = new DataTable();

        conn.Open();
        try
        {
            adapter.Fill(myDataTable);
        }
        finally
        {
            conn.Close();
        }

        DataView dataView = new DataView(myDataTable);

        ((RadImageGallery)sender).DataSource = dataView;
    }
}