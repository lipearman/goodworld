<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ucBillingPayment.ascx.vb" Inherits="Modules_ucBillingPayment" %>

<style>
    legend {
        display: block;
        width: 100%;
        padding: 0;
        margin-bottom: 23px;
        font-size: 14px;
        line-height: inherit;
        color: #212121;
        border: 0;
        border-bottom: 1px solid #e5e5e5;
    }

    .text-primary {
        color: #2196f3;
        font-size: 14px;
    }
</style>
<style>
    .saveBt {
        margin-right: 10px;
    }
</style>

<fieldset>
    <legend class="text-primary"><%=PageName %></legend>
</fieldset>
 

<dx:BootstrapGridView ID="TaskGrid" runat="server"
    ClientInstanceName="taskGrid"
    AutoGenerateColumns="False" CssClasses-HeaderRow="removeWrapping" CssClasses-Row="removeWrapping"
    KeyFieldName="ID" SettingsBehavior-ConfirmDelete="true"
    SettingsBehavior-AllowDragDrop="true"
    SettingsPopup-EditForm-AllowResize="true"
    DataSourceID="SqlDataSource_BillingDetails"
    Width="100%"
    PopupAnimationType="Fade" CloseOnEscape="true" CloseAction="None">

    <SettingsEditing Mode="PopupEditForm" EditFormColumnSpan="12">
        <FormLayoutProperties LayoutType="Horizontal"></FormLayoutProperties>
    </SettingsEditing>
    <SettingsBehavior AllowFocusedRow="true" />
    <SettingsDataSecurity AllowEdit="true" AllowInsert="true" AllowDelete="true" />
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
                <dx:BootstrapGridViewToolbarItem Command="ClearSorting" BeginGroup="true" />
                <dx:BootstrapGridViewToolbarItem Command="ShowSearchPanel" BeginGroup="true" />


                <dx:BootstrapGridViewToolbarItem Command="Custom" Text="Export To" BeginGroup="true">
                    <Items>
                        <dx:BootstrapGridViewToolbarMenuItem Name="ExportToXLSX" Text="XLSX" />
                        <dx:BootstrapGridViewToolbarMenuItem Name="ExportToXLS" Text="XLS" />
                    </Items>
                </dx:BootstrapGridViewToolbarItem>

                <dx:BootstrapGridViewToolbarItem Command="ShowCustomizationDialog" BeginGroup="true">
                </dx:BootstrapGridViewToolbarItem>


            </Items>
        </dx:BootstrapGridViewToolbar>
    </Toolbars>
    <Columns>
        <dx:BootstrapGridViewCommandColumn ShowEditButton="true" Width="50"></dx:BootstrapGridViewCommandColumn>


        <dx:BootstrapGridViewTextColumn FieldName="ClientName"  ReadOnly="true" Width="250" Caption="ชื่อผู้เอาประกันภัย" Settings-AllowFilterBySearchPanel="True"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="CarLicensePlate"  ReadOnly="true" Width="100" Caption="ทะเบียนรถ" Settings-AllowFilterBySearchPanel="True"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="PolicyNo"  ReadOnly="true" Width="100" Caption="เลขกรมธรรม์" Settings-AllowFilterBySearchPanel="True"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewDateColumn FieldName="EffectiveDate" PropertiesDateEdit-DropDownButton-ClientVisible="false" ReadOnly="true" Caption="วันเริ่มคุ้มครอง" Width="100" PropertiesDateEdit-DisplayFormatString="dd/MM/yyyy"  PropertiesDateEdit-DisplayFormatInEditMode="true" />
        <dx:BootstrapGridViewTextColumn FieldName="InsurerName"   ReadOnly="true" Caption="บริษัทประกันภัย" Width="100"   />
        <dx:BootstrapGridViewSpinEditColumn FieldName="Premium" PropertiesSpinEdit-SpinButtons-ClientVisible="false"  ReadOnly="true" Width="100" AdaptivePriority="2" Caption="เบี้ยสุทธิ" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"  PropertiesSpinEdit-DisplayFormatInEditMode="true">
            
        </dx:BootstrapGridViewSpinEditColumn>
        <dx:BootstrapGridViewSpinEditColumn FieldName="GrossPremium"  PropertiesSpinEdit-SpinButtons-ClientVisible="false" ReadOnly="true" Width="100" Caption="เบี้ยรวมภาษี" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}" PropertiesSpinEdit-DisplayFormatInEditMode="true">
             
        </dx:BootstrapGridViewSpinEditColumn>

   

        
        <dx:BootstrapGridViewDateColumn FieldName="ReceiveDate" Caption="วันที่่รับเงิน" 
             PropertiesDateEdit-DisplayFormatString="dd/MM/yyyy"
            PropertiesDateEdit-EditFormatString="dd/MM/yyyy" 
            PropertiesDateEdit-DisplayFormatInEditMode="true"
            PropertiesDateEdit-ValidationSettings-RequiredField-IsRequired="true" >
    
        </dx:BootstrapGridViewDateColumn>

        <dx:BootstrapGridViewDateColumn FieldName="CreateDate" Caption="วันที่่บันทึก"
            Visible="false"
            PropertiesDateEdit-DisplayFormatString="dd/MM/yyyy HH:mm:ss" SettingsEditForm-Visible="False" />
        <dx:BootstrapGridViewTextColumn FieldName="CreateBy" Caption="ผู้บันทึก" Visible="false">
            <SettingsEditForm Visible="False" />
        </dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="ModifyDate" Caption="วันที่แก้ไข" Visible="false">
            <SettingsEditForm Visible="False" />
        </dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="ModifyBy" Caption="ผู้แก้ไข" Visible="false">
            <SettingsEditForm Visible="False" />
        </dx:BootstrapGridViewTextColumn>




    </Columns>


</dx:BootstrapGridView>

<asp:SqlDataSource ID="SqlDataSource_BillingDetails" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
    SelectCommand="select * from v_Report1 Order By CreateDate desc"
     UpdateCommand="update tblPolicyRegister
    set ReceiveDate=@ReceiveDate
    ,ModifyDate=getdate()
    ,ModifyBy=@UserName
    where ID=@ID
    " 
    >

    <UpdateParameters> 
        <asp:Parameter Name="ReceiveDate" />
        
         <asp:Parameter Name="UserName" />
         <asp:Parameter Name="ID" />
    </UpdateParameters>
     
</asp:SqlDataSource>










