<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ucSubCommSetup.ascx.vb" Inherits="Modules_ucSubCommSetup" %>

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
    ClientInstanceName="taskGrid" CssClasses-HeaderRow="removeWrapping" CssClasses-Row="removeWrapping"
    AutoGenerateColumns="False"  EnableRowsCache="false"
    KeyFieldName="SubCommID" SettingsBehavior-ConfirmDelete="true"
    SettingsBehavior-AllowDragDrop="true"
    SettingsPopup-EditForm-AllowResize="true"
    DataSourceID="SqlDataSource_SubComm"
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


        <dx:BootstrapGridViewComboBoxColumn FieldName="AgentCode" Caption="Sub Broker">
            <PropertiesComboBox DataSourceID="SqlDataSource_SubBroker" TextField="AgentName" ValueField="AgentCode">
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
        <dx:BootstrapGridViewSpinEditColumn FieldName="SubCommP"  Caption="ค่าคอม(%)"
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

<asp:SqlDataSource ID="SqlDataSource_SubComm" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
    SelectCommand="select * from tblSubComm "
    UpdateCommand="update tblSubComm 
      set AgentCode=@AgentCode
      ,InsureType=@InsureType
      ,SubCommP=@SubCommP
      ,IsActive=@IsActive
      ,ModifyDate=getdate()
      ,ModifyBy=@UserName

    Where SubCommID=@SubCommID
    "
    InsertCommand="Insert into tblSubComm(
         AgentCode
        ,InsureType
        ,SubCommP
        ,IsActive
        ,CreateDate
        ,CreateBy
    )
    values(
       @AgentCode
      ,@InsureType
      ,@SubCommP
      ,@IsActive
      ,getdate()
      ,@UserName
    )">

    <UpdateParameters>
        <asp:Parameter Name="AgentCode" />
        <asp:Parameter Name="InsureType" />
        <asp:Parameter Name="SubCommP" />
        <asp:Parameter Name="IsActive" />
        <asp:Parameter Name="SubCommID" />
        <asp:Parameter Name="UserName" />
    </UpdateParameters>

    <InsertParameters>
        <asp:Parameter Name="AgentCode" />
        <asp:Parameter Name="InsureType" />
        <asp:Parameter Name="SubCommP" />
        <asp:Parameter Name="IsActive" />
        <asp:Parameter Name="UserName" />
    </InsertParameters>

</asp:SqlDataSource>



 <asp:SqlDataSource ID="SqlDataSource_SubBroker" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
    SelectCommand="select AgentCode,  AgentName + ' (' + AgentCode + ')' as AgentName  from tblSubBroker ">
</asp:SqlDataSource>

 <asp:SqlDataSource ID="SqlDataSource_InsureType" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
    SelectCommand="select ID, Name from tblInsureType Order by OrderNo ">
</asp:SqlDataSource>
