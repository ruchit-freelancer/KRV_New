<%@ Page Title="" Language="C#" MasterPageFile="~/KRV.master" AutoEventWireup="true"
    CodeFile="TruckMaintenanceNew.aspx.cs" Inherits="Dashboard" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">


        function exportRadPivotGrid() {
            var exp = $find("<%=RadClientExportManager1.ClientID%>");
            exp.exportPDF($telerik.$(<%=RadPivotGrid1.ClientID%>));
            //exp.exportPDF($telerik.$(".foo"));
        }
    </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphHeadTitle" runat="Server">
    REPORT: TRUCK MAINTENANCE
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphContent" runat="Server">
    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
        <telerik:RadButton ID="ExportToPDFButton" runat="server" OnClientClicked="exportRadPivotGrid" Text="Export Report to PDF" AutoPostBack="false" UseSubmitBehavior="false"></telerik:RadButton>
        <br />
        <telerik:RadClientExportManager runat="server" ID="RadClientExportManager1">
            <PdfSettings FileName="TruckMaintenanceReport.pdf" />
        </telerik:RadClientExportManager>
        <div class="foo">
            <telerik:RadPivotGrid ID="RadPivotGrid1" OnCellDataBound="RadPivotGrid1_CellDataBound" runat="server" DataSourceID="SqlDataSource1" ClientSettings-EnableFieldsDragDrop="true" AllowSorting="True" Skin="Sunset" RenderMode="Classic" ColumnGroupsDefaultExpanded="False">
                <PagerStyle PageSizeControlType="None" />
                <Fields>
                    <telerik:PivotGridRowField UniqueName="column2" DataField="City" SortOrder="Ascending">
                    </telerik:PivotGridRowField>
                    <telerik:PivotGridRowField UniqueName="column4" DataField="TruckNo" SortOrder="Ascending">
                    </telerik:PivotGridRowField>
                    <telerik:PivotGridRowField UniqueName="column5" DataField="MaintenanceYear" SortOrder="Descending" Caption="Year">
                    </telerik:PivotGridRowField>
                    <telerik:PivotGridRowField UniqueName="column6" DataField="MaintenanceMonth" SortOrder="Descending" Caption="Month">
                    </telerik:PivotGridRowField>
                    <telerik:PivotGridColumnField UniqueName="column3" DataField="ShortName"></telerik:PivotGridColumnField>

                    <telerik:PivotGridAggregateField GrandTotalAggregateFormatString="" CalculationExpression="" UniqueName="column1" DataField="TotalCost" DataFormatString="{0:C3}">
                        <TotalFormat Level="0" Axis="Rows" TotalFunction="NoCalculation" SortOrder="Ascending"></TotalFormat>
                        <CellStyle Width="20%" />
                        <HeaderCellTemplate>
                            <asp:Label ID="TotalCostLabel" runat="server" Text="Total Cost"></asp:Label>
                        </HeaderCellTemplate>
                        <ColumnGrandTotalHeaderCellTemplate>
                            <asp:Label ID="TotalCostTotalLabel" runat="server" Text="Grand Total"></asp:Label>
                        </ColumnGrandTotalHeaderCellTemplate>
                    </telerik:PivotGridAggregateField>

                </Fields>
            </telerik:RadPivotGrid>
        </div>
    </telerik:RadAjaxPanel>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Height="75px"
        Width="75px" Transparency="1">
    </telerik:RadAjaxLoadingPanel>
    <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:Reports.Properties.Settings.KRV %>' SelectCommand="KRV_Report_TruckMaintenance" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
</asp:Content>

