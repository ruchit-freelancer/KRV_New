<%@ Page Language="C#" MasterPageFile="~/KRV.master" AutoEventWireup="true" CodeFile="MaintenanceTypes.aspx.cs"
    Inherits="Masterpages_MaintenanceTypes" %>

<asp:Content ID="Content3" ContentPlaceHolderID="cphHeadTitle" runat="Server">
    Maintenance Types
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphContent" runat="Server">
    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
        <telerik:RadGrid PageSize="20" ID="rgSearch" runat="server" AllowFilteringByColumn="True"
            AllowPaging="True" AllowAutomaticDeletes="true" AllowAutomaticInserts="false"
            AllowAutomaticUpdates="true" ShowStatusBar="true" AllowSorting="True" AutoGenerateColumns="False"
            CellSpacing="0" DataSourceID="sdsAddEditRecords" GridLines="None" Skin="Sunset"
            OnInsertCommand="RadGrid1_InsertCommand" OnUpdateCommand="RadGrid1_UpdateCommand"
            OnItemDeleted="RadGrid1_ItemDeleted">
            <GroupingSettings CaseSensitive="false" />
            <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Default">
            </HeaderContextMenu>
            <MasterTableView DataSourceID="sdsAddEditRecords" DataKeyNames="MaintenanceTypeID"
                CommandItemDisplay="Top">
                <EditFormSettings EditFormType="Template">
                    <FormTemplate>
                        <h1>
                            Maintenance Type</h1>
                        <hr />
                        <asp:Panel ID="Panel1" runat="server" DefaultButton="imgUpdate">
                            <table cellpadding="2" cellspacing="2">
                                <tr>
                                    <td align="left" valign="middle">
                                        Maintenance Type:
                                    </td>
                                    <td align="left" valign="middle">
                                        <asp:TextBox ID="txtMaintenanceType" runat="server" Text='<%# Bind("MaintenanceType") %>' />
                                        <span style="color: Red;"><small>*</small></span>
                                        <asp:RequiredFieldValidator ID="rfvtxtMaintenanceType" runat="server" ControlToValidate="txtMaintenanceType"
                                            SetFocusOnError="true" Display="None" ErrorMessage="Enter Maintenance Type"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="middle">
                                        Short Name:
                                    </td>
                                    <td align="left" valign="middle">
                                        <asp:TextBox ID="txtShortName" runat="server" Text='<%# Bind("ShortName") %>' />
                                        <span style="color: Red;"><small>*</small></span>
                                        <asp:RequiredFieldValidator ID="rfvtxtShortName" runat="server" ControlToValidate="txtShortName"
                                            SetFocusOnError="true" Display="None" ErrorMessage="Enter Short Name"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="middle">
                                        Description:
                                    </td>
                                    <td align="left" valign="middle">
                                        <asp:TextBox ID="txtDescription" TextMode="MultiLine" Height="70px" Width="250px"
                                            runat="server" Text='<%# Bind("Description") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="middle" colspan="2">
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
                    <telerik:GridEditCommandColumn ButtonType="ImageButton" EditImageUrl="../App_Themes/Blue/images/edit.gif"
                        ItemStyle-Width="5px" HeaderText="Edit">
                        <HeaderStyle Width="5px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridBoundColumn DataField="MaintenanceType" FilterControlAltText="Filter MaintenanceType column"
                        HeaderText="MaintenanceType" SortExpression="MaintenanceType" UniqueName="MaintenanceType"
                        FilterControlWidth="150px" HeaderStyle-Width="150px" AutoPostBackOnFilter="true"
                        CurrentFilterFunction="Contains">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ShortName" FilterControlAltText="Filter ShortName column"
                        HeaderText="ShortName" SortExpression="ShortName" UniqueName="ShortName"
                        FilterControlWidth="150px" HeaderStyle-Width="150px" AutoPostBackOnFilter="true"
                        CurrentFilterFunction="Contains">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Description" AllowFiltering="false" HeaderText="Description"
                        UniqueName="Description">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn AllowFiltering="false" HeaderText="Delete" HeaderStyle-Width="5px">
                        <ItemStyle HorizontalAlign="Center" />
                        <ItemTemplate>
                            <center>
                                <asp:ImageButton ToolTip='<%# ((Eval("IsActive").ToString()=="1")?"Yes":"No") %>'
                                    ID="imgActive" runat="server" CommandArgument='<%# Eval("MaintenanceTypeID") %>'
                                    ImageUrl='<%# "~/App_Themes/Blue/images/" + ((Eval("IsActive").ToString()=="1")?"icon_active.png":"icon_deactive.png") %>'
                                    CausesValidation="false" OnClick="imgActive_Click" />
                                <asp:HiddenField ID="hfStateID" runat="server" Value='<%# Eval("MaintenanceTypeID") %>' />
                                <asp:HiddenField ID="hfIsActive" runat="server" Value='<%# Eval("IsActive") %>' />
                            </center>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridButtonColumn ConfirmText="Are you sure want to purge this record?" ConfirmDialogType="RadWindow"
                        ConfirmTitle="Purge Record" ButtonType="ImageButton" CommandName="Delete" Text="Purge"
                        UniqueName="DeleteColumn" HeaderText="Purge" Visible="false">
                        <HeaderStyle Width="5px" />
                        <ItemStyle HorizontalAlign="Center" Width="5px" />
                    </telerik:GridButtonColumn>
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
    <asp:SqlDataSource ID="sdsAddEditRecords" runat="server" ConnectionString="<%$ ConnectionStrings:dbConnString %>"
        InsertCommand="KRV_AddMaintenanceTypes" InsertCommandType="StoredProcedure" SelectCommand="KRV_GetMaintenanceTypes"
        SelectCommandType="StoredProcedure" UpdateCommand="KRV_UpdateMaintenanceTypes"
        UpdateCommandType="StoredProcedure" CancelSelectOnNullParameter="false" DeleteCommand="KRV_DeleteMaintenanceTypes"
        DeleteCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:Parameter Name="MaintenanceTypeID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="MaintenanceType" Type="String" />
            <asp:Parameter Name="Description" Type="String" />
            <asp:Parameter Name="UserName" Type="String" />
            <asp:Parameter Name="ShortName" Type="String" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="MaintenanceType" Type="String" />
            <asp:Parameter Name="Description" Type="String" />
            <asp:Parameter Name="UserName" Type="String" />
            <asp:Parameter Name="ShortName" Type="String" />
        </InsertParameters>
        <DeleteParameters>
            <asp:Parameter DefaultValue="0" Name="MaintenanceTypeID" Type="Int32" />
        </DeleteParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsSoftDelete" runat="server" ConnectionString="<%$ ConnectionStrings:dbConnString %>"
        UpdateCommand="KRV_SoftDeleteMaintenanceTypes" UpdateCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:Parameter Name="MaintenanceTypeID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="UserName" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
