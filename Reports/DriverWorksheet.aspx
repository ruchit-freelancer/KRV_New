<%@ Page Title="" Language="C#" MasterPageFile="~/KRV.master" AutoEventWireup="true"
    CodeFile="DriverWorksheet.aspx.cs" Inherits="Reports_DriverWorksheet" %>

<%@ Register Assembly="Telerik.ReportViewer.WebForms, Version=9.0.15.225, Culture=neutral, PublicKeyToken=a9d7983dfcc261be"
    Namespace="Telerik.ReportViewer.WebForms" TagPrefix="telerik" %>
<asp:Content ID="Content3" ContentPlaceHolderID="cphHeadTitle" runat="Server">
    REPORT: DRIVER WORKSHEET
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphContent" runat="Server">
    <telerik:ReportViewer ID="ReportViewer1" runat="server" Width="100%" Height="768px"
        ZoomMode="FullPage">
    </telerik:ReportViewer>
</asp:Content>
