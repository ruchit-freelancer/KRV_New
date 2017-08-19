<%@ Page Language="C#" MasterPageFile="~/KRV.master" AutoEventWireup="true" CodeFile="Trips.aspx.cs"
    Inherits="Trips" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .demo-container
        {
            width: 1250px;
            margin: 0 auto;
        }

        .left-image-gallery
        {
            display: inline-block;
            float: left;
            padding-right: 50px;
        }

        .right-image-gallery
        {
            display: inline-block;
            float: left;
        }

        @media (max-width: 1680px)
        {
            .demo-container
            {
                width: 600px;
            }

            .right-image-gallery
            {
                margin-top: 30px;
            }
        }

        .rcbHeader ul, .rcbFooter ul, .rcbItem ul, .rcbHovered ul, .rcbDisabled ul
        {
            width: 100%;
            display: inline-block;
            margin: 0;
            padding: 0;
            list-style-type: none;
        }

        .col1, .col2, .col3
        {
            float: left;
            width: 200px;
            margin: 0;
            padding: 0 5px 0 0;
            line-height: 14px;
        }

        .multipleRowsColumns .rcbItem, .multipleRowsColumns .rcbHovered
        {
            float: left;
            margin: 0 1px;
            min-height: 13px;
            overflow: hidden;
            padding: 2px 19px 2px 6px;
            width: 200px;
        }

        .modal
        {
            display: none;
            position: absolute;
            top: 0px;
            left: 0px;
            background-color: black;
            z-index: 100;
            opacity: 0.8;
            filter: alpha(opacity=60);
            -moz-opacity: 0.8;
            min-height: 100%;
        }

        #divImage
        {
            display: none;
            z-index: 1000;
            position: fixed;
            top: 0;
            left: 0;
            background-color: White;
            height: 630px;
            width: 920px;
            padding: 3px;
            border: solid 1px black;
        }
    </style>
    <script type="text/javascript">

        function openwin() {
            var lightBox = $find('<%= FeedbackLightBox.ClientID %>');
            lightBox.show();
        }
        function LoadDiv(url) {
            var img = new Image();
            var bcgDiv = document.getElementById("divBackground");
            var imgDiv = document.getElementById("divImage");
            var imgFull = document.getElementById("imgFull");
            var imgLoader = document.getElementById("imgLoader");
            imgLoader.style.display = "block";
            img.onload = function () {
                imgFull.src = img.src;
                imgFull.style.display = "block";
                imgLoader.style.display = "none";
            };
            img.src = url;
            var width = document.body.clientWidth;
            if (document.body.clientHeight > document.body.scrollHeight) {
                bcgDiv.style.height = document.body.clientHeight + "px";
            }
            else {
                bcgDiv.style.height = document.body.scrollHeight + "px";
            }
            imgDiv.style.left = (width - 650) / 2 + "px";
            imgDiv.style.top = "20px";
            bcgDiv.style.width = "100%";

            bcgDiv.style.display = "block";
            imgDiv.style.display = "block";
            return false;
        }
        function HideDiv() {
            var bcgDiv = document.getElementById("divBackground");
            var imgDiv = document.getElementById("divImage");
            var imgFull = document.getElementById("imgFull");
            if (bcgDiv != null) {
                bcgDiv.style.display = "none";
                imgDiv.style.display = "none";
                imgFull.style.display = "none";
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphHeadTitle" runat="Server">
    Trips
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphContent" runat="Server">

    <div id="divBackground" class="modal">
    </div>
    <div id="divImage">
        <table style="height: 100%; width: 100%">
            <tr>
                <td valign="middle" align="center">
                    <img id="imgLoader" alt="" src="images/loader.gif" />
                    <img id="imgFull" alt="" style="display: none; height: 600px; width: 900px" />
                </td>
            </tr>
            <tr>
                <td align="center" valign="bottom">
                    <input id="btnClose" type="button" value="close" onclick="HideDiv()" />
                </td>
            </tr>
        </table>
    </div>

    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">

            function onFileUploaded(sender, args) {
                var CustomValidator = document.getElementById($get("<%=HiddenField2.ClientID %>").value);
                ValidatorValidate(CustomValidator);
            }
            function validateUpload(sender, args) {
                var grid = $find("rgSearch");
                var upload = $find($get("<%=HiddenField1.ClientID %>").value);
                args.IsValid = upload.getUploadedFiles().length == 1;
            }


        </script>
    </telerik:RadCodeBlock>
    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
        <asp:HiddenField ID="hfTripID" runat="server" Value="0" />
        <asp:HiddenField ID="hfTruckNo" runat="server" Value="0" />
        <asp:HiddenField ID="hfLocationID" runat="server" Value="0" />
        <asp:TextBox ID="txtTripStartOdometer" runat="server" Text="0" Visible="false"></asp:TextBox>
        <telerik:RadLightBox ID="FeedbackLightBox" runat="server" Modal="true" ZIndex="100000">
            <ClientSettings>
                <AnimationSettings HideAnimation="Resize" NextAnimation="Fade" PrevAnimation="Fade" ShowAnimation="Resize" />
            </ClientSettings>
            <Items>
                <telerik:RadLightBoxItem>
                    <ItemTemplate>
                        <telerik:RadImageGallery runat="server" ID="RadImageGallery4" DisplayAreaMode="Image" Width="600px"
                            Visible="true">
                            <Items>
                                <telerik:ImageGalleryItem ImageUrl="~/Images/desert.jpg" />
                            </Items>
                        </telerik:RadImageGallery>
                    </ItemTemplate>
                </telerik:RadLightBoxItem>
            </Items>

        </telerik:RadLightBox>
        <telerik:RadGrid PageSize="20" ID="rgSearch" runat="server" AllowFilteringByColumn="True"
            AllowPaging="True" AllowAutomaticDeletes="true" AllowAutomaticInserts="false"
            AllowAutomaticUpdates="true" ShowStatusBar="true" AllowSorting="True" AutoGenerateColumns="False"
            CellSpacing="0" DataSourceID="sdsAddEditRecords" GridLines="None" Skin="Sunset"
            OnInsertCommand="RadGrid1_InsertCommand" OnUpdateCommand="RadGrid1_UpdateCommand"
            OnItemDeleted="RadGrid1_ItemDeleted" OnItemDataBound="RadGrid1_ItemDataBound"
            OnItemCommand="RadGrid1_ItemCommand" ShowFooter="true">
            <GroupingSettings CaseSensitive="false" />
            <MasterTableView DataSourceID="sdsAddEditRecords" DataKeyNames="TripID" CommandItemDisplay="Top"
                InsertItemPageIndexAction="ShowItemOnCurrentPage">
                <EditFormSettings EditFormType="Template">
                    <FormTemplate>
                        <telerik:RadTabStrip ID="rtsTrips" runat="server" Skin="Sunset" MultiPageID="RadMultiPage1"
                            SelectedIndex="0" CssClass="tabStrip" CausesValidation="false" AutoPostBack="true"
                            OnTabClick="RadTabStrip1_TabClick">
                            <Tabs>
                                <telerik:RadTab Text="New Trip" PageViewID="rpvTrips">
                                </telerik:RadTab>
                                <telerik:RadTab Text="Trip Stops" PageViewID="rpvTripStops">
                                </telerik:RadTab>
                                <telerik:RadTab Text="Trip Routes" PageViewID="rpvTripRoutes">
                                </telerik:RadTab>
                                <telerik:RadTab Text="Trip Incidents" PageViewID="rpvTripIncidents">
                                </telerik:RadTab>
                                <telerik:RadTab Text="States Travelled" PageViewID="rpvStateTravelled">
                                </telerik:RadTab>
                                <telerik:RadTab Text="Driver Expenses" PageViewID="rpvDriverExpense">
                                </telerik:RadTab>
                                <telerik:RadTab Text="Trip Pictures" PageViewID="rpvTripPictures">
                                </telerik:RadTab>
                            </Tabs>
                        </telerik:RadTabStrip>
                        <telerik:RadMultiPage ID="RadMultiPage1" runat="server" SelectedIndex="0">
                            <telerik:RadPageView ID="rpvTrips" runat="server">
                                <asp:Panel ID="Panel1" runat="server" DefaultButton="imgUpdate">
                                    <table cellpadding="2" cellspacing="2">
                                        <tr>
                                            <td align="left" valign="middle">Select Truck:
                                            </td>
                                            <td align="left" valign="middle">
                                                <telerik:RadComboBox ID="rcmbTrucks" runat="server" DataSourceID="sdsTrucks" DataTextField="TruckNo"
                                                    DataValueField="TruckID" MarkFirstMatch="true" SelectedValue='<%# Eval("TruckID") %>'
                                                    AppendDataBoundItems="true" ValidationGroup="Trips">
                                                    <Items>
                                                        <telerik:RadComboBoxItem Text="Select" Value="Select" />
                                                    </Items>
                                                </telerik:RadComboBox>
                                                <span style="color: Red;"><small>*</small></span>
                                                <asp:RequiredFieldValidator ValidationGroup="Trips" ID="RequiredFieldValidator4"
                                                    runat="server" ControlToValidate="rcmbTrucks" SetFocusOnError="true" Display="None"
                                                    ErrorMessage="Select Truck" InitialValue="Select"></asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" valign="middle">Select Driver:
                                            </td>
                                            <td align="left" valign="middle">
                                                <telerik:RadComboBox ID="rcmbDriver" runat="server" DataSourceID="sdsDrivers" DataTextField="DriverName" AutoPostBack="true"
                                                    OnSelectedIndexChanged="rcmbDriver_SelectedIndexChanged" CausesValidation="false"
                                                    DataValueField="DriverID" MarkFirstMatch="true" SelectedValue='<%# Eval("DriverID") %>'
                                                    AppendDataBoundItems="true" ValidationGroup="Trips">
                                                    <Items>
                                                        <telerik:RadComboBoxItem Text="Select" Value="Select" />
                                                    </Items>
                                                </telerik:RadComboBox>
                                                <span style="color: Red;"><small>*</small></span>
                                                <asp:RequiredFieldValidator ValidationGroup="Trips" ID="RequiredFieldValidator7"
                                                    runat="server" ControlToValidate="rcmbDriver" SetFocusOnError="true" Display="None"
                                                    ErrorMessage="Select Driver" InitialValue="Select"></asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" valign="middle">Select Location:
                                            </td>
                                            <td align="left" valign="middle">
                                                <telerik:RadComboBox ID="rcmbLocation" runat="server" DataSourceID="sdsLocations" DataTextField="LocationName"
                                                    DataValueField="LocationID" MarkFirstMatch="true" SelectedValue='<%# Eval("LocationID") %>'
                                                    AppendDataBoundItems="true" ValidationGroup="Trips">
                                                    <Items>
                                                        <telerik:RadComboBoxItem Text="Select" Value="Select" />
                                                    </Items>
                                                </telerik:RadComboBox>
                                                <span style="color: Red;"><small>*</small></span>
                                                <asp:RequiredFieldValidator ValidationGroup="Trips" ID="RequiredFieldValidator12"
                                                    runat="server" ControlToValidate="rcmbLocation" SetFocusOnError="true" Display="None"
                                                    ErrorMessage="Select Location" InitialValue="Select"></asp:RequiredFieldValidator>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td align="left" valign="middle">Trip Date:
                                            </td>
                                            <td align="left" valign="middle">
                                                <telerik:RadDatePicker ID="rdtpTripDate" runat="server" Culture="English (United States)"
                                                    Skin="Sunset" DbSelectedDate='<%# Bind("TripDate") %>'>
                                                    <Calendar ID="Calendar3" Skin="Sunset" runat="server" UseColumnHeadersAsSelectors="True"
                                                        UseRowHeadersAsSelectors="True">
                                                    </Calendar>
                                                    <DateInput ID="DateInput3" InvalidStyleDuration="100" runat="server" LabelCssClass="radLabelCss_Sunset"
                                                        Skin="Sunset" Width="" DateFormat="MM-dd-yyyy" DisplayDateFormat="MM-dd-yyyy"
                                                        Font-Bold="true" ForeColor="Black" ValidationGroup="Trips">
                                                    </DateInput>
                                                    <DatePopupButton CssClass="" />
                                                </telerik:RadDatePicker>
                                                <span style="color: Red;"><small>*</small></span>
                                                <asp:RequiredFieldValidator ValidationGroup="Trips" ID="RequiredFieldValidator2"
                                                    runat="server" ControlToValidate="rdtpTripDate" SetFocusOnError="true" Display="None"
                                                    ErrorMessage="Enter Trip Date"></asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" valign="middle">Type of Trip:
                                            </td>
                                            <td align="left" valign="middle">
                                                <telerik:RadComboBox ID="rcmbTripType" runat="server" DataSourceID="sdsTripTypes"
                                                    DataTextField="TripType" DataValueField="TripTypeID" MarkFirstMatch="true" SelectedValue='<%# Eval("TripTypeID") %>'>
                                                </telerik:RadComboBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" valign="middle">Trip Start:
                                            </td>
                                            <td align="left" valign="middle">
                                                <telerik:RadDateTimePicker ID="rdtpTripStart" runat="server" DbSelectedDate='<%# Bind("TripStart") %>'
                                                    Skin="Sunset" Culture="English (United States)">
                                                    <Calendar ID="Calendar4" Skin="Sunset" runat="server" EnableKeyboardNavigation="true">
                                                    </Calendar>
                                                    <DateInput ValidationGroup="Trips" DateFormat="MM/dd/yyyy HH:mm:ss">
                                                    </DateInput>
                                                    <TimeView TimeFormat="HH:mm:ss" Columns="15" Interval="00:15:00">
                                                    </TimeView>
                                                </telerik:RadDateTimePicker>
                                                <span style="color: Red;"><small>*</small></span>
                                                <asp:RequiredFieldValidator ValidationGroup="Trips" ID="RequiredFieldValidator5"
                                                    runat="server" ControlToValidate="rdtpTripStart" SetFocusOnError="true" Display="None"
                                                    ErrorMessage="Enter Trip Start Date"></asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" valign="middle">Trip End:
                                            </td>
                                            <td align="left" valign="middle">
                                                <telerik:RadDateTimePicker ID="rdtpTripEnd" runat="server" DbSelectedDate='<%# Bind("TripEnd") %>'
                                                    Skin="Sunset" Culture="English (United States)">
                                                    <Calendar ID="Calendar1" Skin="Sunset" runat="server" EnableKeyboardNavigation="true">
                                                    </Calendar>
                                                    <DateInput ValidationGroup="Trips" runat="server" DateFormat="MM/dd/yyyy HH:mm:ss">
                                                    </DateInput>
                                                    <TimeView TimeFormat="HH:mm:ss" runat="server" Columns="15" Interval="00:15:00">
                                                    </TimeView>
                                                </telerik:RadDateTimePicker>
                                                <span style="color: Red;"><small>*</small></span>
                                                <asp:RequiredFieldValidator ValidationGroup="Trips" ID="RequiredFieldValidator6"
                                                    runat="server" ControlToValidate="rdtpTripEnd" SetFocusOnError="true" Display="None"
                                                    ErrorMessage="Enter Trip Start Date"></asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" valign="middle">Start Odometer:
                                            </td>
                                            <td align="left" valign="middle">
                                                <telerik:RadNumericTextBox ID="txtStartOdometer" runat="server" Type="Number" InvalidStyleDuration="100"
                                                    Text='<%# Eval("StartOdometer") %>' MinValue="0" Value="0">
                                                    <NumberFormat DecimalDigits="0" GroupSeparator="" />
                                                </telerik:RadNumericTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" valign="middle">End Odometer:
                                            </td>
                                            <td align="left" valign="middle">
                                                <telerik:RadNumericTextBox ID="txtEndOdometer" runat="server" Type="Number" InvalidStyleDuration="100"
                                                    Text='<%# Eval("EndOdometer") %>' MinValue="0" ValidationGroup="Trips">
                                                    <NumberFormat DecimalDigits="0" GroupSeparator="" />
                                                </telerik:RadNumericTextBox>
                                                <asp:CompareValidator ValidationGroup="Trips" ID="CompareValidator1" runat="server"
                                                    Display="Dynamic" SetFocusOnError="true" Type="Integer" Operator="GreaterThan"
                                                    ErrorMessage="Must be Greater Than Start Odometer" ControlToValidate="txtEndOdometer"
                                                    ControlToCompare="txtStartOdometer"></asp:CompareValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" valign="middle" colspan="2">
                                                <asp:ImageButton ValidationGroup="Trips" ID="imgUpdate" runat="server" CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>'
                                                    AlternateText="Update" ToolTip="Update" ImageUrl="~/App_Themes/Blue/images/savebutton.gif" />
                                                <asp:ImageButton ID="imgCancel" runat="server" CommandName="Cancel" AlternateText="Cancel"
                                                    ToolTip="Cancel" ImageUrl="~/App_Themes/Blue/images/cancelbutton.gif" CausesValidation="false" />
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </telerik:RadPageView>
                            <telerik:RadPageView ID="rpvTripStops" runat="server">
                                <telerik:RadGrid PageSize="20" ID="rgTripStops" runat="server" AllowFilteringByColumn="True"
                                    AllowPaging="True" AllowAutomaticDeletes="true" AllowAutomaticInserts="false"
                                    AllowAutomaticUpdates="true" ShowStatusBar="true" AllowSorting="True" AutoGenerateColumns="False"
                                    CellSpacing="0" DataSourceID="sdsTripStops" GridLines="None" Skin="Sunset" OnInsertCommand="rgTripStops_InsertCommand"
                                    OnUpdateCommand="rgTripStops_UpdateCommand" OnItemDeleted="rgTripStops_ItemDeleted"
                                    OnItemDataBound="rgTripStops_ItemDataBound">
                                    <GroupingSettings CaseSensitive="false" />
                                    <MasterTableView DataSourceID="sdsTripStops" DataKeyNames="StopID" CommandItemDisplay="Top" ShowFooter="true">
                                        <EditFormSettings EditFormType="Template">
                                            <FormTemplate>
                                                <h1>Trip-Stops Details</h1>
                                                <hr />
                                                <asp:Panel ID="Panel1" runat="server" DefaultButton="imgUpdate">
                                                    <table cellpadding="2" cellspacing="2">
                                                        <tr>
                                                            <td align="left" valign="middle">Location:
                                                            </td>
                                                            <td align="left" valign="middle">
                                                                <asp:HiddenField ID="hfCustomerID" runat="server" Value='<%# Eval("CustomerID") %>'
                                                                    EnableViewState="false" />
                                                                <asp:HiddenField ID="hfLocationID" runat="server" Value='<%# Eval("LocationID") %>'
                                                                    EnableViewState="false" />
                                                                <telerik:RadComboBox ID="rcmbLocations" runat="server" DataSourceID="sdsLocations"
                                                                    DataTextField="LocationName" DataValueField="LocationID" MarkFirstMatch="true"
                                                                    AutoPostBack="true" SelectedValue='<%# Eval("LocationID") %>' Width="250px"
                                                                    AppendDataBoundItems="true" CausesValidation="false" OnSelectedIndexChanged="rcmbLocations_SelectedIndexChanged">
                                                                    <Items>
                                                                        <telerik:RadComboBoxItem Text="Select" Value="Select" />
                                                                    </Items>
                                                                </telerik:RadComboBox>
                                                                <span style="color: Red;"><small>*</small></span>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" SetFocusOnError="true"
                                                                    Display="None" ErrorMessage="Select Location" ControlToValidate="rcmbLocations"
                                                                    ValidationGroup="TripStops" InitialValue="Select"></asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left" valign="middle">Select Customer:
                                                            </td>
                                                            <td align="left" valign="middle">
                                                                <telerik:RadComboBox ID="rcmbCustomers" runat="server" DataSourceID="sdsCustomers"
                                                                    DataTextField="CustomerName" DataValueField="CustomerID" MarkFirstMatch="true"
                                                                    Width="650px" ValidationGroup="TripStops" HighlightTemplatedItems="true">
                                                                    <HeaderTemplate>
                                                                        <ul>
                                                                            <li class="col1">Customer Name</li>
                                                                            <li class="col2">City</li>
                                                                            <li class="col3">State</li>
                                                                        </ul>
                                                                    </HeaderTemplate>
                                                                    <ItemTemplate>
                                                                        <ul>
                                                                            <li class="col1">
                                                                                <%# DataBinder.Eval(Container.DataItem, "CustomerName") %></li>
                                                                            <li class="col2">
                                                                                <%# DataBinder.Eval(Container.DataItem, "City") %></li>
                                                                            <li class="col3">
                                                                                <%# DataBinder.Eval(Container.DataItem, "StateName") %></li>
                                                                        </ul>
                                                                    </ItemTemplate>
                                                                </telerik:RadComboBox>
                                                                <span style="color: Red;"><small>*</small></span>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" SetFocusOnError="true"
                                                                    Display="None" ErrorMessage="Select Customer" ControlToValidate="rcmbCustomers"
                                                                    ValidationGroup="TripStops"></asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left" valign="middle">Stop Index:
                                                            </td>
                                                            <td align="left" valign="middle">
                                                                <asp:TextBox ID="txtStopIndex" runat="server" Text='<%# Eval("StopIndex") %>' ValidationGroup="TripStops"></asp:TextBox>
                                                                <span style="color: Red;"><small>*</small></span>
                                                                <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="txtStopIndex"
                                                                    Display="None" SetFocusOnError="true" Type="Integer" Operator="DataTypeCheck"
                                                                    ValidationGroup="TripStops" ErrorMessage="Enter Stop Index"></asp:CompareValidator>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left" valign="middle">Type of Stop:
                                                            </td>
                                                            <td align="left" valign="middle">
                                                                <telerik:RadComboBox ID="rcmbStopTypes" runat="server" DataSourceID="sdsStopTypes"
                                                                    DataTextField="StopType" DataValueField="StopTypeID" MarkFirstMatch="true" SelectedValue='<%# Eval("StopTypeID") %>'
                                                                    ValidationGroup="TripStops">
                                                                </telerik:RadComboBox>
                                                                <span style="color: Red;"><small>*</small></span>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" SetFocusOnError="true"
                                                                    Display="None" ErrorMessage="Select Type of Stop" ControlToValidate="rcmbStopTypes"
                                                                    ValidationGroup="TripStops" InitialValue="Select"></asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left" valign="middle">BOL Number:
                                                            </td>
                                                            <td align="left" valign="middle">
                                                                <asp:TextBox ID="txtBOLNumber" runat="server" Text='<%# Eval("BOLNumber") %>'></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left" valign="middle">Slabs Delivered:
                                                            </td>
                                                            <td align="left" valign="middle">
                                                                <telerik:RadNumericTextBox ID="txtSlabsDelivered" runat="server" Type="Number" InvalidStyleDuration="100"
                                                                    Text='<%# Eval("SlabsDelivered") %>'>
                                                                    <NumberFormat DecimalDigits="0" GroupSeparator="" />
                                                                </telerik:RadNumericTextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left" valign="middle">Slabs PickedUp:
                                                            </td>
                                                            <td align="left" valign="middle">
                                                                <telerik:RadNumericTextBox ID="txtSlabsPickedUp" runat="server" Type="Number" InvalidStyleDuration="100"
                                                                    Text='<%# Eval("SlabsPickedUp") %>'>
                                                                    <NumberFormat DecimalDigits="0" GroupSeparator="" />
                                                                </telerik:RadNumericTextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left" valign="middle">Stop Odometer:
                                                            </td>
                                                            <td align="left" valign="middle">
                                                                <telerik:RadNumericTextBox ID="txtStopOdometer" runat="server" Type="Number" InvalidStyleDuration="100"
                                                                    Text='<%# Eval("StopOdometer") %>' MinValue="0" ValidationGroup="TripStops">
                                                                    <NumberFormat DecimalDigits="0" GroupSeparator="" />
                                                                </telerik:RadNumericTextBox>
                                                                <asp:TextBox ID="txtTSO" runat="server" Text="0" Visible="false"></asp:TextBox>
                                                                <asp:CompareValidator ID="CompareValidator2" runat="server" Display="Dynamic" SetFocusOnError="true"
                                                                    ControlToValidate="txtStopOdometer" ControlToCompare="txtTSO" Type="Integer"
                                                                    ValidationGroup="TripStops" Operator="GreaterThanEqual" ErrorMessage="Must be Greater Than Start Odometer of Trip"></asp:CompareValidator>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left" valign="middle">Arrival Time:
                                                            </td>
                                                            <td align="left" valign="middle">
                                                                <telerik:RadTimePicker ID="rtpArrivalTime" runat="server" Skin="Sunset" DbSelectedDate='<%# Bind("ArrivalTime") %>'>
                                                                    <TimeView ID="TimeView2" Skin="Sunset" runat="server" ShowHeader="False" StartTime="00:00:00"
                                                                        Interval="00:15:00" EndTime="23:59:00" Columns="8" TimeFormat="HH:mm tt">
                                                                    </TimeView>
                                                                </telerik:RadTimePicker>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left" valign="middle">Departure Time:
                                                            </td>
                                                            <td align="left" valign="middle">
                                                                <telerik:RadTimePicker ID="rtpDepartureTime" runat="server" Skin="Sunset" DbSelectedDate='<%# Bind("DepartureTime") %>'>
                                                                    <TimeView ID="TimeView1" Skin="Sunset" runat="server" ShowHeader="False" StartTime="00:00:00"
                                                                        Interval="00:15:00" EndTime="23:59:00" Columns="8" TimeFormat="HH:mm tt">
                                                                    </TimeView>
                                                                </telerik:RadTimePicker>
                                                                <asp:CompareValidator ID="cvrtpDepartureTime" ControlToValidate="rtpDepartureTime"
                                                                    ControlToCompare="rtpArrivalTime" runat="server" ErrorMessage="Time must be large than Arrival"
                                                                    Type="String" Operator="GreaterThan" Display="Dynamic" SetFocusOnError="true"></asp:CompareValidator>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left" valign="middle" colspan="2">
                                                                <asp:ImageButton ID="imgUpdate" ValidationGroup="TripStops" runat="server" CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>'
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
                                                <HeaderStyle Width="5px" />
                                                <ItemStyle HorizontalAlign="Center" />
                                            </telerik:GridEditCommandColumn>
                                            <telerik:GridBoundColumn DataField="StopIndex" HeaderText="StopIndex" SortExpression="StopIndex"
                                                UniqueName="StopIndex" HeaderStyle-Width="50px" AllowFiltering="false">
                                                <ItemStyle HorizontalAlign="Left" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="CustomerName" FilterControlAltText="Filter CustomerName column"
                                                HeaderText="Customer Name" SortExpression="CustomerName" UniqueName="CustomerName"
                                                FilterControlWidth="100px" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains">
                                                <ItemStyle HorizontalAlign="Left" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="StopType" FilterControlAltText="Filter StopType column"
                                                HeaderText="StopType" SortExpression="StopType" UniqueName="StopType" FilterControlWidth="70px"
                                                HeaderStyle-Width="70px" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="BOLNumber" FilterControlAltText="Filter BOLNumber column"
                                                HeaderText="BOLNumber" SortExpression="BOLNumber" UniqueName="BOLNumber" FilterControlWidth="70px"
                                                HeaderStyle-Width="70px" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="SlabsDelivered" AllowFiltering="false" HeaderText="SlabsDelivered" Aggregate="Sum"
                                                SortExpression="SlabsDelivered" UniqueName="SlabsDelivered" HeaderStyle-Width="70px" FooterAggregateFormatString="Total: {0}">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="SlabsPickedUp" HeaderText="SlabsPickedUp" Aggregate="Sum" SortExpression="SlabsPickedUp"
                                                UniqueName="SlabsPickedUp" HeaderStyle-Width="70px" AllowFiltering="false" FooterAggregateFormatString="Total: {0}">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="StopOdometer" HeaderText="StopOdometer" SortExpression="StopOdometer"
                                                UniqueName="StopOdometer" AllowFiltering="false" HeaderStyle-Width="70px">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="ArrivalTimeDisp" AllowFiltering="false" HeaderText="ArrivalTime"
                                                SortExpression="ArrivalTimeDisp" UniqueName="ArrivalTimeDisp" HeaderStyle-Width="70px">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="DepartureTimeDisp" HeaderText="DepartureTime"
                                                SortExpression="DepartureTimeDisp" UniqueName="DepartureTimeDisp" HeaderStyle-Width="70px"
                                                AllowFiltering="false">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridTemplateColumn AllowFiltering="false" HeaderText="Delete" HeaderStyle-Width="5px">
                                                <ItemStyle HorizontalAlign="Center" />
                                                <ItemTemplate>
                                                    <center>
                                                        <asp:ImageButton ToolTip='<%# ((Eval("IsActive").ToString()=="1")?"Yes":"No") %>'
                                                            ID="imgActive" runat="server" CommandArgument='<%# Eval("StopID") %>' ImageUrl='<%# "~/App_Themes/Blue/images/" + ((Eval("IsActive").ToString()=="1")?"icon_active.png":"icon_deactive.png") %>'
                                                            CausesValidation="false" OnClick="imgActiveTripStops_Click" />
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
                                </telerik:RadGrid>
                            </telerik:RadPageView>
                            <telerik:RadPageView ID="rpvTripRoutes" runat="server">
                                <table width="100%" cellpadding="5" cellspacing="5">
                                    <tr>
                                        <td align="left" valign="top">
                                            <asp:Button ID="btnAdd" ForeColor="#ffffff" BorderStyle="None" Height="30px" Font-Bold="true"
                                                BackColor="#999999" runat="server" CausesValidation="false" Text="Add Selected"
                                                OnClick="btnAdd_Click" /><br />
                                            <telerik:RadGrid PageSize="50" ID="rgTripRoutesNotSelected" runat="server" AllowFilteringByColumn="True"
                                                AllowMultiRowSelection="true" AllowPaging="True" AllowAutomaticDeletes="false"
                                                AllowAutomaticInserts="false" AllowAutomaticUpdates="false" ShowStatusBar="true"
                                                AllowSorting="True" AutoGenerateColumns="False" CellSpacing="0" DataSourceID="sdsTripRouteNotSelected"
                                                GridLines="None" Skin="Sunset">
                                                <GroupingSettings CaseSensitive="false" />
                                                <MasterTableView DataSourceID="sdsTripRouteNotSelected">
                                                    <Columns>
                                                        <telerik:GridClientSelectColumn HeaderText="Select" HeaderStyle-HorizontalAlign="Left"
                                                            HeaderStyle-Width="5px">
                                                        </telerik:GridClientSelectColumn>
                                                        <telerik:GridTemplateColumn HeaderText="Add" HeaderStyle-Width="5px" AllowFiltering="false">
                                                            <ItemTemplate>
                                                                <asp:ImageButton ID="imgAddTripRoutes" runat="server" ImageUrl="~/App_Themes/Blue/images/add.gif"
                                                                    CommandArgument='<%# Eval("RouteID") %>' CausesValidation="false" AlternateText="Add Routes"
                                                                    ToolTip="Add Routes" OnClick="imgAddTripRoutes_Click" />
                                                                <asp:HiddenField ID="hfRouteID" runat="server" Value='<%# Eval("RouteID") %>' />
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridBoundColumn DataField="StateName" FilterControlAltText="Filter StateName column"
                                                            HeaderText="StateName" SortExpression="StateName" UniqueName="StateName" FilterControlWidth="150px"
                                                            HeaderStyle-Width="150px" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains">
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="RouteName" FilterControlAltText="Filter RouteName column"
                                                            HeaderText="RouteName" SortExpression="RouteName" UniqueName="RouteName" FilterControlWidth="150px"
                                                            HeaderStyle-Width="150px" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains">
                                                        </telerik:GridBoundColumn>
                                                    </Columns>
                                                </MasterTableView>
                                                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                                                <ClientSettings>
                                                    <Selecting AllowRowSelect="True" />
                                                </ClientSettings>
                                                <FilterMenu EnableImageSprites="False">
                                                </FilterMenu>
                                            </telerik:RadGrid>
                                        </td>
                                        <td align="left" valign="top">
                                            <asp:Button ID="btnRemove" runat="server" CausesValidation="false" Text="Remove Selected"
                                                OnClick="btnRemove_Click" ForeColor="#ffffff" BorderStyle="None" Height="30px"
                                                Font-Bold="true" BackColor="#999999" /><br />
                                            <telerik:RadGrid PageSize="20" ID="rgTripRoutes" runat="server" AllowFilteringByColumn="True"
                                                AllowPaging="True" AllowAutomaticDeletes="true" AllowAutomaticInserts="false"
                                                AllowMultiRowSelection="true" AllowAutomaticUpdates="false" ShowStatusBar="true"
                                                AllowSorting="True" AutoGenerateColumns="False" CellSpacing="0" DataSourceID="sdsTripRoutes"
                                                GridLines="None" Skin="Sunset" OnItemDeleted="rgTripRoutes_ItemDeleted">
                                                <GroupingSettings CaseSensitive="false" />
                                                <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Default">
                                                </HeaderContextMenu>
                                                <MasterTableView DataSourceID="sdsTripRoutes" DataKeyNames="TripRouteID">
                                                    <Columns>
                                                        <telerik:GridClientSelectColumn HeaderText="Select" HeaderStyle-HorizontalAlign="Left"
                                                            HeaderStyle-Width="5px">
                                                        </telerik:GridClientSelectColumn>
                                                        <telerik:GridBoundColumn DataField="StateName" FilterControlAltText="Filter StateName column"
                                                            HeaderText="StateName" SortExpression="StateName" UniqueName="StateName" FilterControlWidth="150px"
                                                            HeaderStyle-Width="150px" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains">
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="RouteName" FilterControlAltText="Filter RouteName column"
                                                            HeaderText="RouteName" SortExpression="RouteName" UniqueName="RouteName" FilterControlWidth="150px"
                                                            HeaderStyle-Width="150px" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains">
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridTemplateColumn AllowFiltering="false" HeaderText="Delete" HeaderStyle-Width="5px">
                                                            <ItemStyle HorizontalAlign="Center" />
                                                            <ItemTemplate>
                                                                <center>
                                                                    <asp:HiddenField ID="hfTripRouteID" runat="server" Value='<%# Eval("TripRouteID") %>' />
                                                                    <asp:ImageButton ToolTip='<%# ((Eval("IsActive").ToString()=="1")?"Yes":"No") %>'
                                                                        ID="imgActive" runat="server" CommandArgument='<%# Eval("TripRouteID") %>' ImageUrl='<%# "~/App_Themes/Blue/images/" + ((Eval("IsActive").ToString()=="1")?"icon_active.png":"icon_deactive.png") %>'
                                                                        CausesValidation="false" OnClick="imgActiveTripRoutes_Click" />
                                                                </center>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridButtonColumn ConfirmText="Are you sure want to purge this record?" ConfirmDialogType="RadWindow"
                                                            ConfirmTitle="Purge Record" ButtonType="ImageButton" CommandName="Delete" Text="Purge"
                                                            UniqueName="DeleteColumn" HeaderText="Purge" HeaderStyle-Width="5px" Visible="false">
                                                            <ItemStyle HorizontalAlign="Center" Width="5px" />
                                                        </telerik:GridButtonColumn>
                                                    </Columns>
                                                </MasterTableView>
                                                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                                                <ClientSettings>
                                                    <Selecting AllowRowSelect="True" />
                                                </ClientSettings>
                                            </telerik:RadGrid>
                                        </td>
                                    </tr>
                                </table>
                            </telerik:RadPageView>
                            <telerik:RadPageView ID="rpvTripIncidents" runat="server">
                                <telerik:RadGrid PageSize="20" ID="rgTripIncidents" runat="server" AllowFilteringByColumn="True"
                                    AllowPaging="True" AllowAutomaticDeletes="true" AllowAutomaticInserts="false"
                                    AllowAutomaticUpdates="true" ShowStatusBar="true" AllowSorting="True" AutoGenerateColumns="False"
                                    CellSpacing="0" DataSourceID="sdsTripIncidents" GridLines="None" Skin="Sunset"
                                    OnInsertCommand="TripIncidents_InsertCommand" OnUpdateCommand="TripIncidents_UpdateCommand"
                                    OnItemDeleted="TripIncidents_ItemDeleted" OnItemDataBound="rgTripIncidents_ItemDataBound">
                                    <GroupingSettings CaseSensitive="false" />
                                    <MasterTableView DataSourceID="sdsTripIncidents" DataKeyNames="IncidentID" CommandItemDisplay="Top">
                                        <EditFormSettings EditFormType="Template">
                                            <FormTemplate>
                                                <h1>Trip-Incident Details
                                                </h1>
                                                <hr />
                                                <asp:Panel ID="Panel1" runat="server" DefaultButton="imgUpdate">
                                                    <table cellpadding="2" cellspacing="2">
                                                        <tr>
                                                            <td align="left" valign="middle">Incident Date:
                                                            </td>
                                                            <td align="left" valign="middle">
                                                                <telerik:RadDatePicker ID="rdtpIncidentDate" runat="server" Culture="English (United States)"
                                                                    Skin="Sunset" DbSelectedDate='<%# Bind("IncidentDate") %>'>
                                                                    <Calendar ID="Calendar3" Skin="Sunset" runat="server" UseColumnHeadersAsSelectors="True"
                                                                        UseRowHeadersAsSelectors="True">
                                                                    </Calendar>
                                                                    <DateInput ID="DateInput3" InvalidStyleDuration="100" runat="server" LabelCssClass="radLabelCss_Sunset"
                                                                        Skin="Sunset" Width="" DateFormat="MM-dd-yyyy" DisplayDateFormat="MM-dd-yyyy"
                                                                        Font-Bold="true" ForeColor="Black" ValidationGroup="TripIncident">
                                                                    </DateInput>
                                                                    <DatePopupButton CssClass="" />
                                                                </telerik:RadDatePicker>
                                                                <span style="color: Red;"><small>*</small></span>
                                                                <asp:RequiredFieldValidator ValidationGroup="TripIncident" ID="RequiredFieldValidator2"
                                                                    runat="server" ControlToValidate="rdtpIncidentDate" SetFocusOnError="true" Display="None"
                                                                    ErrorMessage="Enter Incident Date"></asp:RequiredFieldValidator>
                                                            </td>
                                                            <td align="left" valign="middle">Incident Type:
                                                            </td>
                                                            <td align="left" valign="middle">
                                                                <telerik:RadComboBox ID="rcmbIncidentTypes" runat="server" DataSourceID="sdsIncidentTypes"
                                                                    DataTextField="IncidentType" DataValueField="IncidentTypeID" MarkFirstMatch="true"
                                                                    SelectedValue='<%# Eval("IncidentTypeID") %>' ValidationGroup="TripIncident"
                                                                    AppendDataBoundItems="true">
                                                                    <Items>
                                                                        <telerik:RadComboBoxItem Text="Select" Value="Select" />
                                                                    </Items>
                                                                </telerik:RadComboBox>
                                                                <span style="color: Red;"><small>*</small></span>
                                                                <asp:RequiredFieldValidator ValidationGroup="TripIncident" ID="RequiredFieldValidator8"
                                                                    runat="server" ControlToValidate="rcmbIncidentTypes" InitialValue="Select" SetFocusOnError="true"
                                                                    Display="None" ErrorMessage="Select Incident Type"></asp:RequiredFieldValidator>
                                                            </td>
                                                            <td align="left" valign="middle">State Name:
                                                            </td>
                                                            <td align="left" valign="middle">
                                                                <telerik:RadComboBox ID="rcmbStateName" runat="server" DataSourceID="sdsStateName"
                                                                    DataTextField="StateName" DataValueField="StateID" MarkFirstMatch="true" SelectedValue='<%# Eval("StateID") %>'
                                                                    AppendDataBoundItems="true" ValidationGroup="TripIncident">
                                                                    <Items>
                                                                        <telerik:RadComboBoxItem Text="Select" Value="Select" />
                                                                    </Items>
                                                                </telerik:RadComboBox>
                                                                <span style="color: Red;"><small>*</small></span>
                                                                <asp:RequiredFieldValidator ValidationGroup="TripIncident" ID="RequiredFieldValidator1"
                                                                    runat="server" ControlToValidate="rcmbStateName" InitialValue="Select" SetFocusOnError="true"
                                                                    Display="None" ErrorMessage="Select State"></asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left" valign="top">Remarks:
                                                            </td>
                                                            <td align="left" valign="middle" colspan="5">
                                                                <telerik:RadEditor ID="reDescription" runat="server" Skin="Sunset" Height="250px"
                                                                    ContentAreaMode="Div" ToolsFile="~/App_Themes/Blue/RadEditorTools/BasicTools.xml"
                                                                    Width="750px" Content='<%# Bind("Remarks") %>' EditModes="Design">
                                                                    <Content>
                                                                    </Content>
                                                                </telerik:RadEditor>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left" valign="middle" colspan="2">
                                                                <asp:ImageButton ValidationGroup="TripIncident" ID="imgUpdate" runat="server" CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>'
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
                                            <telerik:GridDateTimeColumn DataField="IncidentDate" HeaderText="Date" SortExpression="IncidentDate"
                                                UniqueName="IncidentDate" FilterControlWidth="100px" HeaderStyle-Width="100px"
                                                AllowFiltering="true" DataType="System.DateTime" FilterListOptions="VaryByDataType"
                                                AutoPostBackOnFilter="true" CurrentFilterFunction="EqualTo" DataFormatString="{0:MM-dd-yyyy}">
                                            </telerik:GridDateTimeColumn>
                                            <telerik:GridBoundColumn DataField="IncidentType" FilterControlAltText="Filter IncidentType column"
                                                HeaderText="IncidentType" SortExpression="IncidentType" UniqueName="IncidentType"
                                                FilterControlWidth="100px" HeaderStyle-Width="100px" AutoPostBackOnFilter="true"
                                                CurrentFilterFunction="Contains">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="StateName" FilterControlAltText="Filter StateName column"
                                                HeaderText="State Name" SortExpression="StateName" UniqueName="StateName" FilterControlWidth="100px"
                                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains">
                                                <HeaderStyle Width="200px" />
                                                <ItemStyle Width="200px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="Remarks" AllowFiltering="false" HeaderText="Remarks"
                                                SortExpression="Remarks" UniqueName="Remarks">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridTemplateColumn AllowFiltering="false" HeaderText="Delete" HeaderStyle-Width="5px">
                                                <ItemStyle HorizontalAlign="Center" />
                                                <ItemTemplate>
                                                    <center>
                                                        <asp:ImageButton ToolTip='<%# ((Eval("IsActive").ToString()=="1")?"Yes":"No") %>'
                                                            ID="imgActive" runat="server" CommandArgument='<%# Eval("IncidentID") %>' ImageUrl='<%# "~/App_Themes/Blue/images/" + ((Eval("IsActive").ToString()=="1")?"icon_active.png":"icon_deactive.png") %>'
                                                            CausesValidation="false" OnClick="imgActiveTripIncident_Click" />
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
                                </telerik:RadGrid>
                            </telerik:RadPageView>
                            <telerik:RadPageView ID="rpvStateTravelled" runat="server">
                                <telerik:RadGrid PageSize="20" ID="rgStateTravelled" runat="server" AllowFilteringByColumn="True"
                                    AllowPaging="True" AllowAutomaticDeletes="true" AllowAutomaticInserts="false"
                                    AllowAutomaticUpdates="true" ShowStatusBar="true" AllowSorting="True" AutoGenerateColumns="False"
                                    CellSpacing="0" DataSourceID="sdsStateTravelled" GridLines="None" Skin="Sunset"
                                    OnInsertCommand="StateTravelled_InsertCommand" OnUpdateCommand="StateTravelled_UpdateCommand"
                                    OnItemDeleted="StateTravelled_ItemDeleted" OnItemDataBound="rgStateTravelled_ItemDataBound">
                                    <GroupingSettings CaseSensitive="false" />
                                    <MasterTableView DataSourceID="sdsStateTravelled" DataKeyNames="TravelledID" CommandItemDisplay="Top">
                                        <EditFormSettings EditFormType="Template">
                                            <FormTemplate>
                                                <h1>States Travelled</h1>
                                                <hr />
                                                <asp:Panel ID="Panel1" runat="server" DefaultButton="imgUpdate">
                                                    <table cellpadding="2" cellspacing="2">
                                                        <tr>
                                                            <td align="left" valign="middle">State Name:
                                                            </td>
                                                            <td align="left" valign="middle">
                                                                <telerik:RadComboBox ID="rcmbStateName" runat="server" DataSourceID="sdsStateName"
                                                                    DataTextField="StateName" DataValueField="StateID" MarkFirstMatch="true" SelectedValue='<%# Eval("StateID") %>'
                                                                    AppendDataBoundItems="true" ValidationGroup="StateTravelled">
                                                                    <Items>
                                                                        <telerik:RadComboBoxItem Text="Select" Value="Select" />
                                                                    </Items>
                                                                </telerik:RadComboBox>
                                                                <span style="color: Red;"><small>*</small></span>
                                                                <asp:RequiredFieldValidator ValidationGroup="StateTravelled" ID="RequiredFieldValidator1"
                                                                    runat="server" ControlToValidate="rcmbStateName" InitialValue="Select" SetFocusOnError="true"
                                                                    Display="None" ErrorMessage="Select State"></asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left" valign="middle">Start Odometer:
                                                            </td>
                                                            <td align="left" valign="middle">
                                                                <telerik:RadNumericTextBox ID="txtStartOdometer" runat="server" Type="Number" InvalidStyleDuration="100"
                                                                    Text='<%# Eval("StartOdometer") %>' MinValue="0" Value="0">
                                                                    <NumberFormat DecimalDigits="0" GroupSeparator="" />
                                                                </telerik:RadNumericTextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left" valign="middle">End Odometer:
                                                            </td>
                                                            <td align="left" valign="middle">
                                                                <telerik:RadNumericTextBox ID="txtEndOdometer" runat="server" Type="Number" InvalidStyleDuration="100"
                                                                    Text='<%# Eval("EndOdometer") %>' MinValue="0" Value="0">
                                                                    <NumberFormat DecimalDigits="0" GroupSeparator="" />
                                                                </telerik:RadNumericTextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left" valign="middle" colspan="2">
                                                                <asp:ImageButton ValidationGroup="StateTravelled" ID="imgUpdate" runat="server" CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>'
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
                                            <telerik:GridBoundColumn DataField="StateName" FilterControlAltText="Filter StateName column"
                                                HeaderText="State Name" SortExpression="StateName" UniqueName="StateName" FilterControlWidth="200px"
                                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="StartOdometer" FilterControlAltText="Filter StartOdometer column"
                                                HeaderText="StartOdometer" SortExpression="StartOdometer" UniqueName="StartOdometer"
                                                FilterControlWidth="70px" HeaderStyle-Width="70px" AutoPostBackOnFilter="true"
                                                CurrentFilterFunction="Contains">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="EndOdometer" FilterControlAltText="Filter EndOdometer column"
                                                HeaderText="EndOdometer" SortExpression="EndOdometer" UniqueName="EndOdometer"
                                                FilterControlWidth="70px" HeaderStyle-Width="70px" AutoPostBackOnFilter="true"
                                                CurrentFilterFunction="Contains">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridTemplateColumn AllowFiltering="false" HeaderText="Delete" HeaderStyle-Width="5px">
                                                <ItemStyle HorizontalAlign="Center" />
                                                <ItemTemplate>
                                                    <center>
                                                        <asp:ImageButton ToolTip='<%# ((Eval("IsActive").ToString()=="1")?"Yes":"No") %>'
                                                            ID="imgActive" runat="server" CommandArgument='<%# Eval("TravelledID") %>' ImageUrl='<%# "~/App_Themes/Blue/images/" + ((Eval("IsActive").ToString()=="1")?"icon_active.png":"icon_deactive.png") %>'
                                                            CausesValidation="false" OnClick="imgActiveStateTravelled_Click" />
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
                                </telerik:RadGrid>
                            </telerik:RadPageView>
                            <telerik:RadPageView ID="rpvDriverExpense" runat="server">
                                <telerik:RadGrid PageSize="20" ID="rgDriverExpense" runat="server" AllowFilteringByColumn="True"
                                    AllowPaging="True" AllowAutomaticDeletes="true" AllowAutomaticInserts="false"
                                    AllowAutomaticUpdates="true" ShowStatusBar="true" AllowSorting="True" AutoGenerateColumns="False"
                                    CellSpacing="0" DataSourceID="sdsDriverExpenses" GridLines="None" Skin="Sunset"
                                    OnInsertCommand="rgDriverExpenses_InsertCommand" OnUpdateCommand="rgDriverExpenses_UpdateCommand"
                                    OnItemDeleted="rgDriverExpenses_ItemDeleted" OnItemDataBound="rgDriverExpense_ItemDataBound">
                                    <GroupingSettings CaseSensitive="false" />
                                    <MasterTableView DataSourceID="sdsDriverExpenses" DataKeyNames="ExpenseID" CommandItemDisplay="Top">
                                        <EditFormSettings EditFormType="Template">
                                            <FormTemplate>
                                                <h1>Driver Expenses</h1>
                                                <hr />
                                                <asp:Panel ID="Panel1" runat="server" DefaultButton="imgUpdate">
                                                    <table cellpadding="2" cellspacing="2">
                                                        <tr>
                                                            <td align="left" valign="middle">Expense Type:
                                                            </td>
                                                            <td align="left" valign="middle">
                                                                <telerik:RadComboBox ID="rcmbExpenseTypes" runat="server" DataSourceID="sdsExpenseTypes"
                                                                    DataTextField="ExpenseType" DataValueField="ExpenseTypeID" MarkFirstMatch="true"
                                                                    SelectedValue='<%# Eval("ExpenseTypeID") %>' ValidationGroup="DriverExpense"
                                                                    AppendDataBoundItems="true">
                                                                    <Items>
                                                                        <telerik:RadComboBoxItem Text="Select" Value="Select" />
                                                                    </Items>
                                                                </telerik:RadComboBox>
                                                                <span style="color: Red;"><small>*</small></span>
                                                                <asp:RequiredFieldValidator ValidationGroup="DriverExpense" ID="RequiredFieldValidator9"
                                                                    runat="server" ControlToValidate="rcmbExpenseTypes" SetFocusOnError="true" Display="None"
                                                                    ErrorMessage="Select Expense Type"></asp:RequiredFieldValidator>
                                                            </td>
                                                            <td align="left" valign="top" rowspan="4">Notes:
                                                            </td>
                                                            <td align="left" valign="top" rowspan="4">
                                                                <asp:TextBox ID="txtNotes" Text='<%# Eval("Notes") %>' runat="server" TextMode="MultiLine"
                                                                    Width="350px" Height="70px"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left" valign="middle">Expense Date:
                                                            </td>
                                                            <td align="left" valign="middle">
                                                                <telerik:RadDatePicker ID="rdtpExpenseDate" runat="server" Culture="English (United States)"
                                                                    Skin="Sunset" DbSelectedDate='<%# Bind("ExpenseDate") %>'>
                                                                    <Calendar ID="Calendar3" Skin="Sunset" runat="server" UseColumnHeadersAsSelectors="True"
                                                                        UseRowHeadersAsSelectors="True">
                                                                    </Calendar>
                                                                    <DateInput ID="DateInput3" InvalidStyleDuration="100" runat="server" LabelCssClass="radLabelCss_Sunset"
                                                                        Skin="Sunset" Width="" DateFormat="MM-dd-yyyy" DisplayDateFormat="MM-dd-yyyy"
                                                                        Font-Bold="true" ForeColor="Black" ValidationGroup="DriverExpense">
                                                                    </DateInput>
                                                                    <DatePopupButton CssClass="" />
                                                                </telerik:RadDatePicker>
                                                                <span style="color: Red;"><small>*</small></span>
                                                                <asp:RequiredFieldValidator ValidationGroup="DriverExpense" ID="RequiredFieldValidator2"
                                                                    runat="server" ControlToValidate="rdtpExpenseDate" SetFocusOnError="true" Display="None"
                                                                    ErrorMessage="Enter Expense Date"></asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left" valign="middle">Total Amount:
                                                            </td>
                                                            <td align="left" valign="middle">
                                                                <telerik:RadNumericTextBox ID="txtTotalAmount" runat="server" Type="Number" InvalidStyleDuration="100"
                                                                    Text='<%# Eval("TotalAmount") %>' ValidationGroup="DriverExpense">
                                                                    <NumberFormat AllowRounding="True" KeepNotRoundedValue="False" />
                                                                </telerik:RadNumericTextBox>
                                                                <span style="color: Red;"><small>*</small></span>
                                                                <asp:RequiredFieldValidator ValidationGroup="DriverExpense" ID="RequiredFieldValidator1"
                                                                    runat="server" ControlToValidate="txtTotalAmount" SetFocusOnError="true" Display="None"
                                                                    ErrorMessage="Enter Amount"></asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left" valign="middle" colspan="2">
                                                                <asp:ImageButton ValidationGroup="DriverExpense" ID="imgUpdate" runat="server" CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>'
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
                                            <telerik:GridDateTimeColumn DataField="ExpenseDate" HeaderText="Date" SortExpression="ExpenseDate"
                                                UniqueName="ExpenseDate" FilterControlWidth="100px" HeaderStyle-Width="100px"
                                                AllowFiltering="true" DataType="System.DateTime" FilterListOptions="VaryByDataType"
                                                AutoPostBackOnFilter="true" CurrentFilterFunction="EqualTo" DataFormatString="{0:MM-dd-yyyy}">
                                            </telerik:GridDateTimeColumn>
                                            <telerik:GridBoundColumn DataField="ExpenseType" FilterControlAltText="Filter ExpenseType column"
                                                HeaderText="Expense Type" SortExpression="ExpenseType" UniqueName="ExpenseType"
                                                FilterControlWidth="200px" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains">
                                                <HeaderStyle Width="200px" />
                                                <ItemStyle Width="200px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="TotalAmount" FilterControlAltText="Filter TotalAmount column"
                                                HeaderText="Amount" SortExpression="TotalAmount" UniqueName="TotalAmount" FilterControlWidth="70px"
                                                HeaderStyle-Width="70px" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains">
                                                <ItemStyle HorizontalAlign="Right" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridTemplateColumn AllowFiltering="false">
                                                <ItemTemplate>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn AllowFiltering="false" HeaderText="Delete" HeaderStyle-Width="5px">
                                                <ItemStyle HorizontalAlign="Center" />
                                                <ItemTemplate>
                                                    <center>
                                                        <asp:ImageButton ToolTip='<%# ((Eval("IsActive").ToString()=="1")?"Yes":"No") %>'
                                                            ID="imgActive" runat="server" CommandArgument='<%# Eval("ExpenseID") %>' ImageUrl='<%# "~/App_Themes/Blue/images/" + ((Eval("IsActive").ToString()=="1")?"icon_active.png":"icon_deactive.png") %>'
                                                            CausesValidation="false" OnClick="imgActiveDriverExpenses_Click" />
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
                                </telerik:RadGrid>
                            </telerik:RadPageView>
                            <telerik:RadPageView ID="rpvTripPictures" runat="server">
                                <asp:LinkButton ID="OpenImageGalleryLink" Text="View Image Gallery" runat="server" OnClick="OpenImageGalleryLink_Click"></asp:LinkButton>
                                <asp:Panel ID="galleriesPanel"  runat="server">
                                    <telerik:RadImageGallery runat="server" ID="RadImageGallery1" DisplayAreaMode="LightBox" AllowPaging="true" PageSize="1"
                                        Width="200px" Visible="false" OnNeedDataSource="RadImageGallery1_NeedDataSource" DataImageField="ImagePath">
                                        <ImageAreaSettings Height="300px" Width="100px" />                                        
                                    </telerik:RadImageGallery>
                                </asp:Panel>
                                <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
                                    <AjaxSettings>
                                        <telerik:AjaxSetting AjaxControlID="RadGrid1">
                                            <UpdatedControls>
                                                <telerik:AjaxUpdatedControl ControlID="rgTripPictures"></telerik:AjaxUpdatedControl>
                                            </UpdatedControls>
                                        </telerik:AjaxSetting>
                                    </AjaxSettings>
                                </telerik:RadAjaxManager>
                                <telerik:RadGrid PageSize="20" ID="rgTripPictures" runat="server"
                                    AllowPaging="True" AllowAutomaticDeletes="true" AllowAutomaticInserts="false"
                                    AllowAutomaticUpdates="true" ShowStatusBar="true" AllowSorting="True" AutoGenerateColumns="False"
                                    CellSpacing="0" DataSourceID="sdsTripPictures" GridLines="None" Skin="Sunset" OnItemCreated="rgTripPictures_ItemCreated"
                                    OnInsertCommand="rgTripPictures_InsertCommand" OnUpdateCommand="rgTripPictures_UpdateCommand"
                                    OnItemDataBound="rgTripPictures_ItemDataBound" OnItemCommand="rgTripPictures_ItemCommand">
                                    <GroupingSettings CaseSensitive="false" />
                                    <MasterTableView Width="100%" CommandItemDisplay="Top" DataKeyNames="TripImageID">
                                        <Columns>
                                            <telerik:GridEditCommandColumn ButtonType="ImageButton">
                                                <HeaderStyle Width="36px"></HeaderStyle>
                                            </telerik:GridEditCommandColumn>
                                            <telerik:GridTemplateColumn HeaderText="Description" UniqueName="Description" DataField="Description">
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDescription" runat="server" Text='<%# Eval("ImageTitle") %>'></asp:Label>
                                                    <asp:HiddenField ID="hfTripImageID" runat="server" Value='<%# Eval("TripImageID") %>'
                                                        EnableViewState="false" />
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <telerik:RadTextBox ID="txbDescription" Width="300px" runat="server" TextMode="MultiLine" Height="150px" Text='<%# Eval("ImageTitle") %>'>
                                                    </telerik:RadTextBox>
                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Date" UniqueName="Date" DataType="System.DateTime">
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDate" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "ImageDate", "{0:MM/dd/yyyy}") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <telerik:RadDatePicker ID="rdtpImageDate" runat="server"
                                                        Culture="English (United States)" DbSelectedDate='<%# Bind("ImageDate") %>'>
                                                        <Calendar ID="Calendar1" runat="server" EnableKeyboardNavigation="true">
                                                        </Calendar>
                                                        <DateInput ID="DateInput1" runat="server" DateFormat="MM-dd-yyyy">
                                                        </DateInput>
                                                    </telerik:RadDatePicker>
                                                    <span style="color: Red;"><small>*</small></span>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6"
                                                        runat="server" ControlToValidate="rdtpImageDate" SetFocusOnError="true" Display="Static"
                                                        ErrorMessage="Enter Image Date"></asp:RequiredFieldValidator>
                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="Data" HeaderText="Picture" UniqueName="Picture">
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                <ItemTemplate>
                                                    <telerik:RadBinaryImage runat="server" ID="RadBinaryImage1"
                                                        AutoAdjustImageControlSize="false" Height="80px" Width="80px"
                                                        AlternateText="Image not found"></telerik:RadBinaryImage>

                                                    <asp:HiddenField ID="hfTripImagePath" runat="server" Value='<%# Eval("ImagePath") %>'
                                                        EnableViewState="false" />
                                                    <%-- <asp:Image ID="TripImage" Height="80px" Width="80px" runat="server" />--%>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <telerik:RadAsyncUpload runat="server" ID="AsyncUpload1" PostbackTriggers="PerformInsertButton"
                                                        AllowedFileExtensions="jpg,jpeg,png,gif" MaxFileSize="5242880" OnFileUploaded="AsyncUpload1_FileUploaded" MultipleFileSelection="Disabled">
                                                    </telerik:RadAsyncUpload>
                                                    <asp:CustomValidator runat="server" ID="CustomValidator" ClientValidationFunction="validateUpload"
                                                        ErrorMessage="Please upload one valid picture file" />
                                                    <asp:Label ID="ErrorLabel" runat="server"></asp:Label>
                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn AllowFiltering="false" HeaderText="Delete" HeaderStyle-Width="5px">
                                                <ItemStyle HorizontalAlign="Center" />
                                                <ItemTemplate>
                                                    <center>
                                                        <asp:ImageButton ToolTip='<%# ((Eval("IsActive").ToString()=="True")?"Yes":"No") %>'
                                                            ID="imgTripPicturesActive" runat="server" CommandArgument='<%# Eval("TripImageID") %>' ImageUrl='<%# "~/App_Themes/Blue/images/" + ((Eval("IsActive").ToString()=="True")?"icon_active.png":"icon_deactive.png") %>'
                                                            CausesValidation="false" OnClick="imgTripPicturesActive_Click" />
                                                    </center>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                        </Columns>
                                        <EditFormSettings>
                                            <EditColumn ButtonType="ImageButton">
                                            </EditColumn>
                                        </EditFormSettings>
                                        <PagerStyle AlwaysVisible="True"></PagerStyle>
                                    </MasterTableView>
                                </telerik:RadGrid>
                            </telerik:RadPageView>
                        </telerik:RadMultiPage>
                    </FormTemplate>
                </EditFormSettings>
                <HeaderStyle HorizontalAlign="Center" />
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton" EditImageUrl="~/App_Themes/Blue/images/edit.gif"
                        ItemStyle-Width="5px" HeaderText="Edit">
                        <HeaderStyle Width="5px" />
                        <ItemStyle HorizontalAlign="Center" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridBoundColumn DataField="TruckNo" FilterControlAltText="Filter TruckNo column"
                        HeaderText="TruckNo" SortExpression="TruckNo" UniqueName="TruckNo" FilterControlWidth="70px"
                        HeaderStyle-Width="70px" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="LocationName" FilterControlAltText="Filter Location column"
                        HeaderText="Location" SortExpression="LocationName" UniqueName="LocationName" FilterControlWidth="100px"
                        HeaderStyle-Width="100px" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="DriverName" FilterControlAltText="Filter DriverName column"
                        HeaderText="Driver Name" SortExpression="DriverName" UniqueName="DriverName"
                        FilterControlWidth="100px" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains">
                    </telerik:GridBoundColumn>
                    <telerik:GridDateTimeColumn DataField="TripDate" HeaderText="Date" SortExpression="TripDate"
                        UniqueName="TripDate" FilterControlWidth="100px" HeaderStyle-Width="100px" AllowFiltering="true"
                        DataType="System.DateTime" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"
                        CurrentFilterFunction="EqualTo" DataFormatString="{0:MM/dd/yyyy}">
                    </telerik:GridDateTimeColumn>
                    <telerik:GridBoundColumn DataField="TripType" FilterControlAltText="Filter TripType column"
                        HeaderText="TripType" SortExpression="TripType" UniqueName="TripType" FilterControlWidth="70px"
                        HeaderStyle-Width="70px" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="TripStart" FilterControlAltText="Filter TripStart column"
                        HeaderText="TripStart" SortExpression="TripStart" UniqueName="TripStart" FilterControlWidth="70px"
                        HeaderStyle-Width="70px" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="TripEnd" FilterControlAltText="Filter TripEnd column"
                        HeaderText="TripEnd" SortExpression="TripEnd" UniqueName="TripEnd" FilterControlWidth="70px"
                        HeaderStyle-Width="70px" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="StartOdometer" FilterControlAltText="Filter StartOdometer column"
                        HeaderText="StartOdometer" SortExpression="StartOdometer" UniqueName="StartOdometer"
                        FilterControlWidth="70px" HeaderStyle-Width="70px" AutoPostBackOnFilter="true"
                        CurrentFilterFunction="Contains">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="EndOdometer" FilterControlAltText="Filter EndOdometer column"
                        HeaderText="EndOdometer" SortExpression="EndOdometer" UniqueName="EndOdometer"
                        FilterControlWidth="60px" HeaderStyle-Width="70px" AutoPostBackOnFilter="true"
                        CurrentFilterFunction="Contains">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Miles" FilterControlAltText="Filter Miles column"
                        HeaderText="Miles" SortExpression="Miles" UniqueName="Miles"
                        FilterControlWidth="30px" HeaderStyle-Width="25px" AutoPostBackOnFilter="true"
                        CurrentFilterFunction="Contains">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn AllowFiltering="false" HeaderText="Delete" HeaderStyle-Width="5px">
                        <ItemStyle HorizontalAlign="Center" />
                        <ItemTemplate>
                            <center>
                                <asp:ImageButton ToolTip='<%# ((Eval("IsActive").ToString()=="1")?"Yes":"No") %>'
                                    ID="imgActive" runat="server" CommandArgument='<%# Eval("TripID") %>' ImageUrl='<%# "~/App_Themes/Blue/images/" + ((Eval("IsActive").ToString()=="1")?"icon_active.png":"icon_deactive.png") %>'
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
        </telerik:RadGrid>
        <asp:HiddenField runat="server" ID="HiddenField1" />
        <asp:HiddenField runat="server" ID="HiddenField2" />

    </telerik:RadAjaxPanel>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Height="75px"
        Width="75px" Transparency="1">
    </telerik:RadAjaxLoadingPanel>
    <asp:SqlDataSource ID="sdsAddEditRecords" runat="server" ConnectionString="<%$ ConnectionStrings:dbConnString %>"
        UpdateCommand="KRV_UpdateTrips" UpdateCommandType="StoredProcedure" DeleteCommand="KRV_DeleteTrips"
        DeleteCommandType="StoredProcedure" InsertCommand="KRV_AddTrips" InsertCommandType="StoredProcedure"
        SelectCommand="KRV_GetTrips" SelectCommandType="StoredProcedure" CancelSelectOnNullParameter="False"
        OnInserted="Trips_OnInserted">
        <DeleteParameters>
            <asp:Parameter Name="TripID" Type="Int32" DefaultValue="0" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="TripID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="TripDate" Type="DateTime" ConvertEmptyStringToNull="true" />
            <asp:Parameter Name="DriverID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="TruckID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="TripTypeID" Type="Int32" DefaultValue="0"></asp:Parameter>
            <asp:Parameter Name="TripStart" Type="DateTime" ConvertEmptyStringToNull="true" />
            <asp:Parameter Name="TripEnd" Type="DateTime" ConvertEmptyStringToNull="true" />
            <asp:Parameter Name="StartOdometer" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="EndOdometer" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="UserName" Type="String" />
            <asp:Parameter Name="LocationID" Type="Int32" DefaultValue="0" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="TripDate" Type="DateTime" ConvertEmptyStringToNull="true" />
            <asp:Parameter Name="DriverID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="TruckID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="TripTypeID" Type="Int32" DefaultValue="0"></asp:Parameter>
            <asp:Parameter Name="TripStart" Type="DateTime" ConvertEmptyStringToNull="true" />
            <asp:Parameter Name="TripEnd" Type="DateTime" ConvertEmptyStringToNull="true" />
            <asp:Parameter Name="StartOdometer" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="EndOdometer" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="UserName" Type="String" />
            <asp:Parameter Name="LocationID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="TripID" Type="Int32" Direction="InputOutput" DefaultValue="0" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsSoftDelete" runat="server" ConnectionString="<%$ ConnectionStrings:dbConnString %>"
        UpdateCommand="KRV_SoftDeleteTrips" UpdateCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:Parameter Name="TripID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="UserName" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsTrucks" runat="server" ConnectionString="<%$ ConnectionStrings:dbConnString %>"
        SelectCommand="SELECT TruckID,TruckNo FROM Trucks WHERE IsActive=1" SelectCommandType="Text"
        CancelSelectOnNullParameter="false"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsDrivers" runat="server" ConnectionString="<%$ ConnectionStrings:dbConnString %>"
        SelectCommand="SELECT DriverID,DriverName FROM Drivers WHERE IsActive=1" SelectCommandType="Text"
        CancelSelectOnNullParameter="false"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsTripTypes" runat="server" ConnectionString="<%$ ConnectionStrings:dbConnString %>"
        SelectCommand="SELECT TripTypeID,TripType FROM TripTypes WHERE IsActive=1" SelectCommandType="Text"
        CancelSelectOnNullParameter="false"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsTripStops" runat="server" ConnectionString="<%$ ConnectionStrings:dbConnString %>"
        UpdateCommand="KRV_UpdateTripStops" UpdateCommandType="StoredProcedure" DeleteCommand="KRV_DeleteTripStops"
        DeleteCommandType="StoredProcedure" InsertCommand="KRV_AddTripStops" InsertCommandType="StoredProcedure"
        SelectCommand="KRV_GetTripStops" SelectCommandType="StoredProcedure" CancelSelectOnNullParameter="False">
        <SelectParameters>
            <asp:Parameter DefaultValue="0" Name="TripID" Type="Int32" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="StopID" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="StopID" Type="Int32" />
            <asp:Parameter Name="StopIndex" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="CustomerID" Type="Int32" DefaultValue="0"></asp:Parameter>
            <asp:Parameter Name="StopTypeID" Type="Int32" ConvertEmptyStringToNull="true" />
            <asp:Parameter Name="BOLNumber" Type="String" />
            <asp:Parameter Name="SlabsDelivered" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="SlabsPickedUp" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="StopOdometer" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="ArrivalTime" Type="DateTime" ConvertEmptyStringToNull="true" />
            <asp:Parameter Name="DepartureTime" Type="DateTime" ConvertEmptyStringToNull="true" />
            <asp:Parameter Name="UserName" Type="String" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="TripID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="StopIndex" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="CustomerID" Type="Int32" DefaultValue="0"></asp:Parameter>
            <asp:Parameter Name="StopTypeID" Type="Int32" ConvertEmptyStringToNull="true" />
            <asp:Parameter Name="BOLNumber" Type="String" />
            <asp:Parameter Name="SlabsDelivered" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="SlabsPickedUp" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="StopOdometer" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="ArrivalTime" Type="DateTime" ConvertEmptyStringToNull="true" />
            <asp:Parameter Name="DepartureTime" Type="DateTime" ConvertEmptyStringToNull="true" />
            <asp:Parameter Name="UserName" Type="String" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsSoftDeleteTripStops" runat="server" ConnectionString="<%$ ConnectionStrings:dbConnString %>"
        UpdateCommand="KRV_SoftDeleteTripStops" UpdateCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:Parameter Name="StopID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="UserName" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsCustomers" runat="server" ConnectionString="<%$ ConnectionStrings:dbConnString %>"
        SelectCommand="SELECT CustomerID,CustomerName,City,sl.StateName FROM Customers c,StateList sl WHERE c.StateID=sl.StateID AND sl.IsActive=1 AND c.LocationID=@LocationID AND c.IsActive=1 ORDER BY c.CustomerName ASC"
        SelectCommandType="Text" CancelSelectOnNullParameter="false">
        <SelectParameters>
            <asp:Parameter Type="Int32" Name="LocationID" DefaultValue="0" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsStopTypes" runat="server" ConnectionString="<%$ ConnectionStrings:dbConnString %>"
        SelectCommand="SELECT StopTypeID,StopType FROM StopTypes WHERE IsActive=1" SelectCommandType="Text"
        CancelSelectOnNullParameter="false"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsTripRoutes" runat="server" ConnectionString="<%$ ConnectionStrings:dbConnString %>"
        SelectCommand="KRV_GetTripRoutes" SelectCommandType="StoredProcedure" CancelSelectOnNullParameter="false"
        UpdateCommand="KRV_SoftDeleteMultipleTripRoutes" UpdateCommandType="StoredProcedure"
        DeleteCommand="KRV_DeleteTripRoutes" DeleteCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="TripID" Type="Int32" DefaultValue="0" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="TripRouteIDs" Type="String" DefaultValue="" />
            <asp:Parameter Name="UserName" Type="String" />
        </UpdateParameters>
        <DeleteParameters>
            <asp:Parameter Name="TripRouteID" Type="Int32" DefaultValue="0" />
        </DeleteParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsTripRouteNotSelected" runat="server" ConnectionString="<%$ ConnectionStrings:dbConnString %>"
        SelectCommand="KRV_GetTripRoutesNotSelected" SelectCommandType="StoredProcedure"
        CancelSelectOnNullParameter="false" InsertCommand="KRV_AddMultipleTripRoutes"
        InsertCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="TripID" Type="Int32" DefaultValue="0" />
        </SelectParameters>
        <InsertParameters>
            <asp:Parameter Name="TripID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="RouteIDs" Type="String" DefaultValue="" />
            <asp:Parameter Name="UserName" Type="String" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsStateTravelled" runat="server" ConnectionString="<%$ ConnectionStrings:dbConnString %>"
        UpdateCommand="KRV_UpdateStateTravelled" UpdateCommandType="StoredProcedure"
        DeleteCommand="KRV_DeleteStateTravelled" DeleteCommandType="StoredProcedure"
        InsertCommand="KRV_AddStateTravelled" InsertCommandType="StoredProcedure" SelectCommand="KRV_GetStateTravelled"
        SelectCommandType="StoredProcedure" CancelSelectOnNullParameter="False">
        <SelectParameters>
            <asp:Parameter Name="TripID" Type="Int32" DefaultValue="0" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="TravelledID" Type="Int32" DefaultValue="0" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="TravelledID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="StateID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="StartOdometer" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="EndOdometer" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="UserName" Type="String" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="TripID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="StateID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="StartOdometer" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="EndOdometer" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="UserName" Type="String" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsSoftDeleteStateTravelled" runat="server" ConnectionString="<%$ ConnectionStrings:dbConnString %>"
        UpdateCommand="KRV_SoftDeleteStateTravelled" UpdateCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:Parameter Name="TravelledID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="UserName" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsStateName" runat="server" ConnectionString="<%$ ConnectionStrings:dbConnString %>"
        SelectCommand="SELECT StateID,StateName FROM StateList WHERE IsActive=1" SelectCommandType="Text"
        CancelSelectOnNullParameter="false"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsIncidentTypes" runat="server" ConnectionString="<%$ ConnectionStrings:dbConnString %>"
        SelectCommand="SELECT IncidentTypeID,IncidentType FROM IncidentTypes WHERE IsActive=1"
        SelectCommandType="Text" CancelSelectOnNullParameter="false"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsTripIncidents" runat="server" ConnectionString="<%$ ConnectionStrings:dbConnString %>"
        UpdateCommand="KRV_UpdateTripIncidents" UpdateCommandType="StoredProcedure"
        DeleteCommand="KRV_DeleteTripIncidents" DeleteCommandType="StoredProcedure"
        InsertCommand="KRV_AddTripIncidents" InsertCommandType="StoredProcedure" SelectCommand="KRV_GetTripIncidents"
        SelectCommandType="StoredProcedure" CancelSelectOnNullParameter="False">
        <SelectParameters>
            <asp:Parameter Name="TripID" Type="Int32" DefaultValue="0" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="IncidentID" Type="Int32" DefaultValue="0" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="IncidentID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="IncidentDate" Type="DateTime" ConvertEmptyStringToNull="true" />
            <asp:Parameter Name="IncidentTypeID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="StateID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="Remarks" Type="String" />
            <asp:Parameter Name="UserName" Type="String" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="TripID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="IncidentDate" Type="DateTime" ConvertEmptyStringToNull="true" />
            <asp:Parameter Name="IncidentTypeID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="StateID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="Remarks" Type="String" />
            <asp:Parameter Name="UserName" Type="String" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsSoftDeleteTripIncident" runat="server" ConnectionString="<%$ ConnectionStrings:dbConnString %>"
        UpdateCommand="KRV_SoftDeleteTripIncidents" UpdateCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:Parameter Name="IncidentID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="UserName" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsExpenseTypes" runat="server" ConnectionString="<%$ ConnectionStrings:dbConnString %>"
        SelectCommand="Select ExpenseTypeID,ExpenseType FROM ExpenseTypes WHERE IsActive=1"
        SelectCommandType="Text" CancelSelectOnNullParameter="false"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsDriverExpenses" runat="server" ConnectionString="<%$ ConnectionStrings:dbConnString %>"
        UpdateCommand="KRV_UpdateDriverExpenses" UpdateCommandType="StoredProcedure"
        DeleteCommand="KRV_DeleteDriverExpenses" DeleteCommandType="StoredProcedure"
        InsertCommand="KRV_AddDriverExpenses" InsertCommandType="StoredProcedure" SelectCommand="KRV_GetDriverExpenses"
        SelectCommandType="StoredProcedure" CancelSelectOnNullParameter="False">
        <SelectParameters>
            <asp:Parameter Name="TripID" Type="Int32" DefaultValue="0" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="ExpenseID" Type="Int32" DefaultValue="0" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="ExpenseID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="DriverID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="ExpenseDate" Type="DateTime" ConvertEmptyStringToNull="true" />
            <asp:Parameter Name="ExpenseTypeID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="TotalAmount" Type="Decimal" DefaultValue="0" />
            <asp:Parameter Name="UserName" Type="String" />
            <asp:Parameter Name="Notes" Type="String" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="TripID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="DriverID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="ExpenseDate" Type="DateTime" ConvertEmptyStringToNull="true" />
            <asp:Parameter Name="ExpenseTypeID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="TotalAmount" Type="Decimal" DefaultValue="0" />
            <asp:Parameter Name="UserName" Type="String" />
            <asp:Parameter Name="Notes" Type="String" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsSoftDeleteDriverExpenses" runat="server" ConnectionString="<%$ ConnectionStrings:dbConnString %>"
        UpdateCommand="KRV_SoftDeleteDriverExpenses" UpdateCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:Parameter Name="ExpenseID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="UserName" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsLocations" runat="server" ConnectionString="<%$ ConnectionStrings:dbConnString %>"
        SelectCommand="SELECT LocationID,LocationName FROM Locations WHERE IsActive=1"
        SelectCommandType="Text" CancelSelectOnNullParameter="false"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsGetTruckLocation" runat="server" ConnectionString="<%$ ConnectionStrings:dbConnString %>"
        SelectCommand="GetTruckLocation" SelectCommandType="StoredProcedure" CancelSelectOnNullParameter="false">
        <SelectParameters>
            <asp:Parameter Name="TruckNo" Type="String" DefaultValue="0" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsTripPictures" runat="server" ConnectionString="<%$ ConnectionStrings:dbConnString %>"
        SelectCommand="KRV_GetTripPictures" SelectCommandType="StoredProcedure" InsertCommand="KRV_AddTripPictures" InsertCommandType="StoredProcedure"
        UpdateCommand="KRV_UpdateTripPictures" UpdateCommandType="StoredProcedure" CancelSelectOnNullParameter="false">
        <SelectParameters>
            <asp:Parameter Name="TripID" Type="String" DefaultValue="0" />
        </SelectParameters>
        <InsertParameters>
            <%--<asp:Parameter Name="TripID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="ImagePath" Type="String" />
            <asp:Parameter Name="ImageTitle" Type="String" />
            <asp:Parameter Name="UserName" Type="String" />
            <asp:Parameter Name="ImageDate" type="DateTime" ConvertEmptyStringToNull="true" />--%>
        </InsertParameters>
        <UpdateParameters>
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsSoftDeleteTripPictures" runat="server" ConnectionString="<%$ ConnectionStrings:dbConnString %>"
        UpdateCommand="KRV_SoftDeleteTripPictures" UpdateCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:Parameter Name="TripImageID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="UserName" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsGetDefaultLocation" runat="server" ConnectionString="<%$ ConnectionStrings:dbConnString %>"
        SelectCommand="SELECT LocationID FROM Drivers WHERE DriverID=@DriverID"
        SelectCommandType="Text" CancelSelectOnNullParameter="false">
        <SelectParameters>
            <asp:Parameter Type="Int32" Name="DriverID" DefaultValue="0" />
        </SelectParameters>
    </asp:SqlDataSource>   
</asp:Content>
