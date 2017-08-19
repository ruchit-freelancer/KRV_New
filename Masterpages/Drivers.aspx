<%@ Page Language="C#" MasterPageFile="~/KRV.master" AutoEventWireup="true" CodeFile="Drivers.aspx.cs"
    Inherits="Masterpages_Drivers" %>

<asp:Content ID="Content3" ContentPlaceHolderID="cphHeadTitle" runat="Server">
    Driver Details
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphContent" runat="Server">
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">

        <script type="text/javascript">
            var uploadedFilesCount = 0;
            var isEditMode;
            function validateRadUpload(source, e) {
                // When the RadGrid is in Edit mode the user is not obliged to upload file.
                if (isEditMode == null || isEditMode == undefined) {
                    e.IsValid = false;

                    if (uploadedFilesCount > 0) {
                        e.IsValid = true;
                    }
                }
                isEditMode = null;
            }

            function OnClientFileUploaded(sender, eventArgs) {
                uploadedFilesCount++;
            }

            function conditionalPostback(sender, eventArgs) {
                var theRegexp = new RegExp("\.imgUpdate$|\.PerformInsertButton$", "ig");
                if (eventArgs.get_eventTarget().match(theRegexp)) {
                    var upload = $find(window['PhotoId']);

                    //AJAX is disabled only if file is selected for upload
                    if (upload.getFileInputs()[0].value != "") {
                        eventArgs.set_enableAjax(false);
                    }
                }
            }

        </script>

    </telerik:RadCodeBlock>
    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1"
        ClientEvents-OnRequestStart="conditionalPostback">
        <telerik:RadGrid PageSize="20" ID="rgSearch" runat="server" AllowFilteringByColumn="True"
            AllowPaging="True" AllowAutomaticDeletes="true" AllowAutomaticInserts="false"
            AllowAutomaticUpdates="true" ShowStatusBar="true" AllowSorting="True" AutoGenerateColumns="False"
            CellSpacing="0" DataSourceID="sdsAddEditRecords" GridLines="None" Skin="Sunset"
            OnInsertCommand="RadGrid1_InsertCommand" OnUpdateCommand="RadGrid1_UpdateCommand"
            OnItemDeleted="RadGrid1_ItemDeleted">
            <GroupingSettings CaseSensitive="false" />
            <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Default">
            </HeaderContextMenu>
            <MasterTableView DataSourceID="sdsAddEditRecords" DataKeyNames="DriverID" CommandItemDisplay="Top">
                <EditFormSettings EditFormType="Template">
                    <FormTemplate>
                        <h1>Driver Details</h1>
                        <hr />
                        <asp:Panel ID="Panel1" runat="server" DefaultButton="imgUpdate">
                            <table cellpadding="2" cellspacing="2">
                                <tr>
                                    <td align="left" valign="middle">Driver Name:
                                    </td>
                                    <td align="left" valign="middle">
                                        <asp:TextBox ID="txtDriverName" Width="250px" runat="server" TabIndex="1" Text='<%# Bind("DriverName") %>' />
                                        <span style="color: Red;"><small>*</small></span>
                                    </td>
                                    <td align="left" valign="middle">
                                        <asp:RequiredFieldValidator ID="rfvDriverName" runat="server" ControlToValidate="txtDriverName"
                                            SetFocusOnError="true" Display="None" ErrorMessage="Enter Driver Name"></asp:RequiredFieldValidator>
                                    </td>
                                    <%-- <td align="left" valign="middle">Salary:
                                    </td>
                                    <td align="left" valign="middle">
                                        <telerik:RadNumericTextBox ID="txtSalary" runat="server" TabIndex="11" Type="Number"
                                            InvalidStyleDuration="100" Text='<%# Eval("Salary") %>'>
                                            <NumberFormat AllowRounding="True" KeepNotRoundedValue="False" />
                                        </telerik:RadNumericTextBox>
                                    </td>--%>
                                    <td align="left" valign="middle">Inactive Note:
                                    </td>
                                    <td align="left" valign="middle" rowspan="3">
                                        <asp:TextBox ID="txtInactiveNote" runat="server" TextMode="MultiLine" Width="250px" Height="70px"
                                            Text='<%# Bind("InactiveNote") %>'></asp:TextBox>
                                    </td>
                                    <td rowspan="3"></td>
                                </tr>
                                <tr>
                                    <td align="left" valign="middle">Location:
                                    </td>
                                    <td align="left" valign="middle">
                                        <telerik:RadComboBox ID="rcmbLocation" runat="server" TabIndex="7" DataSourceID="sdsLocations"
                                            DataTextField="LocationName" DataValueField="LocationID" MarkFirstMatch="true"
                                            SelectedValue='<%# Bind("LocationID") %>' Width="250px">
                                        </telerik:RadComboBox>
                                    </td>
                                    <td></td>
                                    <%-- <td align="left" valign="middle">Photo:
                                    </td>
                                    <td align="left" valign="middle">
                                        <telerik:RadAsyncUpload runat="server" ID="AsyncUpload1" TabIndex="12" OnClientFileUploaded="OnClientFileUploaded"
                                            AllowedFileExtensions="jpg,jpeg,png,gif" MaxFileSize="1048576" OnValidatingFile="RadAsyncUpload1_ValidatingFile">
                                        </telerik:RadAsyncUpload>
                                    </td>--%>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td align="left" valign="middle">MobileNo:
                                    </td>
                                    <td align="left" valign="middle">
                                        <asp:TextBox ID="txtMobileNo" runat="server" Text='<%# Bind("MobileNo") %>' TabIndex="8" />
                                    </td>
                                    <td align="left" valign="middle">
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server"
                                            ControlToValidate="txtMobileNo" ErrorMessage="Invalid Mobile No"
                                            ValidationExpression="([0-9]\-?){11}"></asp:RegularExpressionValidator>
                                    </td>

                                </tr>
                                <tr>
                                    <td align="left" valign="middle">License No:
                                    </td>
                                    <td align="left" valign="middle">
                                        <asp:TextBox ID="txtLicenseNo" runat="server" Text='<%# Bind("LicenseNo") %>' TabIndex="9" />
                                        <span style="color: Red;"><small>*</small></span>
                                    </td>
                                    <td align="left" valign="middle">
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtLicenseNo"
                                            SetFocusOnError="true" Display="None" ErrorMessage="Enter LicenseNo"></asp:RequiredFieldValidator>
                                    </td>
                                    <td align="left" valign="middle">Notes:
                                    </td>
                                    <td align="left" valign="middle" rowspan="3">
                                        <asp:TextBox ID="txtNotes" runat="server" TextMode="MultiLine" Width="250px" Height="70px"
                                            Text='<%# Bind("Notes") %>'></asp:TextBox>
                                    </td>
                                    <td rowspan="3"></td>
                                </tr>
                                <tr>
                                    <td align="left" valign="middle">License Expiry:
                                    </td>
                                    <td align="left" valign="middle">
                                        <telerik:RadDatePicker ID="rdtpLicenseExpiry" runat="server" TabIndex="10" Culture="English (United States)"
                                            Skin="Sunset" DbSelectedDate='<%# Bind("LicenseExpiry") %>'>
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
                                    </td>
                                    <td align="left" valign="middle">
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="rdtpLicenseExpiry"
                                            SetFocusOnError="true" Display="None" ErrorMessage="Enter License Exp. Date"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="middle">Medical Expiry:
                                    </td>
                                    <td align="left" valign="middle">
                                        <telerik:RadDatePicker ID="rdtpMedicalExpiry" runat="server" TabIndex="10" Culture="English (United States)"
                                            Skin="Sunset" DbSelectedDate='<%# Bind("MedicalExpiry") %>'>
                                            <Calendar ID="Calendar1" Skin="Sunset" runat="server" UseColumnHeadersAsSelectors="True"
                                                UseRowHeadersAsSelectors="True">
                                            </Calendar>
                                            <DateInput ID="DateInput1" InvalidStyleDuration="100" runat="server" LabelCssClass="radLabelCss_Sunset"
                                                Skin="Sunset" Width="" DateFormat="MM-dd-yyyy" DisplayDateFormat="MM-dd-yyyy"
                                                Font-Bold="true" ForeColor="Black">
                                            </DateInput>
                                            <DatePopupButton CssClass="" />
                                        </telerik:RadDatePicker>
                                        <span style="color: Red;"><small>*</small></span>
                                    </td>
                                    <td align="left" valign="middle">
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="rdtpMedicalExpiry"
                                            SetFocusOnError="true" Display="None" ErrorMessage="Enter Medical Exp. Date"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="middle" colspan="6">
                                        <asp:ImageButton ID="imgUpdate" runat="server" TabIndex="13" CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>'
                                            AlternateText="Update" ToolTip="Update" ImageUrl="~/App_Themes/Blue/images/savebutton.gif" />
                                        <asp:ImageButton ID="imgCancel" runat="server" TabIndex="14" CommandName="Cancel"
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
                    <%--<telerik:GridBinaryImageColumn AllowFiltering="false" DataField="Photo" HeaderText="Image"
                        UniqueName="Photo" ImageHeight="80px" ImageWidth="80px" ResizeMode="Fit" DataAlternateTextField="DriverName"
                        DataAlternateTextFormatString="Image of {0}">
                        <HeaderStyle Width="10%" HorizontalAlign="Center" />
                        <ItemStyle CssClass="binaryImage" />
                    </telerik:GridBinaryImageColumn>--%>
                    <telerik:GridBoundColumn DataField="DriverName" FilterControlAltText="Filter DriverName column"
                        HeaderText="DriverName" SortExpression="DriverName" UniqueName="DriverName" FilterControlWidth="100px"
                        HeaderStyle-Width="100px" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="LocationName" FilterControlAltText="Filter LocationName column"
                        HeaderText="LocationName" SortExpression="LocationName" UniqueName="LocationName"
                        FilterControlWidth="100px" HeaderStyle-Width="100px" AutoPostBackOnFilter="true"
                        CurrentFilterFunction="Contains">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MobileNo" HeaderText="MobileNo" UniqueName="MobileNo"
                        AllowFiltering="false" HeaderStyle-Width="70px">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="LicenseNo" AllowFiltering="false" HeaderText="LicenseNo"
                        UniqueName="LicenseNo" HeaderStyle-Width="70px">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="LicenseExpiryDisp" DataType="System.DateTime" DataFormatString="{0:MM/dd/yyyy}" SortExpression="LicenseExpiryDisp" AllowFiltering="false" HeaderText="License Expiry"
                        UniqueName="LicenseExpiryDisp" HeaderStyle-Width="70px">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MedicalExpiryDisp" DataType="System.DateTime" DataFormatString="{0:MM/dd/yyyy}" SortExpression="MedicalExpiryDisp" AllowFiltering="false" HeaderText="Medical Expiry"
                        UniqueName="MedicalExpiryDisp" HeaderStyle-Width="70px">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="InactiveNote" AllowFiltering="false" HeaderText="Inactive Note"
                        UniqueName="InactiveNote" HeaderStyle-Width="70px">
                    </telerik:GridBoundColumn>
                    <%--<telerik:GridBoundColumn DataField="Salary" AllowFiltering="false" HeaderText="Salary"
                        UniqueName="Salary" HeaderStyle-Width="50px">
                    </telerik:GridBoundColumn>--%>
                    <telerik:GridTemplateColumn AllowFiltering="false" HeaderText="Delete" HeaderStyle-Width="5px">
                        <ItemStyle HorizontalAlign="Center" />
                        <ItemTemplate>
                            <center>
                                <asp:ImageButton ToolTip='<%# ((Eval("IsActive").ToString()=="1")?"Yes":"No") %>'
                                    ID="imgActive" runat="server" CommandArgument='<%# Eval("DriverID") %>' ImageUrl='<%# "~/App_Themes/Blue/images/" + ((Eval("IsActive").ToString()=="1")?"icon_active.png":"icon_deactive.png") %>'
                                    CausesValidation="false" OnClick="imgActive_Click" />
                                <asp:HiddenField ID="hfStateID" runat="server" Value='<%# Eval("DriverID") %>' />
                                <asp:HiddenField ID="hfIsActive" runat="server" Value='<%# Eval("IsActive") %>' />
                            </center>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridButtonColumn ConfirmText="Are you sure want to purge this record?" ConfirmDialogType="RadWindow"
                        ConfirmTitle="Purge Record" ButtonType="ImageButton" CommandName="Delete" Text="Purge"
                        UniqueName="DeleteColumn" HeaderText="Purge" Visible="false">
                        <HeaderStyle Width="5px" />
                        <ItemStyle HorizontalAlign="Center" Width="5px" />
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
        UpdateCommand="KRV_UpdateDrivers" UpdateCommandType="StoredProcedure" DeleteCommand="KRV_DeleteDrivers"
        DeleteCommandType="StoredProcedure" InsertCommand="KRV_AddDrivers" InsertCommandType="StoredProcedure"
        SelectCommand="KRV_GetDrivers" SelectCommandType="StoredProcedure" CancelSelectOnNullParameter="false"
        OnUpdating="sdsAddEditRecords_Updating" OnInserting="sdsAddEditRecords_Inserting">
        <DeleteParameters>
            <asp:Parameter Name="DriverID" Type="Int32" DefaultValue="0" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="DriverID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="DriverName" Type="String" />
            <asp:Parameter Name="LocationID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="MobileNo" Type="String" />
            <asp:Parameter Name="LicenseNo" Type="String" />
            <asp:Parameter Name="LicenseExpiry" Type="DateTime" ConvertEmptyStringToNull="true" />
            <asp:Parameter Name="Notes" Type="String" />
            <asp:Parameter Name="UserName" Type="String" />
            <asp:Parameter Name="MedicalExpiry" Type="DateTime" ConvertEmptyStringToNull="true" />
            <asp:Parameter Name="InactiveNote" Type="String" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="DriverName" Type="String" />
            <asp:Parameter Name="LocationID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="MobileNo" Type="String" />
            <asp:Parameter Name="LicenseNo" Type="String" />
            <asp:Parameter Name="LicenseExpiry" Type="DateTime" ConvertEmptyStringToNull="true" />
            <asp:Parameter Name="Notes" Type="String" />
            <asp:Parameter Name="UserName" Type="String" />
            <asp:Parameter Name="MedicalExpiry" Type="DateTime" ConvertEmptyStringToNull="true" />
            <asp:Parameter Name="InactiveNote" Type="String" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsSoftDelete" runat="server" ConnectionString="<%$ ConnectionStrings:dbConnString %>"
        UpdateCommand="KRV_SoftDeleteDrivers" UpdateCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:Parameter Name="DriverID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="UserName" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsStateName" runat="server" ConnectionString="<%$ ConnectionStrings:dbConnString %>"
        SelectCommand="SELECT StateID,StateName FROM StateList" SelectCommandType="Text"
        CancelSelectOnNullParameter="false"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsLocations" runat="server" ConnectionString="<%$ ConnectionStrings:dbConnString %>"
        SelectCommand="SELECT LocationID,LocationName FROM Locations" SelectCommandType="Text"
        CancelSelectOnNullParameter="false"></asp:SqlDataSource>
</asp:Content>
