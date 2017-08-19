<%@ Control Language="C#" AutoEventWireup="true" CodeFile="UctMenu.ascx.cs" Inherits="UserControls_UctMenu" %>
<telerik:RadMenu ID="RadMenu1" runat="server" Width="100%" Skin="Black" DataSourceID="sdsMenu"
    Style="position: absolute;" DataTextField="TitleDisp" DataValueField="MenuID" DataFieldID="MenuID"
    DataFieldParentID="ParentID" DataNavigateUrlField="link" OnItemClick="RadMenu1_ItemClick"
    OnItemDataBound="RadMenu1_ItemDataBound">
</telerik:RadMenu>
<asp:SqlDataSource ID="sdsMenu" runat="server" ConnectionString="<%$ ConnectionStrings:dbConnString %>"
    SelectCommand="KRV_GetMenu" SelectCommandType="StoredProcedure" CancelSelectOnNullParameter="false">
    <SelectParameters>
        <asp:Parameter Name="UserName" Type="String" ConvertEmptyStringToNull="true" />
    </SelectParameters>
</asp:SqlDataSource>
<%--<telerik:RadMenu ID="rMenu" runat="server" Width="100%" Skin="Black" DataSourceID="sdsGetMenu"
    Style="position: absolute;">
</telerik:RadMenu>
<asp:SiteMapDataSource ID="sdsGetMenu" runat="server" ShowStartingNode="false" />--%>
