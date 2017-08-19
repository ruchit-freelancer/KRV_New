<%@ Page Language="C#" MasterPageFile="~/KRV.master" AutoEventWireup="true" CodeFile="Trucks.aspx.cs"
    Inherits="Masterpages_Trucks" %>

<asp:Content ID="Content3" ContentPlaceHolderID="cphHeadTitle" runat="Server">
    Truck Details
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphContent" runat="Server">
    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
        <telerik:RadGrid PageSize="20" ID="rgSearch" runat="server" AllowFilteringByColumn="True"
            AllowPaging="True" AllowAutomaticDeletes="true" AllowAutomaticInserts="false"
            AllowAutomaticUpdates="true" ShowStatusBar="true" AllowSorting="True" AutoGenerateColumns="False"
            CellSpacing="0" DataSourceID="sdsAddEditRecords" GridLines="None" Skin="Sunset"
            OnInsertCommand="RadGrid1_InsertCommand" OnUpdateCommand="RadGrid1_UpdateCommand"
            OnItemDeleted="RadGrid1_ItemDeleted">
            <GroupingSettings CaseSensitive="false" />
            <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Default">
            </HeaderContextMenu>
            <MasterTableView DataSourceID="sdsAddEditRecords" DataKeyNames="TruckID" CommandItemDisplay="Top">
                <EditFormSettings EditFormType="Template">
                    <FormTemplate>
                        <h1>Truck Details</h1>
                        <hr />
                        <asp:Panel ID="Panel1" runat="server" DefaultButton="imgUpdate">
                            <table cellpadding="2" cellspacing="2" width="60%">
                                <tr>
                                    <td align="left" valign="middle" width="150px">Select Location:
                                    </td>
                                    <td align="left" valign="middle">
                                        <telerik:RadComboBox ID="rcmbLocation" runat="server" DataSourceID="sdsLocations"
                                            DataTextField="LocationName" DataValueField="LocationID" MarkFirstMatch="true"
                                            SelectedValue='<%# Bind("LocationID") %>' TabIndex="1">
                                        </telerik:RadComboBox>
                                    </td>
                                    <td align="left" valign="middle">VIN #:
                                    </td>
                                    <td align="left" valign="middle">
                                        <asp:TextBox ID="txtVINNumber" runat="server" Text='<%# Bind("VINNumber") %>' TabIndex="2" />
                                    </td>

                                    <td align="left" valign="middle">Notes:
                                    </td>
                                    <td align="left" valign="top" rowspan="3">
                                        <asp:TextBox ID="txtNotes" runat="server" TextMode="MultiLine" Width="250px" Height="70px"
                                            TabIndex="9" Text='<%# Bind("Notes") %>'></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="middle">Truck No:
                                    </td>
                                    <td align="left" valign="middle">
                                        <asp:TextBox ID="txtTruckNo" runat="server" Text='<%# Bind("TruckNo") %>' TabIndex="3" />
                                        <span style="color: Red;"><small>*</small></span>                                    
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtTruckNo"
                                            SetFocusOnError="true" Display="None" ErrorMessage="Enter Truck No"></asp:RequiredFieldValidator>
                                    </td>

                                    <td align="left" valign="middle">Axles:
                                    </td>
                                    <td align="left" valign="middle">
                                       <telerik:RadNumericTextBox ID="txtAxles" runat="server" TabIndex="4" Type="Number"
                                            Text='<%# Eval("Axles") %>' InvalidStyleDuration="100">
                                            <NumberFormat DecimalDigits="0" GroupSeparator="" />
                                        </telerik:RadNumericTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="middle">Truck TagNo:
                                    </td>
                                    <td align="left" valign="middle">
                                        <asp:TextBox ID="txtTruckTagNo" runat="server" TabIndex="5" Text='<%# Bind("TruckTagNo") %>' />
                                    </td>
                                    <td align="left" valign="middle">IFTA Decal:
                                    </td>
                                    <td align="left" valign="middle">
                                        <telerik:RadNumericTextBox ID="txtIftaDecal" runat="server" TabIndex="6" Type="Number"
                                            Text='<%# Eval("IftaDecal") %>' InvalidStyleDuration="100">
                                            <NumberFormat DecimalDigits="0" GroupSeparator="" />
                                        </telerik:RadNumericTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="middle">Date of Purchase:
                                    </td>
                                    <td align="left" valign="middle">
                                        <telerik:RadDatePicker ID="rdtpDOP" runat="server" TabIndex="7" Culture="English (United States)"
                                            Skin="Sunset" DbSelectedDate='<%# Bind("DOP") %>' MinDate="01-01-1900">
                                            <Calendar ID="Calendar3" Skin="Sunset" runat="server" UseColumnHeadersAsSelectors="True"
                                                UseRowHeadersAsSelectors="True">
                                            </Calendar>
                                            <DateInput ID="DateInput3" InvalidStyleDuration="100" runat="server" LabelCssClass="radLabelCss_Sunset"
                                                Skin="Sunset" Width="" DateFormat="MM-dd-yyyy" DisplayDateFormat="MM-dd-yyyy"
                                                Font-Bold="true" ForeColor="Black">
                                            </DateInput>
                                            <DatePopupButton CssClass="" />
                                        </telerik:RadDatePicker>
                                    </td>
                                   <td align="left" valign="middle">
                                        Year:
                                    </td>
                                    <td align="left" valign="middle">
                                         <telerik:RadNumericTextBox ID="txtYear" runat="server" TabIndex="8" Type="Number"
                                            Text='<%# Eval("Year") %>' InvalidStyleDuration="100">
                                            <NumberFormat DecimalDigits="0" GroupSeparator="" />
                                        </telerik:RadNumericTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="middle" width="70px">Make:
                                    </td>
                                    <td align="left" valign="middle">
                                        <asp:TextBox ID="txtMake" runat="server" TabIndex="9" Text='<%# Bind("Make") %>' />
                                    </td>
                                    <td align="left" valign="middle">
                                        MT Weight:
                                    </td>
                                    <td align="left" valign="middle">
                                        <telerik:RadNumericTextBox ID="txtMTWeight" runat="server" TabIndex="10" Type="Number"
                                            Text='<%# Eval("MTWeight") %>' InvalidStyleDuration="100">
                                            <NumberFormat DecimalDigits="2" GroupSeparator="" />
                                        </telerik:RadNumericTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="middle">Model:
                                    </td>
                                    <td align="left" valign="middle">
                                        <asp:TextBox ID="txtModel" TabIndex="11" runat="server" Text='<%# Bind("Model") %>' />
                                    </td>
                                     <td align="left" valign="middle">
                                        Licensed Weight:
                                    </td>
                                    <td align="left" valign="middle">
                                        <telerik:RadNumericTextBox ID="txtLicensedWeight" runat="server" TabIndex="12" Type="Number"
                                            Text='<%# Eval("LicensedWeight") %>' InvalidStyleDuration="100">
                                            <NumberFormat DecimalDigits="2" GroupSeparator="" />
                                        </telerik:RadNumericTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="middle">Color:
                                    </td>
                                    <td align="left" valign="middle">
                                        <asp:TextBox ID="txtColor" runat="server" TabIndex="13" Text='<%# Bind("Color") %>' />
                                    </td>
                                    <td align="left" valign="middle">
                                        PM Milage:
                                    </td>
                                    <td align="left" valign="middle">
                                        <telerik:RadNumericTextBox ID="txtPMMilage" runat="server" TabIndex="14" Type="Number"
                                            Text='<%# Eval("PMMilage") %>' InvalidStyleDuration="100">
                                            <NumberFormat DecimalDigits="2" GroupSeparator="" />
                                        </telerik:RadNumericTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="middle">Slab Capacity:
                                    </td>
                                    <td align="left" valign="middle">
                                        <telerik:RadNumericTextBox ID="txtSlabCapacity" runat="server" TabIndex="15" Type="Number"
                                            Text='<%# Eval("SlabCapacity") %>' InvalidStyleDuration="100">
                                            <NumberFormat DecimalDigits="0" GroupSeparator="" />
                                        </telerik:RadNumericTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="middle" colspan="7">
                                        <asp:ImageButton ID="imgUpdate" runat="server" TabIndex="16" CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>'
                                            AlternateText="Update" ToolTip="Update" ImageUrl="~/App_Themes/Blue/images/savebutton.gif" />
                                        <asp:ImageButton ID="imgCancel" runat="server" TabIndex="17" CommandName="Cancel"
                                            AlternateText="Cancel" ToolTip="Cancel" ImageUrl="~/App_Themes/Blue/images/cancelbutton.gif"
                                            CausesValidation="false" />
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </FormTemplate>
                </EditFormSettings>
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton" EditImageUrl="../App_Themes/Blue/images/edit.gif"
                        ItemStyle-Width="5px" HeaderText="Edit">
                        <HeaderStyle Width="5px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridBoundColumn DataField="TruckNo" FilterControlAltText="Filter TruckNo column"
                        HeaderText="TruckNo" SortExpression="TruckNo" UniqueName="TruckNo" FilterControlWidth="50px"
                        HeaderStyle-Width="50px" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="LocationName" FilterControlAltText="Filter LocationName column"
                        HeaderText="LocationName" SortExpression="LocationName" UniqueName="LocationName"
                        FilterControlWidth="70px" HeaderStyle-Width="70px" AutoPostBackOnFilter="true"
                        CurrentFilterFunction="Contains">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="TruckTagNo" FilterControlAltText="Filter TruckTagNo column"
                        HeaderText="TagNo" SortExpression="TruckTagNo" UniqueName="TruckTagNo" FilterControlWidth="50px"
                        HeaderStyle-Width="50px" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Make" FilterControlAltText="Filter Make column"
                        HeaderText="Make" SortExpression="Make" UniqueName="Make" FilterControlWidth="70px"
                        HeaderStyle-Width="70px" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Model" FilterControlAltText="Filter Model column"
                        HeaderText="Model" SortExpression="Model" UniqueName="Model" FilterControlWidth="70px"
                        HeaderStyle-Width="70px" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Color" FilterControlAltText="Filter Color column"
                        HeaderText="Color" SortExpression="Color" UniqueName="Color" FilterControlWidth="50px"
                        HeaderStyle-Width="50px" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="DOPDisp" FilterControlAltText="Filter DOPDisp column"
                        HeaderText="Purchased On" SortExpression="DOPDisp" UniqueName="DOPDisp" FilterControlWidth="70px"
                        HeaderStyle-Width="70px" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SlabCapacity" HeaderText="Slab Capacity" SortExpression="SlabCapacity"
                        UniqueName="SlabCapacity" AllowFiltering="false" HeaderStyle-Width="100px">
                    </telerik:GridBoundColumn>
                     <telerik:GridBoundColumn DataField="VINNumber" HeaderText="VIN#" SortExpression="VINNumber"
                        UniqueName="VINNumber" AllowFiltering="false" HeaderStyle-Width="100px">
                    </telerik:GridBoundColumn>
                     <telerik:GridBoundColumn DataField="Axles" HeaderText="Axles" SortExpression="Axles"
                        UniqueName="Axles" AllowFiltering="false" HeaderStyle-Width="100px">
                    </telerik:GridBoundColumn>
                     <telerik:GridBoundColumn DataField="IftaDecal" HeaderText="IFTA Decal" SortExpression="IftaDecal"
                        UniqueName="IftaDecal" AllowFiltering="false" HeaderStyle-Width="100px">
                    </telerik:GridBoundColumn>
                     <telerik:GridBoundColumn DataField="Year" HeaderText="Year" SortExpression="Year"
                        UniqueName="Year" AllowFiltering="false" HeaderStyle-Width="100px">
                    </telerik:GridBoundColumn>
                     <telerik:GridBoundColumn DataField="MTWeight" HeaderText="MT Weight" SortExpression="MTWeight"
                        UniqueName="MTWeight" AllowFiltering="false" HeaderStyle-Width="100px">
                    </telerik:GridBoundColumn>
                     <telerik:GridBoundColumn DataField="LicensedWeight" HeaderText="Licensed Weight" SortExpression="LicensedWeight"
                        UniqueName="LicensedWeight" AllowFiltering="false" HeaderStyle-Width="100px">
                    </telerik:GridBoundColumn>
                     <telerik:GridBoundColumn DataField="PMMilage" HeaderText="PM Milage" SortExpression="PMMilage"
                        UniqueName="PMMilage" AllowFiltering="false" HeaderStyle-Width="100px">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn AllowFiltering="false" HeaderText="Delete" HeaderStyle-Width="5px">
                        <ItemStyle HorizontalAlign="Center" />
                        <ItemTemplate>
                            <center>
                                <asp:ImageButton ToolTip='<%# ((Eval("IsActive").ToString()=="1")?"Yes":"No") %>'
                                    ID="imgActive" runat="server" CommandArgument='<%# Eval("TruckID") %>' ImageUrl='<%# "~/App_Themes/Blue/images/" + ((Eval("IsActive").ToString()=="1")?"icon_active.png":"icon_deactive.png") %>'
                                    CausesValidation="false" OnClick="imgActive_Click" />
                                <asp:HiddenField ID="hfStateID" runat="server" Value='<%# Eval("TruckID") %>' />
                                <asp:HiddenField ID="hfIsActive" runat="server" Value='<%# Eval("IsActive") %>' />
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
        UpdateCommand="KRV_UpdateTrucks" UpdateCommandType="StoredProcedure" DeleteCommand="KRV_DeleteTrucks"
        DeleteCommandType="StoredProcedure" InsertCommand="KRV_AddTrucks" InsertCommandType="StoredProcedure"
        SelectCommand="KRV_GetTrucks" SelectCommandType="StoredProcedure" CancelSelectOnNullParameter="false">
        <DeleteParameters>
            <asp:Parameter Name="TruckID" Type="Int32" DefaultValue="0" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="TruckID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="LocationID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="TruckNo" Type="String" />
            <asp:Parameter Name="TruckTagNo" Type="String" />
            <asp:Parameter Name="Make" Type="String" />
            <asp:Parameter Name="Model" Type="String" />
            <asp:Parameter Name="Color" Type="String" />
            <asp:Parameter Name="DOP" Type="DateTime" ConvertEmptyStringToNull="true" />
            <asp:Parameter Name="UserName" Type="String" />
            <asp:Parameter Name="Notes" Type="String" />
            <asp:Parameter Name="SlabCapacity" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="VINNumber" Type="String" />
            <asp:Parameter Name="Axles" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="IftaDecal" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="Year" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="MTWeight" Type="Decimal" DefaultValue="0" />
            <asp:Parameter Name="LicensedWeight" Type="Decimal" DefaultValue="0" />
            <asp:Parameter Name="PMMilage" Type="Decimal" DefaultValue="0" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="LocationID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="TruckNo" Type="String" />
            <asp:Parameter Name="TruckTagNo" Type="String" />
            <asp:Parameter Name="Make" Type="String" />
            <asp:Parameter Name="Model" Type="String" />
            <asp:Parameter Name="Color" Type="String" />
            <asp:Parameter Name="DOP" Type="DateTime" ConvertEmptyStringToNull="true" />
            <asp:Parameter Name="UserName" Type="String" />
            <asp:Parameter Name="Notes" Type="String" />
            <asp:Parameter Name="SlabCapacity" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="VINNumber" Type="String" />
            <asp:Parameter Name="Axles" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="IftaDecal" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="Year" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="MTWeight" Type="Decimal" DefaultValue="0" />
            <asp:Parameter Name="LicensedWeight" Type="Decimal" DefaultValue="0" />
            <asp:Parameter Name="PMMilage" Type="Decimal" DefaultValue="0" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsSoftDelete" runat="server" ConnectionString="<%$ ConnectionStrings:dbConnString %>"
        UpdateCommand="KRV_SoftDeleteTrucks" UpdateCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:Parameter Name="TruckID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="UserName" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsLocations" runat="server" ConnectionString="<%$ ConnectionStrings:dbConnString %>"
        SelectCommand="SELECT LocationID,LocationName FROM Locations" SelectCommandType="Text"
        CancelSelectOnNullParameter="false"></asp:SqlDataSource>
</asp:Content>

