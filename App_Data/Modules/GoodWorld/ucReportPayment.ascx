<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ucReportPayment.ascx.vb" Inherits="Modules_ucReportPayment" %>


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
                <dx:BootstrapGridViewToolbarItem Command="ClearSorting" BeginGroup="true"/>
                <dx:BootstrapGridViewToolbarItem Command="ShowSearchPanel" BeginGroup="true"/>

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
        <dx:BootstrapGridViewTextColumn HorizontalAlign="Center" FieldName="RowNo" Caption="ลำดับที่"></dx:BootstrapGridViewTextColumn>

        
        <dx:BootstrapGridViewTextColumn FieldName="ClientName" Caption="ผู้เอาประกันภัย"></dx:BootstrapGridViewTextColumn>
        
        <dx:BootstrapGridViewTextColumn FieldName="PolicyNo" Caption="เลขที่กรมธรรม์"></dx:BootstrapGridViewTextColumn>
        
        <dx:BootstrapGridViewTextColumn FieldName="CarLicensePlate" Caption="ทะเบียนรถ"></dx:BootstrapGridViewTextColumn>
        
        <dx:BootstrapGridViewTextColumn FieldName="EffectiveDate" Caption="วันที่เริ่มคุ้มครอง" PropertiesTextEdit-DisplayFormatString="{0:dd/MM/yyyy}" ></dx:BootstrapGridViewTextColumn>
        
        <dx:BootstrapGridViewTextColumn FieldName="InsurerName" Caption="บริษัทประกันภัย"></dx:BootstrapGridViewTextColumn>

        <dx:BootstrapGridViewSpinEditColumn FieldName="Premium" Caption="เบี้ยสุทธิ" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}">
        </dx:BootstrapGridViewSpinEditColumn>
        <dx:BootstrapGridViewSpinEditColumn FieldName="Stamp" Caption="อากร" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}">
        </dx:BootstrapGridViewSpinEditColumn>
        <dx:BootstrapGridViewSpinEditColumn FieldName="Vat" Caption="ภาษี" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}">
        </dx:BootstrapGridViewSpinEditColumn>
          <dx:BootstrapGridViewSpinEditColumn FieldName="GrossPremium" Caption="เบี้ยรวม" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}">
        </dx:BootstrapGridViewSpinEditColumn>
    </Columns>
    <TotalSummary>

        <dx:ASPxSummaryItem FieldName="Premium" SummaryType="Sum" DisplayFormat="{0:N2}" />
        <dx:ASPxSummaryItem FieldName="Stamp" SummaryType="Sum" DisplayFormat="{0:N2}" />
        <dx:ASPxSummaryItem FieldName="Vat" SummaryType="Sum" DisplayFormat="{0:N2}" />
        <dx:ASPxSummaryItem FieldName="GrossPremium" SummaryType="Sum" DisplayFormat="{0:N2}" />
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

</dx:BootstrapGridView>

<asp:SqlDataSource ID="SqlDataSource_gridData" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
    SelectCommand="SELECT ROW_NUMBER() OVER(ORDER BY InsurerName) AS RowNo,*
    FROM v_Report1
    where PaymentDate is null 
    "
    >

</asp:SqlDataSource>


 
