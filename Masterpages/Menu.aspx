<%@ Page Language="C#" MasterPageFile="~/KRV.master" AutoEventWireup="true" CodeFile="Menu.aspx.cs"
    Inherits="Masterpages_Menu" %>

<asp:Content ID="Content3" ContentPlaceHolderID="cphHeadTitle" runat="Server">
    Menu Manager
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphContent" runat="Server">
    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
        <telerik:RadGrid PageSize="20" ID="rgMenu" runat="server" AllowFilteringByColumn="True"
            AllowPaging="True" AllowAutomaticDeletes="true" AllowAutomaticInserts="false"
            AllowAutomaticUpdates="true" ShowStatusBar="true" AllowSorting="True" AutoGenerateColumns="False"
            CellSpacing="0" OnItemDataBound="RadGrid1_ItemDataBound" DataSourceID="sdsAddEditRecords"
            GridLines="None" Skin="Sunset" OnInsertCommand="RadGrid1_InsertCommand" OnUpdateCommand="RadGrid1_UpdateCommand"
            OnItemDeleted="RadGrid1_ItemDeleted">
            <GroupingSettings CaseSensitive="false" />
            <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Default">
            </HeaderContextMenu>
            <MasterTableView DataSourceID="sdsAddEditRecords" DataKeyNames="MenuID" CommandItemDisplay="Top">
                <EditFormSettings EditFormType="Template">
                    <FormTemplate>
                        <h1>
                            Menu Details</h1>
                        <asp:HiddenField ID="hfMenuID" runat="server" Value='<%# Eval("MenuID") %>' />
                        <hr />
                        <asp:Panel ID="Panel1" runat="server" DefaultButton="imgUpdate">
                            <table cellpadding="2" cellspacing="2">
                                <tr>
                                    <td align="left" valign="middle">
                                        Menu Title:
                                    </td>
                                    <td align="left" valign="middle">
                                        <asp:TextBox ID="txtTitle" runat="server" Text='<%# Bind("TitleDisp") %>' />
                                        <asp:RequiredFieldValidator ID="rfvTitle" runat="server" ControlToValidate="txtTitle"
                                            SetFocusOnError="true" Display="Dynamic" ErrorMessage="Enter Menu Title"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="middle">
                                        Navigation Link
                                    </td>
                                    <td align="left" valign="middle">
                                        <asp:TextBox ID="txtLink" runat="server" Text='<%# Bind("Link") %>' />
                                        <asp:RequiredFieldValidator ID="rfvLink" runat="server" ControlToValidate="txtLink"
                                            SetFocusOnError="true" Display="Dynamic" ErrorMessage="Enter Navigation Link"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top">
                                        Parent Item:
                                    </td>
                                    <td align="left" valign="top">
                                        <telerik:RadTreeView ID="rtrvParent" runat="server" DataSourceID="sdsParent" DataTextField="Title"
                                            DataValueField="MenuID" DataFieldID="MenuID" DataFieldParentID="ParentID" SelectedValue='<%# Eval("MenuID") %>'>
                                        </telerik:RadTreeView>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="middle">
                                        Access Level:
                                    </td>
                                    <td align="left" valign="middle">
                                        <telerik:RadComboBox ID="rcmbRoles" runat="server" DataSourceID="sdsRoles" DataTextField="RoleName"
                                            DataValueField="RoleID" MarkFirstMatch="true" SelectedValue='<%# Bind("RoleID") %>'>
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top" colspan="2">
                                        <asp:ImageButton ID="imgUpdate" runat="server" CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>'
                                            AlternateText="Update" ToolTip="Update" ImageUrl="~/App_Themes/Blue/images/savebutton.gif" />
                                        <asp:ImageButton ID="imgCancel" runat="server" CommandName="Cancel" AlternateText="Cancel"
                                            ToolTip="Cancel" ImageUrl="~/App_Themes/Blue/images/cancelbutton.gif" CausesValidation="false" />
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </FormTemplate>
                </EditFormSettings>
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton" EditImageUrl="~/App_Themes/Blue/images/edit.gif"
                        ItemStyle-Width="5px" HeaderText="Edit">
                        <HeaderStyle Width="5px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridBoundColumn DataField="Title" FilterControlAltText="Filter Title column"
                        HeaderText="Title" SortExpression="Title" UniqueName="Title" FilterControlWidth="150px"
                        HeaderStyle-Width="150px" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Link" FilterControlAltText="Filter Link column"
                        HeaderText="Navigation" SortExpression="Link" UniqueName="Link" FilterControlWidth="150px"
                        HeaderStyle-Width="150px" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="RoleName" FilterControlAltText="Filter RoleName column"
                        HeaderText="AccessLevel" SortExpression="RoleName" UniqueName="RoleName" FilterControlWidth="100px"
                        HeaderStyle-Width="50px" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="OriginalOrdering" AllowFiltering="false" AllowSorting="false"
                        HeaderText="Order" UniqueName="OriginalOrdering" HeaderStyle-Width="10px">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn HeaderText="Order" AllowFiltering="false" UniqueName="Order"
                        HeaderStyle-Width="10px">
                        <ItemTemplate>
                            <asp:ImageButton ID="btnUp" runat="server" ToolTip="Move Up" CommandArgument='<%# Eval("MenuID")  %>'
                                CommandName='<%# Eval("MenuID") %>' OnCommand="MoveUp" CausesValidation="false"
                                ImageUrl="~/App_Themes/Blue/images/Up.gif" />
                            <asp:ImageButton ID="btnDown" runat="server" ToolTip="Move Down" CommandArgument='<%# Eval("MenuID")  %>'
                                CommandName='<%# Eval("MenuID") %>' OnCommand="MoveDown" CausesValidation="false"
                                ImageUrl="~/App_Themes/Blue/images/Down.gif" />
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn AllowFiltering="false" HeaderText="Created By" HeaderStyle-Width="100px">
                        <ItemTemplate>
                            <asp:Label ID="lblCreatedBy" runat="server" Text='<%# Eval("CreatedBy") + "<br/>" + Eval("CreatedOn") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn AllowFiltering="false" HeaderText="Modified By" HeaderStyle-Width="100px">
                        <ItemTemplate>
                            <asp:Label ID="lblModifiedBy" runat="server" Text='<%# Eval("ModifiedBy") + "<br/>" + Eval("ModifiedOn") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn AllowFiltering="false" HeaderText="Delete" HeaderStyle-Width="5px">
                        <ItemStyle HorizontalAlign="Center" />
                        <ItemTemplate>
                            <center>
                                <asp:ImageButton ToolTip='<%# ((Eval("IsActive").ToString()=="1")?"Yes":"No") %>'
                                    ID="imgActive" runat="server" CommandArgument='<%# Eval("MenuID") %>' ImageUrl='<%# "~/App_Themes/Blue/images/" + ((Eval("IsActive").ToString()=="1")?"icon_active.png":"icon_deactive.png") %>'
                                    CausesValidation="false" OnClick="imgActive_Click" />
                            </center>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridButtonColumn ConfirmText="Are you sure want to purge this record?" ConfirmDialogType="RadWindow"
                        ConfirmTitle="Purge Record" ButtonType="ImageButton" CommandName="Delete" Text="Purge"
                        UniqueName="DeleteColumn" HeaderText="Purge">
                        <ItemStyle HorizontalAlign="Center" Width="5px" />
                        <HeaderStyle Width="5px" />
                    </telerik:GridButtonColumn>
                </Columns>
            </MasterTableView>
            <PagerStyle Mode="NumericPages" AlwaysVisible="true" />
            <ClientSettings>
                <Selecting AllowRowSelect="True" />
            </ClientSettings>
        </telerik:RadGrid>
    </telerik:RadAjaxPanel>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Height="75px"
        Width="75px" Transparency="1">
    </telerik:RadAjaxLoadingPanel>
    <asp:SqlDataSource ID="sdsAddEditRecords" runat="server" ConnectionString="<%$ ConnectionStrings:dbConnString %>"
        SelectCommand="KRV_GetAdminMenu" SelectCommandType="StoredProcedure" CancelSelectOnNullParameter="False"
        DeleteCommand="KRV_DeleteMenu" DeleteCommandType="StoredProcedure" InsertCommand="KRV_AddMenu"
        InsertCommandType="StoredProcedure" UpdateCommand="KRV_UpdateMenu" UpdateCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="MenuID" Type="Int32" DefaultValue="0" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="MenuID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="Title" Type="String" />
            <asp:Parameter Name="Link" Type="String" />
            <asp:Parameter Name="ParentID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="RoleID" Type="String" />
            <asp:Parameter Name="UserName" Type="String" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="Title" Type="String" />
            <asp:Parameter Name="Link" Type="String" />
            <asp:Parameter Name="ParentID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="RoleID" Type="String" />
            <asp:Parameter Name="UserName" Type="String" />
            <asp:Parameter Direction="InputOutput" Name="MenuID" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsParent" runat="server" ConnectionString="<%$ ConnectionStrings:dbConnString %>"
        SelectCommand="KRV_GetParentMenuItems" SelectCommandType="StoredProcedure" CancelSelectOnNullParameter="false"
        UpdateCommand="KRV_MenuUpDown" UpdateCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:Parameter Name="ID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="UP" Type="Int32" DefaultValue="0" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsRoles" runat="server" ConnectionString="<%$ ConnectionStrings:dbConnString %>"
        SelectCommand="SELECT RoleID,RoleName FROM aspnet_Roles" SelectCommandType="Text"
        CancelSelectOnNullParameter="false"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsSoftDelete" runat="server" ConnectionString="<%$ ConnectionStrings:dbConnString %>"
        UpdateCommand="KRV_SoftDeleteMenu" UpdateCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:Parameter Name="MenuID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="UserName" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
