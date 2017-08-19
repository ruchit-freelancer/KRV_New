<%@ Page Language="C#" MasterPageFile="~/KRV.master" AutoEventWireup="true" CodeFile="AddEditUsers.aspx.cs"
    Inherits="UserManagement_AddEditUsers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHeadTitle" runat="Server">
    User Manager
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="cphContent" runat="Server">
    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
        <telerik:RadGrid PageSize="20" ID="rgSearch" runat="server" AllowFilteringByColumn="True"
            AllowPaging="True" AllowAutomaticDeletes="true" AllowAutomaticInserts="false"
            AllowAutomaticUpdates="true" ShowStatusBar="true" AllowSorting="True" AutoGenerateColumns="False"
            CellSpacing="0" DataSourceID="sdsGetUsers" GridLines="None" Skin="Sunset" OnInsertCommand="RadGrid1_InsertCommand"
            OnUpdateCommand="RadGrid1_UpdateCommand" OnItemDataBound="RadGrid1_ItemDataBound">
            <GroupingSettings CaseSensitive="false" />
            <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Default">
            </HeaderContextMenu>
            <MasterTableView DataSourceID="sdsGetUsers" DataKeyNames="UserID" CommandItemDisplay="Top">
                <EditFormSettings EditFormType="Template">
                    <FormTemplate>
                        <h1>
                            User Details</h1>
                        <asp:HiddenField ID="hfUserID" runat="server" Value='<%# Bind("UserID") %>' />
                        <asp:HiddenField ID="hfRoleName" runat="server" Value='<%# Bind("RoleName") %>' />
                        <hr />
                        <asp:Panel ID="Panel1" runat="server" DefaultButton="imgUpdate">
                            <table cellpadding="2" cellspacing="2">
                                <tr>
                                    <td align="right" valign="middle">
                                        User/Login Name:
                                    </td>
                                    <td align="left" valign="top">
                                        <asp:TextBox ID="txtUserName" Text='<%# Bind("UserName") %>' runat="server" TabIndex="1"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvUserName" Display="Dynamic" SetFocusOnError="true"
                                            ControlToValidate="txtUserName" runat="server" ErrorMessage="Enter Username"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <asp:Panel ID="pnlUsers" runat="server">
                                    <tr>
                                        <td align="right" valign="middle">
                                            Password :
                                        </td>
                                        <td align="left" valign="top">
                                            <asp:TextBox ID="txtPassword" Text='<%# Bind("Password") %>' TabIndex="2" runat="server"
                                                TextMode="Password"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="frvPassword" Display="Dynamic" SetFocusOnError="true"
                                                ControlToValidate="txtPassword" runat="server" ErrorMessage="Enter Password"></asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right" valign="middle">
                                            Confirm Password :
                                        </td>
                                        <td align="left" valign="top">
                                            <asp:TextBox ID="txtCPassword" Text='<%# Bind("Password") %>' TabIndex="3" runat="server"
                                                TextMode="Password"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvCPassword" Display="Dynamic" SetFocusOnError="true"
                                                ControlToValidate="txtCPassword" runat="server" ErrorMessage="Enter Confirm Password"></asp:RequiredFieldValidator>
                                            <asp:CompareValidator ID="CompareValidator1" Display="Dynamic" SetFocusOnError="true"
                                                ControlToCompare="txtPassword" ControlToValidate="txtCPassword" runat="server"
                                                ErrorMessage="Invalid Confirm Password"></asp:CompareValidator>
                                        </td>
                                    </tr>
                                </asp:Panel>
                                <tr>
                                    <td align="right" valign="middle">
                                        Email:
                                    </td>
                                    <td align="left" valign="top">
                                        <asp:TextBox ID="txtEmail" Text='<%# Bind("Email") %>' runat="server" TabIndex="4"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator10" Display="Dynamic" SetFocusOnError="true"
                                            ControlToValidate="txtEmail" runat="server" ErrorMessage="Enter Email"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Invalid Email"
                                            ControlToValidate="txtEmail" Display="Dynamic" SetFocusOnError="true" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" valign="middle">
                                        Role :
                                    </td>
                                    <td align="left" valign="top">
                                        <telerik:RadComboBox ID="rcbRole" runat="server" DataSourceID="sdsRoles" DataTextField="RoleName"
                                            DataValueField="RoleID" MarkFirstMatch="true" Skin="Sunset" Width="250px" TabIndex="5"
                                            SelectedValue='<%# Bind("RoleID") %>'>
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ControlToValidate="rcbRole" SetFocusOnError="true" Display="None"
                                            ID="RequiredFieldValidator11" InitialValue="Select" runat="server" ErrorMessage="*">
                                        </asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" valign="top" colspan="4">
                                        <asp:ImageButton ID="imgUpdate" TabIndex="6" runat="server" CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>'
                                            AlternateText="Update" ToolTip="Update" ImageUrl="~/App_Themes/Blue/images/savebutton.gif" />
                                        <asp:ImageButton ID="imgCancel" runat="server" TabIndex="7" CommandName="Cancel"
                                            AlternateText="Cancel" ToolTip="Cancel" ImageUrl="~/App_Themes/Blue/images/cancelbutton.gif"
                                            CausesValidation="false" />
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </FormTemplate>
                </EditFormSettings>
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton" EditImageUrl="../App_Themes/Blue/images/edit.gif"
                        ItemStyle-Width="5px" HeaderText="Edit">
                        <HeaderStyle Width="5px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridBoundColumn DataField="UserName" FilterControlAltText="Filter UserName column"
                        HeaderText="LoginName" SortExpression="UserName" UniqueName="UserName" FilterControlWidth="150px"
                        HeaderStyle-Width="150px" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="RoleName" FilterControlAltText="Filter RoleName column"
                        HeaderText="Role" SortExpression="RoleName" UniqueName="RoleName" FilterControlWidth="150px"
                        HeaderStyle-Width="150px" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Email" FilterControlAltText="Filter Email column"
                        HeaderText="Email" SortExpression="Email" UniqueName="Email" FilterControlWidth="150px"
                        HeaderStyle-Width="150px" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="LastLoginDate" FilterControlAltText="Filter LastLoginDate column"
                        HeaderText="LastLoginDate" SortExpression="LastLoginDate" UniqueName="LastLoginDate"
                        FilterControlWidth="100px" HeaderStyle-Width="100px" AutoPostBackOnFilter="true"
                        CurrentFilterFunction="Contains">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn HeaderText="Reset" HeaderStyle-Width="5px">
                        <ItemTemplate>
                            <center>
                                <asp:ImageButton ID="imgReset" runat="server" CommandArgument='<%# Eval("UserName") %>'
                                    OnClick="imgReset_Click" ImageUrl="~/App_Themes/Blue/images/key.png" CausesValidation="false" />
                            </center>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Lock" HeaderStyle-Width="5px">
                        <ItemTemplate>
                            <center>
                                <asp:ImageButton ID="imgLock" runat="server" CommandArgument='<%# Eval("UserName") %>'
                                    ToolTip='<%# Eval("IsApproved").ToString()=="True"?"Do Lock":"Do Unlock" %>'
                                    OnClick="imgLock_Click" ImageUrl='<%# Eval("IsApproved").ToString()=="True"?"~/App_Themes/Blue/images/unlock.png":"~/App_Themes/Blue/images/lock.png" %>'
                                    CausesValidation="false" />
                                <asp:HiddenField ID="hfIsApproved" runat="server" Value='<%# Eval("IsApproved") %>' />
                            </center>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                </Columns>
            </MasterTableView>
            <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
            <ClientSettings>
                <Selecting AllowRowSelect="True" />
            </ClientSettings>
            <FilterMenu EnableImageSprites="False">
            </FilterMenu>
        </telerik:RadGrid>
    </telerik:RadAjaxPanel>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Height="75px"
        Width="75px" Transparency="1">
    </telerik:RadAjaxLoadingPanel>
    <asp:SqlDataSource ID="sdsRoles" runat="server" ConnectionString="<%$ ConnectionStrings:dbConnString %>"
        SelectCommand="SELECT RoleID,RoleName FROM aspnet_Roles" SelectCommandType="Text"
        CancelSelectOnNullParameter="false"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsGetUsers" runat="server" ConnectionString="<%$ ConnectionStrings:dbConnString %>"
        SelectCommand="KRV_GetUsers" SelectCommandType="StoredProcedure" CancelSelectOnNullParameter="false">
    </asp:SqlDataSource>
</asp:Content>
