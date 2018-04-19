<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ucPolicyEnquiry.ascx.vb" Inherits="Modules_ucPolicyEnquiry" %>

<style>
    .saveBt {
        margin-right: 10px;
    }
</style>



<dx:BootstrapGridView ID="TaskGrid" runat="server"
    ClientInstanceName="taskGrid"
    AutoGenerateColumns="False"
    KeyFieldName="ID" SettingsBehavior-ConfirmDelete="true"
    SettingsBehavior-AllowDragDrop="true"
    SettingsPopup-EditForm-AllowResize="true"
    DataSourceID="SqlDataSource_Report1"
    Width="100%" CssClasses-HeaderRow="removeWrapping" CssClasses-Row="removeWrapping"
    PopupAnimationType="Fade" CloseOnEscape="true" CloseAction="None">
    <CssClasses Control="tasks-grid" PreviewRow="text-muted" />
    <SettingsSearchPanel Visible="true" AllowTextInputTimer="false" ShowApplyButton="true" />

    <Toolbars>
        <dx:BootstrapGridViewToolbar>
            <Items>
                <dx:BootstrapGridViewToolbarItem Command="Refresh" BeginGroup="true" />
                <dx:BootstrapGridViewToolbarItem Command="ClearSorting" />
            </Items>
        </dx:BootstrapGridViewToolbar>
    </Toolbars>
    <Columns>
        <dx:BootstrapGridViewTextColumn FieldName="InsurerName" Caption="บริษัทประกันภัย"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="ClientName" Caption="ผู้เอาประกัน"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="PolicyNo" Caption="หมายเลขกรมธรรม์"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewDateColumn FieldName="EffectiveDate" PropertiesDateEdit-DisplayFormatString="dd/MM/yyyy" />
        <dx:BootstrapGridViewDateColumn FieldName="ExpiredDate" PropertiesDateEdit-DisplayFormatString="dd/MM/yyyy" />
        <dx:BootstrapGridViewTextColumn FieldName="ClientName" Caption="ผู้เอาประกันภัย"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="CarLicensePlate" Caption="ทะเบียน"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="Chassis" Caption="เลขถัง"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewSpinEditColumn FieldName="Suminsured" Caption="จำนวนเงินเอาประกันภัย" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N0}"></dx:BootstrapGridViewSpinEditColumn>
        <dx:BootstrapGridViewSpinEditColumn FieldName="Premium" Caption="เบี้ยประกันภัย" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>
        <dx:BootstrapGridViewSpinEditColumn FieldName="Vat" Caption="ภาษี" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>
        <dx:BootstrapGridViewSpinEditColumn FieldName="Stamp" Caption="อากร" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>
        <dx:BootstrapGridViewSpinEditColumn FieldName="GrossPremium" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>
        <dx:BootstrapGridViewTextColumn FieldName="NewRenew" Caption="ใหม่/ต่อายุ"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="AgentCode" Caption="รหัสตัวแทน"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="AgentName" Caption="ตัวแทน"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewSpinEditColumn FieldName="Brokerage" Caption="ค่าคอม(%)" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>
        <dx:BootstrapGridViewTextColumn FieldName="BrokerageAmt" Caption="ค่าคอม(บาท)"></dx:BootstrapGridViewTextColumn>

    </Columns>
    <SettingsEditing Mode="PopupEditForm" EditFormColumnSpan="12">
        <FormLayoutProperties LayoutType="Horizontal"></FormLayoutProperties>
    </SettingsEditing>
    <SettingsPager AlwaysShowPager="true" ShowEmptyDataRows="false" PageSize="5">
        <PageSizeItemSettings Visible="true" Items="5,8,12,20" />
    </SettingsPager>
    <SettingsAdaptivity AdaptivityMode="HideDataCells" AllowOnlyOneAdaptiveDetailExpanded="true" />

</dx:BootstrapGridView>



<asp:SqlDataSource ID="SqlDataSource_Report1" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
    SelectCommand="select * from v_Report1 "></asp:SqlDataSource>
