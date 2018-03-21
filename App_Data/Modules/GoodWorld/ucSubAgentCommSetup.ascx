<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ucSubAgentCommSetup.ascx.vb" Inherits="Modules_ucSubAgentCommSetup" %>

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
    ClientInstanceName="taskGrid"
    AutoGenerateColumns="False"  EnableRowsCache="false"
    KeyFieldName="SubAgentCommID" SettingsBehavior-ConfirmDelete="true"
    SettingsBehavior-AllowDragDrop="true"
    SettingsPopup-EditForm-AllowResize="true"
    DataSourceID="SqlDataSource_SubAgentComm"
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


        <dx:BootstrapGridViewComboBoxColumn FieldName="SubAgentCode" Caption="Sub Agent">
            <PropertiesComboBox DataSourceID="SqlDataSource_SubAgent" TextField="SubAgentName" ValueField="SubAgentCode">
                <ValidationSettings>
                    <RequiredField IsRequired="true" />
                </ValidationSettings>
            </PropertiesComboBox>
        </dx:BootstrapGridViewComboBoxColumn>
        <dx:BootstrapGridViewComboBoxColumn FieldName="InsureType" Caption="ประเภทการประกันภัย">
            <PropertiesComboBox DataSourceID="SqlDataSource_InsureType" TextField="Name" ValueField="ID">
                <ValidationSettings>
                    <RequiredField IsRequired="true" />
                </ValidationSettings>
            </PropertiesComboBox>
        </dx:BootstrapGridViewComboBoxColumn>
        <dx:BootstrapGridViewSpinEditColumn FieldName="SubAgentCommP"  Caption="ค่าคอม(%)"
            PropertiesSpinEdit-NumberType="Float"  
            PropertiesSpinEdit-NullText="0.00" PropertiesSpinEdit-AllowNull="false" PropertiesSpinEdit-MinValue="0.00" PropertiesSpinEdit-MaxValue="99.00"
            PropertiesSpinEdit-DisplayFormatString="{0:N2}" >
            <PropertiesSpinEdit>
                <ValidationSettings RequiredField-IsRequired="true"></ValidationSettings>
            </PropertiesSpinEdit>
        </dx:BootstrapGridViewSpinEditColumn>
    
        <dx:BootstrapGridViewCheckColumn FieldName="IsActive"></dx:BootstrapGridViewCheckColumn>
        <dx:BootstrapGridViewDateColumn FieldName="CreateDate"   PropertiesDateEdit-DisplayFormatString="dd/MM/yyyy HH:mm:ss" AdaptivePriority="2" SettingsEditForm-Visible="False" />
      <dx:BootstrapGridViewTextColumn FieldName="CreateBy" Settings-AllowFilterBySearchPanel="True"  SettingsEditForm-Visible="False" ></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewDateColumn FieldName="ModifyDate"   PropertiesDateEdit-DisplayFormatString="dd/MM/yyyy HH:mm:ss" AdaptivePriority="2" SettingsEditForm-Visible="False" />
    <dx:BootstrapGridViewTextColumn FieldName="ModifyBy" Settings-AllowFilterBySearchPanel="True"  SettingsEditForm-Visible="False" ></dx:BootstrapGridViewTextColumn>
        
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



<%--
    ,InsurerCode
,InsureType
,BRCommP
,PRCommP
,IsActive
,CreateDate
,CreateBy
,ModifyDate
,ModifyBy--%>

<asp:SqlDataSource ID="SqlDataSource_SubAgentComm" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
    SelectCommand="select * from tblSubAgentComm "
    UpdateCommand="update tblSubAgentComm 
      set SubAgentCode=@SubAgentCode
      ,InsureType=@InsureType
      ,SubAgentCommP=@SubAgentCommP
      ,IsActive=@IsActive
      ,ModifyDate=getdate()
      ,ModifyBy=@UserName

    Where SubAgentCommID=@SubAgentCommID
    "
    InsertCommand="Insert into tblSubAgentComm(
         SubAgentCode
        ,InsureType
        ,SubAgentCommP
        ,IsActive
        ,CreateDate
        ,CreateBy
    )
    values(
       @SubAgentCode
      ,@InsureType
      ,@SubAgentCommP
      ,@IsActive
      ,getdate()
      ,@UserName
    )">

    <UpdateParameters>
        <asp:Parameter Name="SubAgentCode" />
        <asp:Parameter Name="InsureType" />
        <asp:Parameter Name="SubAgentCommP" />
        <asp:Parameter Name="IsActive" />
        <asp:Parameter Name="SubAgentCommID" />
        <asp:Parameter Name="UserName" />
    </UpdateParameters>

    <InsertParameters>
        <asp:Parameter Name="SubAgentCode" />
        <asp:Parameter Name="InsureType" />
        <asp:Parameter Name="SubAgentCommP" />
        <asp:Parameter Name="IsActive" />
        <asp:Parameter Name="UserName" />
    </InsertParameters>

</asp:SqlDataSource>



 <asp:SqlDataSource ID="SqlDataSource_SubAgent" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
    SelectCommand="select SubAgentCode,  SubAgentName + ' (' + SubAgentCode + ')' as SubAgentName  from tblSubAgent ">
</asp:SqlDataSource>

 <asp:SqlDataSource ID="SqlDataSource_InsureType" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
    SelectCommand="select ID, Name from tblInsureType Order by OrderNo ">
</asp:SqlDataSource>
