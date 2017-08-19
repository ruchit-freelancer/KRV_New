<%@ Page Language="C#" MasterPageFile="~/KRV.master" AutoEventWireup="true" CodeFile="DriverExpenses.aspx.cs"
     Inherits="DriverExpenses" %>

<asp:Content ID="Content3" ContentPlaceHolderID="cphHeadTitle" runat="Server">
     Driver Expenses
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphContent" runat="Server">
     <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
          <telerik:RadGrid PageSize="20" ID="rgDriverExpense" runat="server" AllowFilteringByColumn="True"
               AllowPaging="True" AllowAutomaticDeletes="true" AllowAutomaticInserts="false"
               AllowAutomaticUpdates="true" ShowStatusBar="true" AllowSorting="True" AutoGenerateColumns="False"
               CellSpacing="0" DataSourceID="sdsDriverExpenses" GridLines="None" Skin="Sunset"
               Width="100%" OnInsertCommand="rgDriverExpenses_InsertCommand" OnUpdateCommand="rgDriverExpenses_UpdateCommand"
               OnItemDeleted="rgDriverExpenses_ItemDeleted" OnItemDataBound="rgDriverExpense_ItemDataBound">
               <GroupingSettings CaseSensitive="false" />
               <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Default">
               </HeaderContextMenu>
               <MasterTableView DataSourceID="sdsDriverExpenses" DataKeyNames="ExpenseID" CommandItemDisplay="Top">
                    <EditFormSettings EditFormType="Template">
                         <FormTemplate>
                              <h1>
                                   Driver Expenses</h1>
                              <hr />
                              <asp:Panel ID="Panel1" runat="server" DefaultButton="imgUpdate">
                                   <table cellpadding="2" cellspacing="2">
                                        <tr>
                                             <td align="left" valign="middle">
                                                  Select Driver:
                                             </td>
                                             <td align="left" valign="middle">
                                                  <telerik:RadComboBox ID="rcmbDrivers" runat="server" DataSourceID="sdsDrivers" DataTextField="DriverName"
                                                       DataValueField="DriverID" MarkFirstMatch="true" SelectedValue='<%# Eval("DriverID") %>'
                                                       ValidationGroup="DriverExpense" AppendDataBoundItems="true">
                                                       <Items>
                                                            <telerik:RadComboBoxItem Text="Select" Value="Select" />
                                                       </Items>
                                                  </telerik:RadComboBox>
                                                  <span style="color: Red;"><small>*</small></span>
                                                  <asp:RequiredFieldValidator ValidationGroup="DriverExpense" ID="RequiredFieldValidator3"
                                                       runat="server" ControlToValidate="rcmbDrivers" SetFocusOnError="true" Display="None"
                                                       ErrorMessage="Select Driver"></asp:RequiredFieldValidator>
                                             </td>
                                             <td align="left" valign="top" rowspan="4">
                                                  Notes:
                                             </td>
                                             <td align="left" valign="top" rowspan="4">
                                                  <asp:TextBox ID="txtNotes" Text='<%# Eval("Notes") %>' runat="server" TextMode="MultiLine"
                                                       Width="350px" Height="70px"></asp:TextBox>
                                             </td>
                                        </tr>
                                        <tr>
                                             <td align="left" valign="middle">
                                                  Expense Type:
                                             </td>
                                             <td align="left" valign="middle">
                                                  <telerik:RadComboBox ID="rcmbExpenseTypes" runat="server" DataSourceID="sdsExpenseTypes"
                                                       DataTextField="ExpenseType" DataValueField="ExpenseTypeID" MarkFirstMatch="true"
                                                       SelectedValue='<%# Eval("ExpenseTypeID") %>' ValidationGroup="DriverExpense"
                                                       AppendDataBoundItems="true">
                                                       <Items>
                                                            <telerik:RadComboBoxItem Text="Select" Value="Select" />
                                                       </Items>
                                                  </telerik:RadComboBox>
                                                  <span style="color: Red;"><small>*</small></span>
                                                  <asp:RequiredFieldValidator ValidationGroup="DriverExpense" ID="RequiredFieldValidator9"
                                                       runat="server" ControlToValidate="rcmbExpenseTypes" SetFocusOnError="true" Display="None"
                                                       ErrorMessage="Select Expense Type"></asp:RequiredFieldValidator>
                                             </td>
                                        </tr>
                                        <tr>
                                             <td align="left" valign="middle">
                                                  Expense Date:
                                             </td>
                                             <td align="left" valign="middle">
                                                  <telerik:RadDatePicker ID="rdtpExpenseDate" runat="server" Culture="English (United States)"
                                                       Skin="Sunset" DbSelectedDate='<%# Bind("ExpenseDate") %>'>
                                                       <Calendar ID="Calendar3" Skin="Sunset" runat="server" UseColumnHeadersAsSelectors="True"
                                                            UseRowHeadersAsSelectors="True">
                                                       </Calendar>
                                                       <DateInput ID="DateInput3" InvalidStyleDuration="100" runat="server" LabelCssClass="radLabelCss_Sunset"
                                                            Skin="Sunset" Width="" DateFormat="MM-dd-yyyy" DisplayDateFormat="MM-dd-yyyy"
                                                            Font-Bold="true" ForeColor="Black" ValidationGroup="DriverExpense">
                                                       </DateInput>
                                                       <DatePopupButton CssClass="" />
                                                  </telerik:RadDatePicker>
                                                  <span style="color: Red;"><small>*</small></span>
                                                  <asp:RequiredFieldValidator ValidationGroup="DriverExpense" ID="RequiredFieldValidator2"
                                                       runat="server" ControlToValidate="rdtpExpenseDate" SetFocusOnError="true" Display="None"
                                                       ErrorMessage="Enter Expense Date"></asp:RequiredFieldValidator>
                                             </td>
                                        </tr>
                                        <tr>
                                             <td align="left" valign="middle">
                                                  Total Amount:
                                             </td>
                                             <td align="left" valign="middle">
                                                  <telerik:RadNumericTextBox ID="txtTotalAmount" runat="server" Type="Number" InvalidStyleDuration="100"
                                                       Text='<%# Eval("TotalAmount") %>' ValidationGroup="DriverExpense">
                                                       <NumberFormat AllowRounding="True" KeepNotRoundedValue="False" />
                                                  </telerik:RadNumericTextBox>
                                                  <span style="color: Red;"><small>*</small></span>
                                                  <asp:RequiredFieldValidator ValidationGroup="DriverExpense" ID="RequiredFieldValidator1"
                                                       runat="server" ControlToValidate="txtTotalAmount" SetFocusOnError="true" Display="None"
                                                       ErrorMessage="Enter Amount"></asp:RequiredFieldValidator>
                                             </td>
                                        </tr>
                                        <tr>
                                             <td align="left" valign="middle" colspan="2">
                                                  <asp:ImageButton ValidationGroup="DriverExpense" ID="imgUpdate" runat="server" CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>'
                                                       AlternateText="Update" ToolTip="Update" ImageUrl="~/App_Themes/Blue/images/savebutton.gif" />
                                                  <asp:ImageButton ID="imgCancel" runat="server" CommandName="Cancel" AlternateText="Cancel"
                                                       ToolTip="Cancel" ImageUrl="~/App_Themes/Blue/images/cancelbutton.gif" CausesValidation="false" />
                                             </td>
                                        </tr>
                                   </table>
                              </asp:Panel>
                         </FormTemplate>
                    </EditFormSettings>
                    <HeaderStyle HorizontalAlign="Center" />
                    <Columns>
                         <telerik:GridEditCommandColumn ButtonType="ImageButton" EditImageUrl="~/App_Themes/Blue/images/edit.gif"
                              ItemStyle-Width="5px" HeaderText="Edit">
                              <ItemStyle HorizontalAlign="Center" />
                              <HeaderStyle Width="5px" />
                         </telerik:GridEditCommandColumn>
                         <telerik:GridDateTimeColumn DataField="ExpenseDate" HeaderText="Date" SortExpression="ExpenseDate"
                              UniqueName="ExpenseDate" FilterControlWidth="100px" HeaderStyle-Width="100px"
                              AllowFiltering="true" DataType="System.DateTime" FilterListOptions="VaryByDataType"
                              AutoPostBackOnFilter="true" CurrentFilterFunction="EqualTo" DataFormatString="{0:MM-dd-yyyy}">
                         </telerik:GridDateTimeColumn>
                         <telerik:GridBoundColumn DataField="ExpenseType" FilterControlAltText="Filter ExpenseType column"
                              HeaderText="Expense Type" SortExpression="ExpenseType" UniqueName="ExpenseType"
                              FilterControlWidth="200px" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains">
                              <HeaderStyle Width="200px" />
                              <ItemStyle Width="200px" />
                         </telerik:GridBoundColumn>
                         <telerik:GridBoundColumn DataField="TotalAmount" FilterControlAltText="Filter TotalAmount column"
                              HeaderText="Amount" SortExpression="TotalAmount" UniqueName="TotalAmount" FilterControlWidth="70px"
                              HeaderStyle-Width="70px" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains">
                              <ItemStyle HorizontalAlign="Right" />
                         </telerik:GridBoundColumn>
                         <telerik:GridTemplateColumn AllowFiltering="false">
                              <ItemTemplate>
                              </ItemTemplate>
                         </telerik:GridTemplateColumn>
                         <telerik:GridTemplateColumn AllowFiltering="false" HeaderText="Delete" HeaderStyle-Width="5px">
                              <ItemStyle HorizontalAlign="Center" />
                              <ItemTemplate>
                                   <center>
                                        <asp:ImageButton ToolTip='<%# ((Eval("IsActive").ToString()=="1")?"Yes":"No") %>'
                                             ID="imgActive" runat="server" CommandArgument='<%# Eval("ExpenseID") %>' ImageUrl='<%# "~/App_Themes/Blue/images/" + ((Eval("IsActive").ToString()=="1")?"icon_active.png":"icon_deactive.png") %>'
                                             CausesValidation="false" OnClick="imgActiveDriverExpenses_Click" />
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
     <asp:SqlDataSource ID="sdsExpenseTypes" runat="server" ConnectionString="<%$ ConnectionStrings:dbConnString %>"
          SelectCommand="Select ExpenseTypeID,ExpenseType FROM ExpenseTypes WHERE IsActive=1"
          SelectCommandType="Text" CancelSelectOnNullParameter="false"></asp:SqlDataSource>
     <asp:SqlDataSource ID="sdsDrivers" runat="server" ConnectionString="<%$ ConnectionStrings:dbConnString %>"
          SelectCommand="Select DriverID,DriverName FROM Drivers WHERE IsActive=1" SelectCommandType="Text"
          CancelSelectOnNullParameter="false"></asp:SqlDataSource>
     <asp:SqlDataSource ID="sdsDriverExpenses" runat="server" ConnectionString="<%$ ConnectionStrings:dbConnString %>"
          UpdateCommand="KRV_UpdateDriverExpenses" UpdateCommandType="StoredProcedure"
          DeleteCommand="KRV_DeleteDriverExpenses" DeleteCommandType="StoredProcedure"
          InsertCommand="KRV_AddDriverExpenses" InsertCommandType="StoredProcedure" SelectCommand="KRV_GetDriverExpenses"
          SelectCommandType="StoredProcedure" CancelSelectOnNullParameter="False">
          <SelectParameters>
               <asp:Parameter Name="TripID" Type="Int32" DefaultValue="0" />
          </SelectParameters>
          <DeleteParameters>
               <asp:Parameter Name="ExpenseID" Type="Int32" DefaultValue="0" />
          </DeleteParameters>
          <UpdateParameters>
               <asp:Parameter Name="ExpenseID" Type="Int32" DefaultValue="0" />
               <asp:Parameter Name="DriverID" Type="Int32" DefaultValue="0" />
               <asp:Parameter Name="ExpenseDate" Type="DateTime" ConvertEmptyStringToNull="true" />
               <asp:Parameter Name="ExpenseTypeID" Type="Int32" DefaultValue="0" />
               <asp:Parameter Name="TotalAmount" Type="Decimal" DefaultValue="0" />
               <asp:Parameter Name="UserName" Type="String" />
               <asp:Parameter Name="Notes" Type="String" />
          </UpdateParameters>
          <InsertParameters>
               <asp:Parameter Name="TripID" Type="Int32" DefaultValue="0" />
               <asp:Parameter Name="DriverID" Type="Int32" DefaultValue="0" />
               <asp:Parameter Name="ExpenseDate" Type="DateTime" ConvertEmptyStringToNull="true" />
               <asp:Parameter Name="ExpenseTypeID" Type="Int32" DefaultValue="0" />
               <asp:Parameter Name="TotalAmount" Type="Decimal" DefaultValue="0" />
               <asp:Parameter Name="UserName" Type="String" />
               <asp:Parameter Name="Notes" Type="String" />
          </InsertParameters>
     </asp:SqlDataSource>
     <asp:SqlDataSource ID="sdsSoftDeleteDriverExpenses" runat="server" ConnectionString="<%$ ConnectionStrings:dbConnString %>"
          UpdateCommand="KRV_SoftDeleteDriverExpenses" UpdateCommandType="StoredProcedure">
          <UpdateParameters>
               <asp:Parameter Name="ExpenseID" Type="Int32" DefaultValue="0" />
               <asp:Parameter Name="UserName" Type="String" />
          </UpdateParameters>
     </asp:SqlDataSource>
</asp:Content>
