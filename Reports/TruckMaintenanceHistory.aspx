<%@ Page Language="C#" MasterPageFile="~/KRV.master" AutoEventWireup="true" CodeFile="TruckMaintenanceHistory.aspx.cs" Inherits="Reports_TruckMaintenanceHistory" %>

<asp:Content ID="Content3" ContentPlaceHolderID="cphHeadTitle" runat="Server">
    Truck Maintenance History
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphContent" runat="Server">
    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
        <telerik:RadGrid PageSize="20" ID="rgSearch" runat="server" AllowFilteringByColumn="True"
            AllowPaging="True" AllowAutomaticDeletes="false" AllowAutomaticInserts="false"
            AllowAutomaticUpdates="false" ShowStatusBar="true" AllowSorting="True" AutoGenerateColumns="False"
            CellSpacing="0" DataSourceID="sdsTruckMaintenanceHistory" GridLines="None" Skin="Sunset">
            <MasterTableView DataSourceID="sdsTruckMaintenanceHistory" DataKeyNames="" CommandItemDisplay="None">
                <Columns>                  
                    <telerik:GridBoundColumn DataField="TruckNo" FilterControlAltText="Filter TruckNo column"
                        HeaderText="TruckNo" SortExpression="TruckNo" UniqueName="TruckNo" FilterControlWidth="50px"
                        HeaderStyle-Width="8%" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="TruckLocation" FilterControlAltText="Filter TruckLocation column"
                        HeaderText="Truck Location" SortExpression="TruckLocation" UniqueName="TruckLocation"
                        FilterControlWidth="70px" HeaderStyle-Width="8%" AutoPostBackOnFilter="true"
                        CurrentFilterFunction="Contains">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MakeAndModel" FilterControlAltText="Filter MakeAndModel column"
                        HeaderText="Make And Model" SortExpression="MakeAndModel" UniqueName="MakeAndModel" FilterControlWidth="140px"
                        HeaderStyle-Width="12%" ItemStyle-Width="80px" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains">
                    </telerik:GridBoundColumn>
                    <telerik:GridDateTimeColumn DataField="NextCraneInspectionDate" 
                        HeaderText="Next Crane Inspection Date" SortExpression="NextCraneInspectionDate" UniqueName="Make" AllowFiltering="true"
                        HeaderStyle-Width="15%" FilterControlWidth="100px" DataType="System.DateTime" 
                        FilterListOptions="VaryByDataType"  DataFormatString="{0:MM-dd-yyyy}" CurrentFilterFunction="EqualTo">
                    </telerik:GridDateTimeColumn>
                    <telerik:GridDateTimeColumn DataField="NextDOTAnnualDate" 
                        HeaderText="Next DOT Annual Date" SortExpression="NextDOTAnnualDate" UniqueName="NextDOTAnnualDate"  AllowFiltering="true"
                        HeaderStyle-Width="12%"  FilterControlWidth="100px" DataType="System.DateTime" 
                        FilterListOptions="VaryByDataType"  DataFormatString="{0:MM-dd-yyyy}" CurrentFilterFunction="EqualTo" >
                    </telerik:GridDateTimeColumn>
                    <telerik:GridDateTimeColumn DataField="LastPMDate" 
                        HeaderText="Last PM Date" SortExpression="LastPMDate" UniqueName="LastPMDate" AllowFiltering="true"
                        FilterControlWidth="100px" HeaderStyle-Width="8%" DataType="System.DateTime" FilterListOptions="VaryByDataType" DataFormatString="{0:MM-dd-yyyy}" 
                        CurrentFilterFunction="EqualTo">
                    </telerik:GridDateTimeColumn>
                    <telerik:GridBoundColumn DataField="LastPMMilage" FilterControlAltText="Filter LastPMMilage column"
                        HeaderText="Last PM Milage" SortExpression="LastPMMilage" UniqueName="LastPMMilage" AllowFiltering="false"
                        HeaderStyle-Width="10%">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="NextPMMilage" HeaderText="Next PM Milage" SortExpression="NextPMMilage"
                        UniqueName="NextPMMilage"  AllowFiltering="false" HeaderStyle-Width="10%">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="CurrentMilage" HeaderText="Current Milage" SortExpression="CurrentMilage"
                        UniqueName="CurrentMilage"  AllowFiltering="false" HeaderStyle-Width="9%">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MilesToPM" HeaderText="Miles To PM" SortExpression="MilesToPM"
                        UniqueName="MilesToPM"  AllowFiltering="false" HeaderStyle-Width="8%">
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
            <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
            <FilterMenu EnableImageSprites="False">
            </FilterMenu>
        </telerik:RadGrid>
    </telerik:RadAjaxPanel>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Height="75px"
        Width="75px" Transparency="1">
    </telerik:RadAjaxLoadingPanel>
    <asp:SqlDataSource ID="sdsTruckMaintenanceHistory" runat="server" ConnectionString="<%$ ConnectionStrings:dbConnString %>"
        SelectCommand="KRV_TruckMaintenanceHistory" SelectCommandType="StoredProcedure" CancelSelectOnNullParameter="false"></asp:SqlDataSource>
</asp:Content>
