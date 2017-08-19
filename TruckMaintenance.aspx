<%@ Page Language="C#" MasterPageFile="~/KRV.master" AutoEventWireup="true" CodeFile="TruckMaintenance.aspx.cs"
    Inherits="TruckMaintenance" %>

<asp:Content ID="Content3" ContentPlaceHolderID="cphHeadTitle" runat="Server">
    Truck Maintenance
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphContent" runat="Server">
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function OnCommand(sender, eventArgs) {
                var grid = $find("<%=rgSearch.ClientID %>");
                //you can also use the sender argument keyword to reference the client grid object
                //alert(new Date().toUTCString());
                //log("ClientID of server-side grid object is: " + grid.get_element().id);
            }
        </script>
    </telerik:RadCodeBlock>
    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
        <telerik:RadGrid PageSize="20" ID="rgSearch" runat="server" AllowFilteringByColumn="True"
            AllowPaging="True" AllowAutomaticDeletes="true" AllowAutomaticInserts="false"
            AllowAutomaticUpdates="true" ShowStatusBar="true" AllowSorting="True" AutoGenerateColumns="False"
            CellSpacing="0" DataSourceID="sdsAddEditRecords" GridLines="None" Skin="Sunset"
            OnInsertCommand="RadGrid1_InsertCommand" OnUpdateCommand="RadGrid1_UpdateCommand"
            OnItemDeleted="RadGrid1_ItemDeleted" OnItemDataBound="RadGrid1_ItemDataBound">
            <GroupingSettings CaseSensitive="false" />
            <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Default">
            </HeaderContextMenu>
            <MasterTableView DataSourceID="sdsAddEditRecords" DataKeyNames="MaintenanceID" CommandItemDisplay="Top">
                <EditFormSettings EditFormType="Template">
                    <FormTemplate>
                        <h1>
                            Truck Maintenance Details</h1>
                        <hr />
                        <asp:Panel ID="Panel1" runat="server" DefaultButton="imgUpdate">
                            <table cellpadding="2" cellspacing="2">
                                <tr>
                                    <td align="left" valign="middle">
                                        Select Truck:
                                    </td>
                                    <td align="left" valign="middle">
                                        <telerik:RadComboBox ID="rcmbTrucks" runat="server" DataSourceID="sdsTrucks" DataTextField="TruckNo"
                                            DataValueField="TruckID" MarkFirstMatch="true" SelectedValue='<%# Eval("TruckID") %>'>
                                        </telerik:RadComboBox>
                                    </td>
                                    <td width="50px">
                                    </td>
                                    <td align="right" valign="middle">
                                        Odometer:
                                    </td>
                                    <td align="left" valign="middle">
                                        <telerik:RadNumericTextBox ID="txtOdometer" runat="server" Type="Number" InvalidStyleDuration="100"
                                            Text='<%# Eval("Odometer") %>'>
                                            <NumberFormat DecimalDigits="0" GroupSeparator="" />
                                        </telerik:RadNumericTextBox>

                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="middle">
                                        Maintenance Date:
                                    </td>
                                    <td align="left" valign="middle">
                                        <telerik:RadDatePicker ID="rdtpMaintenanceDate" runat="server" Culture="English (United States)"
                                            Skin="Sunset" DbSelectedDate='<%# Bind("MaintenanceDate") %>'>
                                            <Calendar ID="Calendar3" Skin="Sunset" runat="server" UseColumnHeadersAsSelectors="True"
                                                UseRowHeadersAsSelectors="True">
                                            </Calendar>
                                            <DateInput ID="DateInput3" InvalidStyleDuration="100" runat="server" LabelCssClass="radLabelCss_Sunset"
                                                Skin="Sunset" Width="" DateFormat="MM-dd-yyyy" DisplayDateFormat="MM-dd-yyyy"
                                                Font-Bold="true" ForeColor="Black">
                                            </DateInput>
                                            <DatePopupButton CssClass="" />
                                        </telerik:RadDatePicker>
                                        <span style="color: Red;"><small>*</small></span>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="rdtpMaintenanceDate"
                                            SetFocusOnError="true" Display="None" ErrorMessage="Enter Maintenance Date"></asp:RequiredFieldValidator>
                                    </td>
                                    <td>
                                    </td>
                                    <td align="right" valign="middle">
                                        Days Out of Service:
                                    </td>
                                    <td align="left" valign="middle">
                                        <telerik:RadNumericTextBox ID="txtOutOfService" runat="server" Type="Number" InvalidStyleDuration="100"
                                            Text='<%# Eval("OutOfService") %>' MinValue="0" Value="0">
                                            <NumberFormat DecimalDigits="0" GroupSeparator="" />
                                        </telerik:RadNumericTextBox>
                                    </td>
                                    
                                </tr>
                                <tr>
                                    <td align="left" valign="middle">
                                        Maintenance Type:
                                    </td>
                                    <td align="left" valign="middle">
                                        <telerik:RadComboBox ID="rcmbMaintenanceTypes" runat="server" DataSourceID="sdsMaintenanceTypes"
                                            DataTextField="MaintenanceType" DataValueField="MaintenanceTypeID" MarkFirstMatch="true"
                                            SelectedValue='<%# Eval("MaintenanceTypeID") %>' Width="250px">
                                        </telerik:RadComboBox>
                                    </td>
                                    <td>
                                    </td>
                                    <td align="right" valign="top">
                                        Notes:
                                    </td>
                                    <td align="left" valign="middle" rowspan="3">
                                        <asp:TextBox ID="txtNotes" Width="250px" Height="70px" TextMode="MultiLine" runat="server"
                                            Text='<%# Bind("Notes") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="middle">
                                        Vendor Name:
                                    </td>
                                    <td align="left" valign="middle">
                                        <asp:TextBox ID="txtVendorName" Width="250px" runat="server" Text='<%# Bind("VendorName") %>' />
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="middle">
                                        Total Cost:
                                    </td>
                                    <td align="left" valign="middle">
                                        <telerik:RadNumericTextBox ID="txtTotalCost" runat="server" Type="Number" InvalidStyleDuration="100"
                                            Text='<%# Eval("TotalCost") %>'>
                                            <NumberFormat AllowRounding="True" KeepNotRoundedValue="False" />
                                        </telerik:RadNumericTextBox>
                                        <span style="color: Red;"><small>*</small></span>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtTotalCost"
                                            SetFocusOnError="true" Display="None" ErrorMessage="Enter Total Cost"></asp:RequiredFieldValidator>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="middle" colspan="5">
                                        <asp:ImageButton ID="imgUpdate" runat="server" CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>'
                                            AlternateText="Update" ToolTip="Update" ImageUrl="~/App_Themes/Blue/images/savebutton.gif" />
                                        <asp:ImageButton ID="imgCancel" runat="server" CommandName="Cancel" AlternateText="Cancel"
                                            ToolTip="Cancel" ImageUrl="~/App_Themes/Blue/images/cancelbutton.gif" CausesValidation="false" />
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </FormTemplate>
                </EditFormSettings>
                <HeaderStyle HorizontalAlign="Center" />
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton" EditImageUrl="~/App_Themes/Blue/images/edit.gif"
                        ItemStyle-Width="5px" HeaderText="Edit">
                        <ItemStyle HorizontalAlign="Center" />
                        <HeaderStyle Width="5px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridDateTimeColumn DataField="MaintenanceDate" HeaderText="Date" SortExpression="MaintenanceDate"
                        UniqueName="MaintenanceDate" FilterControlWidth="100px" HeaderStyle-Width="100px"
                        AllowFiltering="true" DataType="System.DateTime" FilterListOptions="VaryByDataType"
                        AutoPostBackOnFilter="true" CurrentFilterFunction="EqualTo" DataFormatString="{0:MM-dd-yyyy}">
                    </telerik:GridDateTimeColumn>
                    <telerik:GridBoundColumn DataField="TruckNo" FilterControlAltText="Filter TruckNo column"
                        HeaderText="TruckNo" SortExpression="TruckNo" UniqueName="TruckNo" FilterControlWidth="100px"
                        HeaderStyle-Width="100px" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MaintenanceType" FilterControlAltText="Filter MaintenanceType column"
                        HeaderText="Maintenance Type" SortExpression="MaintenanceType" UniqueName="MaintenanceType"
                        FilterControlWidth="150px" HeaderStyle-Width="150px" AutoPostBackOnFilter="true"
                        CurrentFilterFunction="Contains">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="VendorName" FilterControlAltText="Filter VendorName column"
                        HeaderText="Vendor" SortExpression="VendorName" UniqueName="VendorName" FilterControlWidth="150px"
                        HeaderStyle-Width="150px" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="TotalCost" FilterControlAltText="Filter TotalCost column"
                        HeaderText="Total Cost" SortExpression="TotalCost" UniqueName="TotalCost" FilterControlWidth="100px"
                        HeaderStyle-Width="100px" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains">
                        <ItemStyle HorizontalAlign="Right" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Odometer" FilterControlAltText="Filter Odometer column"
                        HeaderText="Odometer" SortExpression="Odometer" UniqueName="Odometer" FilterControlWidth="100px"
                        HeaderStyle-Width="100px" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains">
                        <ItemStyle HorizontalAlign="Right" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="OutOfService" AllowFiltering="false" HeaderText="Days Out of Service"
                        SortExpression="OutOfService" UniqueName="OutOfService" HeaderStyle-Width="50px">
                        <ItemStyle Width="50px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn AllowFiltering="false" HeaderText="Delete" HeaderStyle-Width="5px">
                        <ItemStyle HorizontalAlign="Center" />
                        <ItemTemplate>
                            <center>
                                <asp:ImageButton ToolTip='<%# ((Eval("IsActive").ToString()=="1")?"Yes":"No") %>'
                                    ID="imgActive" runat="server" CommandArgument='<%# Eval("MaintenanceID") %>'
                                    ImageUrl='<%# "~/App_Themes/Blue/images/" + ((Eval("IsActive").ToString()=="1")?"icon_active.png":"icon_deactive.png") %>'
                                    CausesValidation="false" OnClick="imgActive_Click" />
                            </center>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridButtonColumn ConfirmText="Are you sure want to purge this record?" ConfirmDialogType="RadWindow"
                        ConfirmTitle="Purge Record" ButtonType="ImageButton" CommandName="Delete" Text="Purge"
                        UniqueName="DeleteColumn" HeaderText="Purge" Visible="false">
                        <ItemStyle HorizontalAlign="Center" Width="5px" />
                        <HeaderStyle Width="5px" />
                    </telerik:GridButtonColumn>
                </Columns>
            </MasterTableView>
            <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
            <ClientSettings>
                <ClientEvents OnCommand="OnCommand" />
                <Selecting AllowRowSelect="True" />
            </ClientSettings>
            <FilterMenu EnableImageSprites="False">
            </FilterMenu>
        </telerik:RadGrid>
    </telerik:RadAjaxPanel>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Height="75px"
        Width="75px" Transparency="1">
    </telerik:RadAjaxLoadingPanel>
    <asp:SqlDataSource ID="sdsAddEditRecords" runat="server" ConnectionString="<%$ ConnectionStrings:dbConnString %>"
        UpdateCommand="KRV_UpdateTruckMaintenance" UpdateCommandType="StoredProcedure"
        DeleteCommand="KRV_DeleteTruckMaintenance" DeleteCommandType="StoredProcedure"
        InsertCommand="KRV_AddTruckMaintenance" InsertCommandType="StoredProcedure" SelectCommand="KRV_GetTruckMaintenance"
        SelectCommandType="StoredProcedure" CancelSelectOnNullParameter="False">
        <DeleteParameters>
            <asp:Parameter Name="MaintenanceID" Type="Int32" DefaultValue="0" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="MaintenanceID" Type="Int32" />
            <asp:Parameter Name="TruckID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="MaintenanceTypeID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="MaintenanceDate" Type="DateTime" ConvertEmptyStringToNull="true" />
            <asp:Parameter Name="VendorName" Type="String" />
            <asp:Parameter Name="Notes" Type="String" />
            <asp:Parameter Name="TotalCost" Type="Decimal" DefaultValue="0" />
            <asp:Parameter Name="UserName" Type="String" />
            <asp:Parameter Name="OutOfService" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="Odometer" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="TruckID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="MaintenanceTypeID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="MaintenanceDate" Type="DateTime" ConvertEmptyStringToNull="true" />
            <asp:Parameter Name="VendorName" Type="String" />
            <asp:Parameter Name="Notes" Type="String" />
            <asp:Parameter Name="TotalCost" Type="Decimal" DefaultValue="0" />
            <asp:Parameter Name="UserName" Type="String" />
            <asp:Parameter Name="OutOfService" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="Odometer" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsSoftDelete" runat="server" ConnectionString="<%$ ConnectionStrings:dbConnString %>"
        UpdateCommand="KRV_SoftDeleteTruckMaintenance" UpdateCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:Parameter Name="MaintenanceID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="UserName" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsTrucks" runat="server" ConnectionString="<%$ ConnectionStrings:dbConnString %>"
        SelectCommand="SELECT TruckID,TruckNo FROM Trucks WHERE IsActive=1" SelectCommandType="Text"
        CancelSelectOnNullParameter="false"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsMaintenanceTypes" runat="server" ConnectionString="<%$ ConnectionStrings:dbConnString %>"
        SelectCommand="SELECT MaintenanceTypeID,MaintenanceType FROM MaintenanceTypes WHERE IsActive=1"
        SelectCommandType="Text" CancelSelectOnNullParameter="false"></asp:SqlDataSource>
</asp:Content>
