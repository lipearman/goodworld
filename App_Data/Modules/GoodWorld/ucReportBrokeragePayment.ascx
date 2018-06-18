<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ucReportBrokeragePayment.ascx.vb" Inherits="Modules_ucReportBrokeragePayment" %>


<fieldset>
    <legend class="text-primary"><%=PageName %></legend>
</fieldset>


<dx:BootstrapGridView ID="TaskGrid" runat="server"
    ClientInstanceName="taskGrid" Settings-ShowFooter="true"
    AutoGenerateColumns="False" 
    KeyFieldName="ID" SettingsBehavior-ConfirmDelete="true"
    SettingsBehavior-AllowDragDrop="true"
    SettingsPopup-EditForm-AllowResize="true"  
    DataSourceID="SqlDataSource_gridData" 
    Width="100%" CssClasses-HeaderRow="removeWrapping" CssClasses-Row="removeWrapping"
    PopupAnimationType="Fade" CloseOnEscape="true" CloseAction="None">
    <CssClasses Control="tasks-grid" PreviewRow="text-muted" />
    <ClientSideEvents ToolbarItemClick="function(s,e){
                switch (e.item.name) {

                case 'ExportToXLSX':
                case 'ExportToXLS':
                    e.processOnServer = true;
                    e.usePostBack = true;
                    break;

 
            }
 
        }" />

    <Toolbars>
        <dx:BootstrapGridViewToolbar>
            <Items>
                <dx:BootstrapGridViewToolbarItem Command="Refresh" BeginGroup="true" />
                <dx:BootstrapGridViewToolbarItem Command="ClearFilter" BeginGroup="true" />
                <dx:BootstrapGridViewToolbarItem Command="ClearSorting" BeginGroup="true" />
                <dx:BootstrapGridViewToolbarItem Command="ShowSearchPanel" BeginGroup="true" />

                <dx:BootstrapGridViewToolbarItem Command="Custom" Text="Export To" BeginGroup="true">
                    <Items>
                        <dx:BootstrapGridViewToolbarMenuItem Name="ExportToXLSX" Text="XLSX" />
                        <dx:BootstrapGridViewToolbarMenuItem Name="ExportToXLS" Text="XLS" />
                    </Items>
                </dx:BootstrapGridViewToolbarItem>

            </Items>
        </dx:BootstrapGridViewToolbar>
    </Toolbars>

    <Columns>
        <dx:BootstrapGridViewTextColumn FieldName="AGENT"></dx:BootstrapGridViewTextColumn>
         <dx:BootstrapGridViewSpinEditColumn FieldName="Account" Caption="Account" PropertiesSpinEdit-NumberType="Integer" PropertiesSpinEdit-DisplayFormatString="{0:N0}"></dx:BootstrapGridViewSpinEditColumn>
        
        <dx:BootstrapGridViewSpinEditColumn FieldName="ReceivePremium" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>
        <dx:BootstrapGridViewSpinEditColumn FieldName="WageOVAmt" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>
         <dx:BootstrapGridViewSpinEditColumn FieldName="BrokerSurveyAmt" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>
 <dx:BootstrapGridViewSpinEditColumn FieldName="NetPayment" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>
       
        <dx:BootstrapGridViewTextColumn FieldName="AA" Caption="วันที่จ่าย" 
            Settings-AllowHeaderFilter="True" Settings-FilterMode="Value" 
            SettingsHeaderFilter-Mode="DateRangePicker" 
            PropertiesTextEdit-DisplayFormatString="{0:dd/MM/yyyy}">


        </dx:BootstrapGridViewTextColumn>
   
        <dx:BootstrapGridViewTextColumn FieldName="BB" Caption="ชำระโดย"></dx:BootstrapGridViewTextColumn>
 
         <dx:BootstrapGridViewSpinEditColumn FieldName="Branchid" Caption="ค่าคอม" PropertiesSpinEdit-NumberType="Float"
              Settings-AllowHeaderFilter="True" SettingsHeaderFilter-Mode="List"
             PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>
    
    </Columns>
    <GroupSummary>
         <dx:ASPxSummaryItem FieldName="AGENT" SummaryType="Max"   />
        <dx:ASPxSummaryItem FieldName="Account" DisplayFormat="{0:N0}" SummaryType="Sum" />

         <dx:ASPxSummaryItem FieldName="ReceivePremium" DisplayFormat="{0:N2}" SummaryType="Sum" />
         <dx:ASPxSummaryItem FieldName="WageOVAmt" DisplayFormat="{0:N2}" SummaryType="Sum" />
         <dx:ASPxSummaryItem FieldName="BrokerSurveyAmt" DisplayFormat="{0:N2}" SummaryType="Sum" />
         <dx:ASPxSummaryItem FieldName="NetPayment" DisplayFormat="{0:N2}" SummaryType="Sum" />
    </GroupSummary>
    <TotalSummary>
         <dx:ASPxSummaryItem FieldName="AGENT" SummaryType="Max" />
        <dx:ASPxSummaryItem FieldName="Account" DisplayFormat="{0:N0}" SummaryType="Sum" />

         <dx:ASPxSummaryItem FieldName="ReceivePremium" DisplayFormat="{0:N2}" SummaryType="Sum" />
         <dx:ASPxSummaryItem FieldName="WageOVAmt" DisplayFormat="{0:N2}" SummaryType="Sum" />
         <dx:ASPxSummaryItem FieldName="BrokerSurveyAmt" DisplayFormat="{0:N2}" SummaryType="Sum" />
         <dx:ASPxSummaryItem FieldName="NetPayment" DisplayFormat="{0:N2}" SummaryType="Sum" />
    </TotalSummary>

    <SettingsEditing Mode="PopupEditForm" EditFormColumnSpan="12">
        <FormLayoutProperties LayoutType="Horizontal"></FormLayoutProperties>
    </SettingsEditing>
    <SettingsBehavior AllowFocusedRow="true" />
    <SettingsDataSecurity AllowEdit="true" AllowInsert="true" AllowDelete="false" />
    <SettingsPager AlwaysShowPager="true" ShowEmptyDataRows="false" PageSize="5">
        <PageSizeItemSettings Visible="true" Items="5,8,12,20" />
    </SettingsPager>
    <SettingsCustomizationDialog Enabled="true" />
    <SettingsCommandButton>
        <EditButton CssClass="edit-btn" RenderMode="Button" Text=" " />
        <UpdateButton RenderMode="Button" Text="Save" CssClass="saveBt" />
        <CancelButton RenderMode="Button" />
    </SettingsCommandButton>

    <SettingsAdaptivity AdaptivityMode="HideDataCells" AllowOnlyOneAdaptiveDetailExpanded="true" />
    <SettingsSearchPanel Visible="true" />
    <SettingsDataSecurity AllowDelete="true" />

  
</dx:BootstrapGridView>

<asp:SqlDataSource ID="SqlDataSource_gridData" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
    SelectCommand="SELECT *  FROM v_BrokeragePayment order by AA desc"></asp:SqlDataSource>



