<%@ Page Language="C#" MasterPageFile="~/KRV.master" AutoEventWireup="true" CodeFile="TripTypes.aspx.cs"
    Inherits="Masterpages_TripTypes" %>

<asp:Content ID="Content3" ContentPlaceHolderID="cphHeadTitle" runat="Server">
    Trip Types
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
            <MasterTableView DataSourceID="sdsAddEditRecords" DataKeyNames="TripTypeID" CommandItemDisplay="Top">
                <EditFormSettings EditFormType="Template">
                    <FormTemplate>
                        <h1>
                            Trip Type</h1>
                        <hr />
                        <asp:Panel ID="Panel1" runat="server" DefaultButton="imgUpdate">
                            <table cellpadding="2" cellspacing="2">
                                <tr>
                                    <td align="left" valign="middle">
                                        Trip Type:
                                    </td>
                                    <td align="left" valign="middle">
                                        <asp:TextBox ID="txtTripType" runat="server" Text='<%# Bind("TripType") %>' />
                                        <span style="color: Red;"><small>*</small></span>
                                        <asp:RequiredFieldValidator ID="rfvtxtTripType" runat="server" ControlToValidate="txtTripType"
                                            SetFocusOnError="true" Display="None" ErrorMessage="Enter Trip Type"></asp:RequiredFieldValidator>
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
                    <telerik:GridBoundColumn DataField="TripType" FilterControlAltText="Filter TripType column"
                        HeaderText="TripType" SortExpression="TripType" UniqueName="TripType" FilterControlWidth="150px"
                        HeaderStyle-Width="150px" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn AllowFiltering="false" HeaderText="Delete" HeaderStyle-Width="5px">
                        <ItemStyle HorizontalAlign="Center" />
                        <ItemTemplate>
                            <center>
                                <asp:ImageButton ToolTip='<%# ((Eval("IsActive").ToString()=="1")?"Yes":"No") %>'
                                    ID="imgActive" runat="server" CommandArgument='<%# Eval("TripTypeID") %>' ImageUrl='<%# "~/App_Themes/Blue/images/" + ((Eval("IsActive").ToString()=="1")?"icon_active.png":"icon_deactive.png") %>'
                                    CausesValidation="false" OnClick="imgActive_Click" />
                                <asp:HiddenField ID="hfStateID" runat="server" Value='<%# Eval("TripTypeID") %>' />
                                <asp:HiddenField ID="hfIsActive" runat="server" Value='<%# Eval("IsActive") %>' />
                            </center>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridButtonColumn ConfirmText="Are you sure want to purge this record?" ConfirmDialogType="RadWindow"
                        ConfirmTitle="Purge Record" ButtonType="ImageButton" CommandName="Delete" Text="Purge"
                        UniqueName="DeleteColumn" HeaderText="Purge" Visible="false">
                        <ItemStyle HorizontalAlign="Center" Width="5px" />
                        <HeaderStyle Width="5px" />
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
        InsertCommand="KRV_AddTripTypes" InsertCommandType="StoredProcedure" SelectCommand="KRV_GetTripTypes"
        SelectCommandType="StoredProcedure" UpdateCommand="KRV_UpdateTripTypes" UpdateCommandType="StoredProcedure"
        CancelSelectOnNullParameter="false" DeleteCommand="KRV_DeleteTripTypes" DeleteCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:Parameter Name="TripTypeID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="TripType" Type="String" />
            <asp:Parameter Name="UserName" Type="String" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="TripType" Type="String" />
            <asp:Parameter Name="UserName" Type="String" />
        </InsertParameters>
        <DeleteParameters>
            <asp:Parameter DefaultValue="0" Name="TripTypeID" Type="Int32" />
        </DeleteParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsSoftDelete" runat="server" ConnectionString="<%$ ConnectionStrings:dbConnString %>"
        UpdateCommand="KRV_SoftDeleteTripTypes" UpdateCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:Parameter Name="TripTypeID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="UserName" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
