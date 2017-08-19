<%@ Page Language="C#" MasterPageFile="~/KRV.master" AutoEventWireup="true" CodeFile="ChangePassword.aspx.cs"
    Inherits="UserManagement_ChangePassword" %>

<%@ Register Src="~/UserControl/UctMessageDetails.ascx" TagName="UctMessageDetails"
    TagPrefix="uc1" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphHeadTitle" runat="Server">
    Change Password
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphContent" runat="Server">
    <table width="100%" align="center">
        <tr>
            <td align="center">
                <uc1:UctMessageDetails ID="uctMessage" runat="server" Visible="false" />
            </td>
        </tr>
    </table>
    <asp:Panel ID="pnlChangePassword" runat="server">
        <table border="0" cellpadding="3" cellspacing="3">
            <tr>
                <td align="right">
                    Old Password
                </td>
                <td>
                    <asp:TextBox ID="CurrentPassword" runat="server" TextMode="Password"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="CurrentPasswordRequired" runat="server" ControlToValidate="CurrentPassword"
                        ErrorMessage="Password is required." ToolTip="Password is required." ValidationGroup="ChangePassword1">*</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td align="right">
                    New Password
                </td>
                <td>
                    <asp:TextBox ID="NewPassword" runat="server" TextMode="Password"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="NewPasswordRequired" runat="server" ControlToValidate="NewPassword"
                        ErrorMessage="New Password is required." ToolTip="New Password is required."
                        ValidationGroup="ChangePassword1">*</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Confirm Password
                </td>
                <td>
                    <asp:TextBox ID="ConfirmNewPassword" runat="server" TextMode="Password"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="ConfirmNewPasswordRequired" runat="server" ControlToValidate="ConfirmNewPassword"
                        ErrorMessage="Confirm New Password is required." ToolTip="Confirm New Password is required."
                        ValidationGroup="ChangePassword1">*</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td align="center" colspan="2">
                    <asp:CompareValidator ID="NewPasswordCompare" runat="server" ControlToCompare="NewPassword"
                        ControlToValidate="ConfirmNewPassword" Display="Dynamic" ErrorMessage="The Confirm New Password must match the New Password entry."
                        ValidationGroup="ChangePassword1"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td align="center" colspan="2" style="color: Red;">
                    <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                </td>
            </tr>
            <tr>
                <td align="center" colspan="2">
                    <asp:Button ID="ChangePasswordPushButton" runat="server" CommandName="ChangePassword"
                        OnClick="ChangePasswordPushButton_Click" Text="Save" ValidationGroup="ChangePassword1" />
                </td>
            </tr>
        </table>
    </asp:Panel>
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="ChangePasswordPushButton">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="uctMessage" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="pnlChangePassword" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Height="75px"
        Width="75px" Transparency="1">
        <img alt="Loading..." src='<%= RadAjaxLoadingPanel.GetWebResourceUrl(Page, "Telerik.Web.UI.Skins.Default.Ajax.loading.gif") %>'
            style="border: 0;" />
    </telerik:RadAjaxLoadingPanel>
</asp:Content>
