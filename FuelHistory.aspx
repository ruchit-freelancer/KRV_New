<%@ Page Language="C#" MasterPageFile="~/KRV.master" AutoEventWireup="true" CodeFile="FuelHistory.aspx.cs"
    Inherits="FuelHistory" %>

<asp:Content ID="Content3" ContentPlaceHolderID="cphHeadTitle" runat="Server">
    Fuel History
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphContent" runat="Server">
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
            <MasterTableView DataSourceID="sdsAddEditRecords" DataKeyNames="FuelID" CommandItemDisplay="Top">
                <EditFormSettings EditFormType="Template">
                    <FormTemplate>
                        <h1>Fuel Details</h1>
                        <hr />
                        <asp:Panel ID="Panel1" runat="server" DefaultButton="imgUpdate">
                            <table cellpadding="2" cellspacing="2">
                                <tr>
                                    <td align="left" valign="middle">Select Truck:
                                    </td>
                                    <td align="left" valign="middle">
                                        <telerik:RadComboBox ID="rcmbTrucks" runat="server" DataSourceID="sdsTrucks" DataTextField="TruckNo"
                                            DataValueField="TruckID" MarkFirstMatch="true" SelectedValue='<%# Eval("TruckID") %>'>
                                        </telerik:RadComboBox>
                                    </td>
                                    <td><b>Fuel</b></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td align="left" valign="middle">Select Driver:
                                    </td>
                                    <td align="left" valign="middle">
                                        <telerik:RadComboBox ID="rcmbDriver" runat="server" DataSourceID="sdsDrivers" DataTextField="DriverName"
                                            DataValueField="DriverID" MarkFirstMatch="true" SelectedValue='<%# Eval("DriverID") %>'
                                            Width="250px">
                                        </telerik:RadComboBox>
                                    </td>
                                    <td align="left" valign="middle">Unit Price:
                                    </td>
                                    <td align="left" valign="middle">
                                        <telerik:RadNumericTextBox ID="txtUnitPrice" runat="server" Type="Number" InvalidStyleDuration="100"
                                            Text='<%# Eval("UnitPrice") %>'>
                                            <NumberFormat AllowRounding="True" KeepNotRoundedValue="False" />
                                        </telerik:RadNumericTextBox>
                                        <span style="color: Red;"><small>*</small></span>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtUnitPrice"
                                            SetFocusOnError="true" Display="None" ErrorMessage="Enter Unit Price"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="middle">Fueling Date:
                                    </td>
                                    <td align="left" valign="middle">
                                        <telerik:RadDatePicker ID="rdtpFuelingDate" runat="server" TabIndex="3" Culture="English (United States)"
                                            Skin="Sunset" DbSelectedDate='<%# Bind("FuelingDate") %>'>
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
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="rdtpFuelingDate"
                                            SetFocusOnError="true" Display="None" ErrorMessage="Enter Fueling Date"></asp:RequiredFieldValidator>
                                    </td>
                                    <td align="left" valign="middle">Gallons:
                                    </td>
                                    <td align="left" valign="middle">
                                        <telerik:RadNumericTextBox ID="txtGallons" runat="server" Type="Number" InvalidStyleDuration="100"
                                            Text='<%# Eval("Gallons") %>'>
                                            <NumberFormat AllowRounding="True" KeepNotRoundedValue="False" />
                                        </telerik:RadNumericTextBox>
                                    </td>

                                </tr>
                                <tr>
                                    <td align="left" valign="middle">Vendor Name:
                                    </td>
                                    <td align="left" valign="middle">
                                        <asp:TextBox ID="txtVendorName" runat="server" Text='<%# Bind("FuelVendor") %>' Width="250px" />
                                        <span style="color: Red;"><small>*</small></span>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtVendorName"
                                            SetFocusOnError="true" Display="None" ErrorMessage="Enter Vendor Name"></asp:RequiredFieldValidator>
                                    </td>
                                    <td align="left" valign="middle">Total Cost:
                                    </td>
                                    <td align="left" valign="middle">
                                        <telerik:RadNumericTextBox ID="txtTotalCost" runat="server" Type="Number" InvalidStyleDuration="100"
                                            Text='<%# Eval("TotalCost") %>'>
                                            <NumberFormat AllowRounding="True" KeepNotRoundedValue="False" />
                                        </telerik:RadNumericTextBox>
                                        <span style="color: Red;"><small>*</small></span>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtTotalCost"
                                            SetFocusOnError="true" Display="None" ErrorMessage="Enter Total Cost"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="middle">State Name:
                                    </td>
                                    <td align="left" valign="middle">
                                        <telerik:RadComboBox ID="rcmbStateName" runat="server" DataSourceID="sdsStateName"
                                            DataTextField="StateName" DataValueField="StateID" MarkFirstMatch="true" SelectedValue='<%# Eval("StateID") %>'
                                            AppendDataBoundItems="true">
                                            <Items>
                                                <telerik:RadComboBoxItem Text="Select" Value="Select" />
                                            </Items>
                                        </telerik:RadComboBox>
                                        <span style="color: Red;"><small>*</small></span>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="rcmbStateName"
                                            InitialValue="Select" SetFocusOnError="true" Display="None" ErrorMessage="Select State"></asp:RequiredFieldValidator>
                                    </td>
                                    <td><b>DEF</b></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td></td>
                                    <td align="left" valign="middle">DEF Unit Price:
                                    </td>
                                    <td align="left" valign="middle">
                                        <telerik:RadNumericTextBox ID="txtDEFUnitPrice" runat="server" Type="Number" InvalidStyleDuration="100"
                                            Text='<%# Eval("DEFUnitPrice") %>'>
                                            <NumberFormat AllowRounding="True" KeepNotRoundedValue="False" />
                                        </telerik:RadNumericTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td></td>
                                    <td align="left" valign="middle">DEF Gallons:
                                    </td>
                                    <td align="left" valign="middle">
                                        <telerik:RadNumericTextBox ID="txtDEFGallons" runat="server" Type="Number" InvalidStyleDuration="100"
                                            Text='<%# Eval("DEFGallons") %>'>
                                            <NumberFormat AllowRounding="True" KeepNotRoundedValue="False" />
                                        </telerik:RadNumericTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td></td>
                                    <td align="left" valign="middle">DEF Total Cost:
                                    </td>
                                    <td align="left" valign="middle">
                                        <telerik:RadNumericTextBox ID="txtDEFTotalCost" runat="server" Type="Number" InvalidStyleDuration="100"
                                            Text='<%# Eval("TotalDEF") %>'>
                                            <NumberFormat AllowRounding="True" KeepNotRoundedValue="False" />
                                        </telerik:RadNumericTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="middle" colspan="2">
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
                    <telerik:GridBoundColumn DataField="TruckNo" FilterControlAltText="Filter TruckNo column"
                        HeaderText="TruckNo" SortExpression="TruckNo" UniqueName="TruckNo" FilterControlWidth="70px"
                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" HeaderStyle-Width="70px">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="DriverName" FilterControlAltText="Filter DriverName column"
                        HeaderText="Driver Name" SortExpression="DriverName" UniqueName="DriverName"
                        FilterControlWidth="100px" HeaderStyle-Width="100px" AutoPostBackOnFilter="true"
                        CurrentFilterFunction="Contains">
                    </telerik:GridBoundColumn>
                    <telerik:GridDateTimeColumn DataField="FuelingDate" HeaderText="Date" SortExpression="FuelingDate"
                        UniqueName="FuelingDate" FilterControlWidth="60px" HeaderStyle-Width="60px"
                        AllowFiltering="true" DataType="System.DateTime" FilterListOptions="VaryByDataType"
                        AutoPostBackOnFilter="true" CurrentFilterFunction="EqualTo" DataFormatString="{0:MM-dd-yyyy}">
                    </telerik:GridDateTimeColumn>
                    <telerik:GridBoundColumn DataField="FuelVendor" FilterControlAltText="Filter FuelVendor column"
                        HeaderText="Vendor" SortExpression="FuelVendor" UniqueName="FuelVendor" FilterControlWidth="100px"
                        HeaderStyle-Width="100px" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="StateName" FilterControlAltText="Filter StateName column"
                        HeaderText="StateName" SortExpression="StateName" UniqueName="StateName" FilterControlWidth="100px"
                        HeaderStyle-Width="100px" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="UnitPrice" FilterControlAltText="Filter UnitPrice column"
                        HeaderText="Unit Price" SortExpression="UnitPrice" UniqueName="UnitPrice" FilterControlWidth="70px"
                        HeaderStyle-Width="45px" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="TotalCost" FilterControlAltText="Filter TotalCost column"
                        HeaderText="Total Cost" SortExpression="TotalCost" UniqueName="TotalCost" FilterControlWidth="70px"
                        HeaderStyle-Width="45px" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="DEFUnitPrice" FilterControlAltText="Filter DEFUnitPrice column"
                        HeaderText="DEF Unit Price" SortExpression="DEFUnitPrice" UniqueName="DEFUnitPrice" FilterControlWidth="70px"
                        HeaderStyle-Width="45px" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="TotalDEF" FilterControlAltText="Filter TotalDEF column"
                        HeaderText="DEF Total" SortExpression="TotalDEF" UniqueName="TotalDEF" FilterControlWidth="70px"
                        HeaderStyle-Width="45px" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn AllowFiltering="false" HeaderText="Delete" HeaderStyle-Width="5px">
                        <ItemStyle HorizontalAlign="Center" />
                        <ItemTemplate>
                            <center>
                                <asp:ImageButton ToolTip='<%# ((Eval("IsActive").ToString()=="1")?"Yes":"No") %>'
                                    ID="imgActive" runat="server" CommandArgument='<%# Eval("FuelID") %>' ImageUrl='<%# "~/App_Themes/Blue/images/" + ((Eval("IsActive").ToString()=="1")?"icon_active.png":"icon_deactive.png") %>'
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
        UpdateCommand="KRV_UpdateFuelHistory" UpdateCommandType="StoredProcedure" DeleteCommand="KRV_DeleteFuelHistory"
        DeleteCommandType="StoredProcedure" InsertCommand="KRV_AddFuelHistory" InsertCommandType="StoredProcedure"
        SelectCommand="KRV_GetFuelHistory" SelectCommandType="StoredProcedure" CancelSelectOnNullParameter="False">
        <DeleteParameters>
            <asp:Parameter Name="FuelID" Type="Int32" DefaultValue="0" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="FuelID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="TruckID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="DriverID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="FuelingDate" Type="DateTime" ConvertEmptyStringToNull="true" />
            <asp:Parameter Name="FuelVendor" Type="String" />
            <asp:Parameter Name="StateID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="UnitPrice" Type="Decimal" DefaultValue="0" />
            <asp:Parameter Name="Gallons" Type="Decimal" DefaultValue="0" />
            <asp:Parameter Name="TotalCost" Type="Decimal" DefaultValue="0" />
            <asp:Parameter Name="UserName" Type="String" />
            <asp:Parameter Name="DEFUnitPrice" Type="Decimal" DefaultValue="0" />
            <asp:Parameter Name="DEFGallons" Type="Decimal" DefaultValue="0" />
            <asp:Parameter Name="TotalDEF" Type="Decimal" DefaultValue="0" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="TruckID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="DriverID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="FuelingDate" Type="DateTime" ConvertEmptyStringToNull="true" />
            <asp:Parameter Name="FuelVendor" Type="String" />
            <asp:Parameter Name="StateID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="UnitPrice" Type="Decimal" DefaultValue="0" />
            <asp:Parameter Name="Gallons" Type="Decimal" DefaultValue="0" />
            <asp:Parameter Name="TotalCost" Type="Decimal" DefaultValue="0" />
            <asp:Parameter Name="UserName" Type="String" />
            <asp:Parameter Name="DEFUnitPrice" Type="Decimal" DefaultValue="0" />
            <asp:Parameter Name="DEFGallons" Type="Decimal" DefaultValue="0" />
            <asp:Parameter Name="TotalDEF" Type="Decimal" DefaultValue="0" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsSoftDelete" runat="server" ConnectionString="<%$ ConnectionStrings:dbConnString %>"
        UpdateCommand="KRV_SoftDeleteFuelHistory" UpdateCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:Parameter Name="FuelID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="UserName" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsTrucks" runat="server" ConnectionString="<%$ ConnectionStrings:dbConnString %>"
        SelectCommand="SELECT TruckID,TruckNo FROM Trucks WHERE IsActive=1" SelectCommandType="Text"
        CancelSelectOnNullParameter="false"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsDrivers" runat="server" ConnectionString="<%$ ConnectionStrings:dbConnString %>"
        SelectCommand="SELECT DriverID,DriverName FROM Drivers WHERE IsActive=1" SelectCommandType="Text"
        CancelSelectOnNullParameter="false"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsStateName" runat="server" ConnectionString="<%$ ConnectionStrings:dbConnString %>"
        SelectCommand="SELECT StateID,StateName FROM StateList WHERE IsActive=1" SelectCommandType="Text"
        CancelSelectOnNullParameter="false"></asp:SqlDataSource>
</asp:Content>
