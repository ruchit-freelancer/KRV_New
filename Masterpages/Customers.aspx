<%@ Page Language="C#" MasterPageFile="~/KRV.master" AutoEventWireup="true" CodeFile="Customers.aspx.cs"
    Inherits="Masterpages_Customers" %>

<asp:Content ID="Content3" ContentPlaceHolderID="cphHeadTitle" runat="Server">
    Customer Details
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
            <MasterTableView DataSourceID="sdsAddEditRecords" DataKeyNames="CustomerID" CommandItemDisplay="Top">
                <EditFormSettings EditFormType="Template">
                    <FormTemplate>
                        <h1>
                            Customer Details</h1>
                        <hr />
                        <asp:Panel ID="Panel1" runat="server" DefaultButton="imgUpdate">
                            <table cellpadding="2" cellspacing="2">
                                <tr>
                                    <td align="left" valign="middle">
                                        Customer Name:
                                    </td>
                                    <td align="left" valign="middle">
                                        <asp:TextBox ID="txtCustomerName" Width="250px" TabIndex="1" runat="server" Text='<%# Bind("CustomerName") %>' />
                                        <span style="color: Red;"><small>*</small></span>
                                    </td>
                                    <td align="left" valign="middle">
                                        <asp:RequiredFieldValidator ID="rfvCustomerName" runat="server" ControlToValidate="txtCustomerName"
                                            SetFocusOnError="true" Display="None" ErrorMessage="Enter Customer Name"></asp:RequiredFieldValidator>
                                    </td>
                                    <td align="left" valign="middle">
                                        PhoneNo:
                                    </td>
                                    <td align="left" valign="middle">
                                        <asp:TextBox ID="txtPhoneNo" TabIndex="8" runat="server" Text='<%# Bind("PhoneNo") %>' />
                                    </td>
                                    <td align="left" valign="middle">
                                        <asp:RegularExpressionValidator ControlToValidate="txtPhoneNo" ID="RegularExpressionValidator1"
                                            runat="server" ErrorMessage="Invalid Phone" Display="Dynamic" SetFocusOnError="True"
                                            ValidationExpression="((\(\d{3}\) ?)|(\d{3}-))?\d{3}-\d{4}"></asp:RegularExpressionValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="middle">
                                        Customer Code:
                                    </td>
                                    <td align="left" valign="middle">
                                        <asp:TextBox ID="txtCustomerCode" TabIndex="2" runat="server" Text='<%# Bind("CustomerCode") %>' />
                                    </td>
                                    <td align="left" valign="middle">
                                    </td>
                                    <td align="left" valign="middle">
                                        Contact Person:
                                    </td>
                                    <td align="left" valign="middle">
                                        <asp:TextBox ID="txtContactPerson" TabIndex="9" runat="server" Text='<%# Bind("ContactPerson") %>' />
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="middle">
                                        Location:
                                    </td>
                                    <td align="left" valign="middle">
                                        <telerik:RadComboBox ID="rcmbLocations" TabIndex="6" runat="server" DataSourceID="sdsLocations"
                                            DataTextField="LocationName" DataValueField="LocationID" MarkFirstMatch="true"
                                            SelectedValue='<%# Eval("LocationID") %>' AppendDataBoundItems="true">
                                            <Items>
                                                <telerik:RadComboBoxItem Text="Select" Value="Select" />
                                            </Items>
                                        </telerik:RadComboBox>
                                        <span style="color: Red;"><small>*</small></span>
                                    </td>
                                    <td align="left" valign="middle">
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="rcmbLocations"
                                            InitialValue="Select" SetFocusOnError="true" Display="None" ErrorMessage="Select Location"></asp:RequiredFieldValidator>
                                    </td>
                                    <td align="left" valign="middle">
                                        Email:
                                    </td>
                                    <td align="left" valign="middle">
                                        <asp:TextBox ID="txtEmail" TabIndex="11" runat="server" Text='<%# Bind("Email") %>' />
                                    </td>
                                    <td align="left" valign="middle" width="250px">
                                        <asp:RegularExpressionValidator ID="revEmail" ControlToValidate="txtEmail" runat="server"
                                            ErrorMessage="Invalid Email" Display="Dynamic" SetFocusOnError="True" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="middle">
                                        City:
                                    </td>
                                    <td align="left" valign="middle">
                                        <asp:TextBox ID="txtCity" TabIndex="5" runat="server" Text='<%# Bind("City") %>' />
                                        <span style="color: Red;"><small>*</small></span>
                                    </td>
                                    <td align="left" valign="middle">
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtCity"
                                            SetFocusOnError="true" Display="None" ErrorMessage="Enter City"></asp:RequiredFieldValidator>
                                    </td>
                                    <td align="left" valign="middle">
                                    </td>
                                    <td align="left" valign="middle">
                                    </td>
                                    <td align="left" valign="middle" width="250px">
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="middle">
                                        State:
                                    </td>
                                    <td align="left" valign="middle">
                                        <telerik:RadComboBox ID="rcmbStateName" TabIndex="6" runat="server" DataSourceID="sdsStateName"
                                            DataTextField="StateName" DataValueField="StateID" MarkFirstMatch="true" SelectedValue='<%# Eval("StateID") %>'
                                            AppendDataBoundItems="true">
                                            <Items>
                                                <telerik:RadComboBoxItem Text="Select" Value="Select" />
                                            </Items>
                                        </telerik:RadComboBox>
                                        <span style="color: Red;"><small>*</small></span>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="rcmbStateName"
                                            InitialValue="Select" SetFocusOnError="true" Display="None" ErrorMessage="Select State"></asp:RequiredFieldValidator>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="middle" colspan="6">
                                        <asp:ImageButton ID="imgUpdate" runat="server" TabIndex="13" CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>'
                                            AlternateText="Update" ToolTip="Update" ImageUrl="~/App_Themes/Blue/images/savebutton.gif" />
                                        <asp:ImageButton ID="imgCancel" runat="server" TabIndex="14" CommandName="Cancel"
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
                    <telerik:GridBoundColumn DataField="CustomerName" FilterControlAltText="Filter CustomerName column"
                        HeaderText="CustomerName" SortExpression="CustomerName" UniqueName="CustomerName"
                        FilterControlWidth="150px" HeaderStyle-Width="150px" AutoPostBackOnFilter="true"
                        CurrentFilterFunction="Contains">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="City" FilterControlAltText="Filter City column"
                        HeaderText="City" SortExpression="City" UniqueName="City" FilterControlWidth="150px"
                        HeaderStyle-Width="150px" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="State" FilterControlAltText="Filter State column"
                        HeaderText="State" SortExpression="State" UniqueName="State" FilterControlWidth="150px"
                        HeaderStyle-Width="150px" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="LocationName" FilterControlAltText="Filter LocationName column"
                        HeaderText="Location" SortExpression="LocationName" UniqueName="LocationName"
                        FilterControlWidth="150px" HeaderStyle-Width="150px" AutoPostBackOnFilter="true"
                        CurrentFilterFunction="Contains">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PhoneNo" HeaderText="PhoneNo" SortExpression="PhoneNo"
                        UniqueName="PhoneNo" AllowFiltering="false" HeaderStyle-Width="150px">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn AllowFiltering="false" HeaderText="Delete" HeaderStyle-Width="5px">
                        <ItemStyle HorizontalAlign="Center" />
                        <ItemTemplate>
                            <center>
                                <asp:ImageButton ToolTip='<%# ((Eval("IsActive").ToString()=="1")?"Yes":"No") %>'
                                    ID="imgActive" runat="server" CommandArgument='<%# Eval("CustomerID") %>' ImageUrl='<%# "~/App_Themes/Blue/images/" + ((Eval("IsActive").ToString()=="1")?"icon_active.png":"icon_deactive.png") %>'
                                    CausesValidation="false" OnClick="imgActive_Click" />
                                <asp:HiddenField ID="hfStateID" runat="server" Value='<%# Eval("CustomerID") %>' />
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
        UpdateCommand="KRV_UpdateCustomers" UpdateCommandType="StoredProcedure" DeleteCommand="KRV_DeleteCustomers"
        DeleteCommandType="StoredProcedure" InsertCommand="KRV_AddCustomers" InsertCommandType="StoredProcedure"
        SelectCommand="KRV_GetCustomers" SelectCommandType="StoredProcedure" CancelSelectOnNullParameter="false">
        <DeleteParameters>
            <asp:Parameter Name="CustomerID" Type="Int32" DefaultValue="0" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="CustomerID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="CustomerName" Type="String" />
            <asp:Parameter Name="CustomerCode" Type="String" />
            <asp:Parameter Name="City" Type="String" />
            <asp:Parameter Name="StateID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="PhoneNo" Type="String" />
            <asp:Parameter Name="ContactPerson" Type="String" />
            <asp:Parameter Name="Email" Type="String" />
            <asp:Parameter Name="UserName" Type="String" />
            <asp:Parameter Name="LocationID" Type="Int32" DefaultValue="0" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="CustomerName" Type="String" />
            <asp:Parameter Name="CustomerCode" Type="String" />
            <asp:Parameter Name="City" Type="String" />
            <asp:Parameter Name="StateID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="PhoneNo" Type="String" />
            <asp:Parameter Name="ContactPerson" Type="String" />
            <asp:Parameter Name="Email" Type="String" />
            <asp:Parameter Name="UserName" Type="String" />
            <asp:Parameter Name="LocationID" Type="Int32" DefaultValue="0" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsSoftDelete" runat="server" ConnectionString="<%$ ConnectionStrings:dbConnString %>"
        UpdateCommand="KRV_SoftDeleteCustomers" UpdateCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:Parameter Name="CustomerID" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="UserName" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsStateName" runat="server" ConnectionString="<%$ ConnectionStrings:dbConnString %>"
        SelectCommand="SELECT StateID,StateName FROM StateList WHERE IsActive=1" SelectCommandType="Text"
        CancelSelectOnNullParameter="false"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsLocations" runat="server" ConnectionString="<%$ ConnectionStrings:dbConnString %>"
        SelectCommand="SELECT LocationID,LocationName FROM Locations WHERE IsActive=1"
        SelectCommandType="Text" CancelSelectOnNullParameter="false"></asp:SqlDataSource>
</asp:Content>
