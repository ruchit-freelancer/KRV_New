<%@ Page Title="" Language="C#" MasterPageFile="~/KRV.master" AutoEventWireup="true"
    CodeFile="Default.aspx.cs" Inherits="Default" %>

<asp:Content ID="Content3" ContentPlaceHolderID="cphHeadTitle" runat="Server">
    Welcome to KRV Trip Portal
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphContent" runat="Server">
    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
        <telerik:RadPivotGrid ID="RadPivotGrid1" runat="server" DataSourceID="SqlDataSource1" ClientSettings-EnableFieldsDragDrop="true" AllowPaging="True" AllowSorting="True" Skin="Sunset" AggregatesLevel="1" >
            <PagerStyle ChangePageSizeButtonToolTip="Change Page Size" PageSizeControlType="RadComboBox" />
           
            <Fields>
                <telerik:PivotGridRowField CellStyle-Width="13%" DataField="TripDate" SortOrder="Descending" UniqueName="column2">
                    <CellStyle Width="13%" />
                </telerik:PivotGridRowField>
                <telerik:PivotGridColumnField DataField="LocationName" UniqueName="column3">
                    <CellStyle Width="10%" />
                </telerik:PivotGridColumnField>
                <telerik:PivotGridAggregateField CalculationExpression="" Caption="D >" DataField="SlabsDelivered" GrandTotalAggregateFormatString="" UniqueName="column1">
                    <TotalFormat Axis="Columns" Level="0" SortOrder="Ascending" TotalFunction="NoCalculation" />
                    <CellStyle Width="5%" />
                    <HeaderCellTemplate>
                        <asp:Label ID="SlabsDeliveredLabel" runat="server" Text="D >"></asp:Label>
                    </HeaderCellTemplate>
                    <ColumnGrandTotalHeaderCellTemplate>
                        <asp:Label ID="SlabsDeliveredHeaderTotalColumnLabel" runat="server" Text="Total D >"></asp:Label>
                    </ColumnGrandTotalHeaderCellTemplate>
                </telerik:PivotGridAggregateField>
                <telerik:PivotGridAggregateField CalculationExpression="" Caption="> P" DataField="SlabsPickedUp" GrandTotalAggregateFormatString="" UniqueName="column">
                    <TotalFormat Axis="Rows" GroupName="SlabsPickedUp" Level="0" SortOrder="Ascending" TotalFunction="NoCalculation" />
                    <CellStyle Width="5%" />
                    <HeaderCellTemplate>
                        <asp:Label ID="SlabsPickedUpLabel" runat="server" Text="> P"></asp:Label>
                    </HeaderCellTemplate>
                    <ColumnGrandTotalHeaderCellTemplate>
                        <asp:Label ID="SlabsDeliveredHeaderTotalLabel" runat="server" Text="Total > P"></asp:Label>
                    </ColumnGrandTotalHeaderCellTemplate>
                </telerik:PivotGridAggregateField>
             
            </Fields>
            <ClientSettings EnableFieldsDragDrop="True">
            </ClientSettings>
        </telerik:RadPivotGrid>
    </telerik:RadAjaxPanel>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Height="75px"
          Width="75px" Transparency="1">
     </telerik:RadAjaxLoadingPanel>
    <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:Reports.Properties.Settings.KRV %>' SelectCommand="KRV_Dashboard" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
</asp:Content>
