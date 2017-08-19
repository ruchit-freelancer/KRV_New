<%@ Page Language="C#" MasterPageFile="~/KRV.master" AutoEventWireup="true" CodeFile="Locations.aspx.cs"
    Inherits="Masterpages_Locations" %>

<asp:Content ID="Content3" ContentPlaceHolderID="cphHeadTitle" runat="Server">
    Company Locations
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
            <MasterTableView DataSourceID="sdsAddEditRecords" DataKeyNames="LocationID" CommandItemDisplay="Top">
                <EditFormSettings EditFormType="Template">
                    <FormTemplate>
                        <h1>
                            Company Location Details</h1>
                        <hr />
                        <asp:Panel ID="Panel1" runat="server" DefaultButton="imgUpdate">
                            <table cellpadding="2" cellspacing="2">
                                <tr>
                                    <td align="left" valign="middle">
                                        Location Name:
                                    </td>
                                    <td align="left" valign="middle">
                                        <asp:TextBox ID="txtLocationName" runat="server" Text='<%# Bind("LocationName") %>' />
                                        <span style="color: Red;"><small>*</small></span>
                                        <asp:RequiredFieldValidator ID="rfvLocationName" runat="server" ControlToValidate="txtLocationName"
                                            SetFocusOnError="true" Display="None" ErrorMessage="Enter Location Name"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="middle">
                                        City:
                                    </td>
                                    <td align="left" valign="middle">
                                        <asp:TextBox ID="txtCity" runat="server" Text='<%# Bind("City") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="middle">
                                        State:
                                    </td>
                                    <td align="left" valign="middle">
                                        <telerik:RadComboBox ID="rcmbStateName" runat="server" DataSourceID="sdsStateName"
                                            DataTextField="StateName" DataValueField="StateID" MarkFirstMatch="true" SelectedValue='<%# Eval("StateID") %>'
                                            AppendDataBoundItems="true">
                                            <Items>
                                                <telerik:RadComboBoxItem Text="Select" Value="Select" />
                                            </Items>
                                        </telerik:RadComboBox>
                                        <span style="color: Red;"><small>*</small></span>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="rcmbStateName"
                                            InitialValue="Select" SetFocusOnError="true" Display="None" ErrorMessage="Select State"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="middle">
                                        Phone No:
                                    </td>
                                    <td align="left" valign="middle">
                                        <asp:TextBox ID="txtPhoneNo" runat="server" Text='<%# Bind("PhoneNo") %>' />
                                        <asp:RegularExpressionValidator ControlToValidate="txtPhoneNo" ID="RegularExpressionValidator1"
                                            runat="server" ErrorMessage="Invalid Phone" Display="Dynamic" SetFocusOnError="True"
                                            ValidationExpression="((\(\d{3}\) ?)|(\d{3}-))?\d{3}-\d{4}"></asp:RegularExpressionValidator>
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
                    <telerik:GridBoundColumn DataField="LocationName" FilterControlAltText="Filter LocationName column"
                        HeaderText="LocationName" SortExpression="LocationName" UniqueName="LocationName"
                        FilterControlWidth="100px" HeaderStyle-Width="100px" AutoPostBackOnFilter="true"
                        CurrentFilterFunction="Contains">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="City" AllowFiltering="false" HeaderText="City"
                        UniqueName="City" HeaderStyle-Width="100px">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="State" AllowFiltering="false" HeaderText="State"
                        UniqueName="State" HeaderStyle-Width="100px">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PhoneNo" AllowFiltering="false" HeaderText="PhoneNo"
                        UniqueName="PhoneNo" HeaderStyle-Width="70px">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn AllowFiltering="false" HeaderText="Delete" HeaderStyle-Width="5px">
                        <ItemStyle HorizontalAlign="Center" />
                        <ItemTemplate>
                            <center>
                                <asp:ImageButton ToolTip='<%# ((Eval("IsActive").ToString()=="1")?"Yes":"No") %>'
                                    ID="imgActive" runat="server" CommandArgument='<%# Eval("LocationID") %>' ImageUrl='<%# "~/App_Themes/Blue/images/" + ((Eval("IsActive").ToString()=="1")?"icon_active.png":"icon_deactive.png") %>'
                                    CausesValidation="false" OnClick="imgActive_Click" />
                                <asp:HiddenField ID="hfStateID" runat="server" Value='<%# Eval("LocationID") %>' />
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
        UpdateCommand="KRV_UpdateLocations" UpdateCommandType="StoredProcedure" DeleteCommand="KRV_DeleteLocations"
        DeleteCommandType="StoredProcedure" InsertCommand="KRV_AddLocations" InsertCommandType="StoredProcedure"
        SelectCommand="KRV_GetLocations" SelectCommandType="StoredProcedure" CancelSelectOnNullParameter="false">
        <DeleteParameters>
            <asp:Parameter Name="LocationID" Type="Int32" DefaultValue="0" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="LocationID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="LocationName" Type="String" />
            <asp:Parameter Name="City" Type="String" />
            <asp:Parameter Name="StateID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="PhoneNo" Type="String" />
            <asp:Parameter Name="UserName" Type="String" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="LocationName" Type="String" />
            <asp:Parameter Name="City" Type="String" />
            <asp:Parameter Name="StateID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="PhoneNo" Type="String" />
            <asp:Parameter Name="UserName" Type="String" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsSoftDelete" runat="server" ConnectionString="<%$ ConnectionStrings:dbConnString %>"
        UpdateCommand="KRV_SoftDeleteLocations" UpdateCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:Parameter Name="LocationID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="UserName" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsStateName" runat="server" ConnectionString="<%$ ConnectionStrings:dbConnString %>"
        SelectCommand="SELECT StateID,StateName FROM StateList" SelectCommandType="Text"
        CancelSelectOnNullParameter="false"></asp:SqlDataSource>
</asp:Content>
