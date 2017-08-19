<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="UserControl/UctLogin.ascx" TagName="UctLogin" TagPrefix="uc1" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Welcome to KRV Trip Portal</title>
    <telerik:RadStyleSheetManager ID="RadStyleSheetManager1" runat="server" />
    <link href="App_Themes/Blue/Blue.css" rel="stylesheet" type="text/css" />
</head>
<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
    <form id="form1" runat="server">
    <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
        <Scripts>
            <%--Needed for JavaScript IntelliSense in VS2010--%>
            <%--For VS2008 replace RadScriptManager with ScriptManager--%>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
        </Scripts>
    </telerik:RadScriptManager>

    <script type="text/javascript">
        //Put your JavaScript code here.
    </script>

    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
    </telerik:RadAjaxManager>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td align="right" class="top" valign="middle">
                Welcome to KRV Trip Portal
            </td>
        </tr>
        <tr>
            <td align="left" valign="top" class="headTitle">
                Login
            </td>
        </tr>
        <tr>
            <td align="left" valign="top" class="content">
                <uc1:UctLogin ID="UctLogin1" runat="server" />
            </td>
        </tr>
        <tr>
            <td align="left" valign="top" class="footer">
                KRV Trucking, LLC | 195 Prospect Plains Road, Monroe, NJ 08831
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
