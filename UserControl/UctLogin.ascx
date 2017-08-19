<%@ Control Language="C#" AutoEventWireup="true" CodeFile="UctLogin.ascx.cs" Inherits="UserControls_UctLogin" %>
<asp:Panel ID="PanelLoginIN" runat="server">
    <table>
        <tr>
            <td align="center" rowspan="2">
                <asp:Login ID="Login1" runat="server" OnAuthenticate="Login1_Authenticate" FailureTextStyle-CssClass="FailureMessage">
                    <LayoutTemplate>
                        <table border="0" cellpadding="1" cellspacing="0" style="border-collapse: collapse">
                            <tr>
                                <td>
                                    <table border="0" cellpadding="0" cellspacing="6" width="100%">
                                        <tr>
                                            <td colspan="2" align="left" style="height: 30px;">
                                                <div style="float: left; position: relative;">
                                                    <asp:Image CssClass="NormalHeading" ID="imgKey" runat="server" OnInit="imgKey_OnInit" />
                                                </div>
                                                <div style="float: left; position: relative;">
                                                    <h1>
                                                        Log In</h1>
                                                    <br />
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="UserNameLabel" runat="server" CssClass="NormalText" AssociatedControlID="UserName">User Name</asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="UserName" runat="server"></asp:TextBox>
                                                <asp:RequiredFieldValidator runat="server" ID="rfvUserName" ControlToValidate="UserName"
                                                    ErrorMessage="*" Display="Dynamic"></asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="PasswordLabel" runat="server" CssClass="NormalText" AssociatedControlID="Password">Password</asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="Password" runat="server" TextMode="Password"></asp:TextBox>
                                                <asp:RequiredFieldValidator runat="server" ID="rfvPassword" ControlToValidate="Password"
                                                    ErrorMessage="*" Display="Dynamic"></asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center" colspan="2" style="color: red" class="FailureMessage">
                                                <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" colspan="2">
                                                <asp:Button ID="LoginButton" runat="server" CommandName="Login" CssClass="Button"
                                                    Text="Log In" ValidationGroup="Login1" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </LayoutTemplate>
                </asp:Login>
            </td>
    </table>
</asp:Panel>
