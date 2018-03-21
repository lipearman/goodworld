﻿<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ucSubAgentSetup.ascx.vb" Inherits="Modules_ucSubAgentSetup" %>

<style>
    .saveBt
    {
        margin-right: 10px;
    }
</style>
<fieldset>
    <legend class="text-primary"><%=PageName %></legend>
</fieldset>
<dx:BootstrapGridView ID="TaskGrid" runat="server"
    ClientInstanceName="taskGrid" EnableRowsCache="false"
    AutoGenerateColumns="False"
    KeyFieldName="ID" SettingsBehavior-ConfirmDelete="true"
    SettingsBehavior-AllowDragDrop="true"
    SettingsPopup-EditForm-AllowResize="true"
    DataSourceID="SqlDataSource_SubAgent"
    Width="100%"
    PopupAnimationType="Fade" CloseOnEscape="true" CloseAction="None">
    <CssClasses Control="tasks-grid" PreviewRow="text-muted" />
    <Toolbars>
        <dx:BootstrapGridViewToolbar>
            <Items>
                <dx:BootstrapGridViewToolbarItem Command="New" />
                <dx:BootstrapGridViewToolbarItem Command="Edit" />
                <dx:BootstrapGridViewToolbarItem Command="Refresh" BeginGroup="true" />
                <dx:BootstrapGridViewToolbarItem Command="ClearSorting" />
                <dx:BootstrapGridViewToolbarItem Command="ShowSearchPanel" />
            </Items>
        </dx:BootstrapGridViewToolbar>
    </Toolbars>
    <Columns>

        <dx:BootstrapGridViewTextColumn FieldName="SubAgentCode"
            Settings-AllowFilterBySearchPanel="True">
            <PropertiesTextEdit>
                <ValidationSettings>
                    <RequiredField IsRequired="true" />
                </ValidationSettings>
            </PropertiesTextEdit>
        </dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="SubAgentName"
            Settings-AllowFilterBySearchPanel="True">
            <PropertiesTextEdit>
                <ValidationSettings>
                    <RequiredField IsRequired="true" />
                </ValidationSettings>
            </PropertiesTextEdit>
        </dx:BootstrapGridViewTextColumn>

 <dx:BootstrapGridViewComboBoxColumn FieldName="AgentCode" Caption="Sub-Broker " >
            <PropertiesComboBox DataSourceID="SqlDataSource_SubBroker" TextField="AgentName" ValueField="AgentCode">
                <ValidationSettings>
                    <RequiredField IsRequired="true" />
                </ValidationSettings>
            </PropertiesComboBox>
        </dx:BootstrapGridViewComboBoxColumn>


        <dx:BootstrapGridViewTextColumn FieldName="CertificateNo" Settings-AllowFilterBySearchPanel="True">
        </dx:BootstrapGridViewTextColumn>


        <dx:BootstrapGridViewCheckColumn FieldName="IsActive"></dx:BootstrapGridViewCheckColumn>
        <dx:BootstrapGridViewDateColumn FieldName="CreateDate"   PropertiesDateEdit-DisplayFormatString="dd/MM/yyyy HH:mm:ss" AdaptivePriority="2" SettingsEditForm-Visible="False" />
        <dx:BootstrapGridViewTextColumn FieldName="CreateBy" Settings-AllowFilterBySearchPanel="True" SettingsEditForm-Visible="False"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewDateColumn FieldName="ModifyDate"  PropertiesDateEdit-DisplayFormatString="dd/MM/yyyy HH:mm:ss" AdaptivePriority="2" SettingsEditForm-Visible="False" />
        <dx:BootstrapGridViewTextColumn FieldName="ModifyBy" Settings-AllowFilterBySearchPanel="True" SettingsEditForm-Visible="False"></dx:BootstrapGridViewTextColumn>


    </Columns>
    <SettingsEditing Mode="PopupEditForm" EditFormColumnSpan="12">
        <FormLayoutProperties LayoutType="Horizontal"></FormLayoutProperties>
    </SettingsEditing>
    <SettingsBehavior AllowFocusedRow="true" />
    <SettingsDataSecurity AllowEdit="true" AllowInsert="true" AllowDelete="false" />
    <SettingsPager AlwaysShowPager="true" ShowEmptyDataRows="false" PageSize="5">
        <PageSizeItemSettings Visible="true" Items="5,8,12,20" />
    </SettingsPager>

    <SettingsCommandButton>
        <EditButton CssClass="edit-btn" RenderMode="Button" Text=" " />
        <UpdateButton RenderMode="Button" Text="Save" CssClass="saveBt" />
        <CancelButton RenderMode="Button" />
    </SettingsCommandButton>

      <SettingsAdaptivity AdaptivityMode="HideDataCells" AllowOnlyOneAdaptiveDetailExpanded="true" />
</dx:BootstrapGridView>

<asp:SqlDataSource ID="SqlDataSource_SubBroker" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
    SelectCommand="select AgentCode, AgentCode  + ' - '  +  AgentName as AgentName from tblSubBroker Order by AgentCode "></asp:SqlDataSource>

<asp:SqlDataSource ID="SqlDataSource_SubAgent" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
    SelectCommand="select * from tblSubAgent Order By SubAgentName"
    UpdateCommand="update tblSubAgent 
        set SubAgentName=@SubAgentName
        ,SubAgentCode=@SubAgentCode
        ,AgentCode=@AgentCode
        ,CertificateNo=@CertificateNo
        ,IsActive=@IsActive
        ,ModifyDate=getdate()
        ,ModifyBy=@UserName
        Where ID=@ID
    "
    InsertCommand="Insert into tblSubAgent(
        SubAgentName
        ,SubAgentCode
        ,AgentCode
        ,CertificateNo
        ,IsActive
        ,CreateDate 
        ,CreateBy 
    )
    values(
        @SubAgentName
        ,@SubAgentCode
        ,@AgentCode
        ,@CertificateNo
        ,@IsActive
        ,getdate()
        ,@UserName
    )">

    <UpdateParameters>
        <asp:Parameter Name="SubAgentName" />
        <asp:Parameter Name="SubAgentCode" />
        <asp:Parameter Name="AgentCode" />
        <asp:Parameter Name="CertificateNo" />
        <asp:Parameter Name="IsActive" />
        <asp:Parameter Name="UserName" />
        <asp:Parameter Name="ID" />
    </UpdateParameters>

    <InsertParameters>
        <asp:Parameter Name="SubAgentName" />
        <asp:Parameter Name="SubAgentCode" />
        <asp:Parameter Name="AgentCode" />
        <asp:Parameter Name="CertificateNo" />
        <asp:Parameter Name="IsActive" />
        <asp:Parameter Name="UserName" />
    </InsertParameters>

</asp:SqlDataSource>
