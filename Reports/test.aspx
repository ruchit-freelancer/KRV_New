<%@ Page Title="" Language="C#" MasterPageFile="~/KRV.master" AutoEventWireup="true"
    CodeFile="test.aspx.cs" Inherits="Reports_test" %>

<%@ Register Assembly="Telerik.ReportViewer.WebForms,Version=9.0.15.225, Culture=neutral, PublicKeyToken=a9d7983dfcc261be"
    Namespace="Telerik.ReportViewer.WebForms" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .wrap
        {
            width: 1000px;
        }

        .cfgContent
        {
            overflow: hidden;
        }

        .clearfix
        {
            content: '';
            clear: both;
            display: block;
        }

        .thumbnailMode
        {
            float: right;
        }

        .config
        {
            margin-left: 40px;
        }

        .config,
        .galleries,
        .contentMode
        {
            float: left;
        }

        .contentMode
        {
            margin-right: 20px;
        }

        /*IE7 fix*/
        .RadImageGallery
        {
            z-index: 99997;
        }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphHeadTitle" runat="Server">
    Image Gallery
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphContent" runat="Server">
    
    <telerik:RadSkinManager ID="RadSkinManager1" runat="server" ShowChooser="true" />
    <div class="wrap demo-container size-medium">
        <div class="galleries">
            <asp:Panel ID="galleriesPanel" CssClass="galleries" runat="server">
                <telerik:RadImageGallery runat="server" ID="RadImageGallery1" DisplayAreaMode="LightBox"
                    Width="400px" ImagesFolderPath="~/Images">
                    <ImageAreaSettings Height="300px" />
                    <%--<ThumbnailsAreaSettings ThumbnailsSpacing="1px" Height="304" ShowScrollbar="true"
                        ShowScrollButtons="false" />--%>
                </telerik:RadImageGallery>
            </asp:Panel>
        </div>
    </div>
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" UpdatePanelRenderMode="Block">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="ConfiguratorPanel">
                <UpdatedControls>                   
                    <telerik:AjaxUpdatedControl ControlID="galleriesPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel runat="server" ID="RadAjaxLoadingPanel1">
    </telerik:RadAjaxLoadingPanel>
</asp:Content>
