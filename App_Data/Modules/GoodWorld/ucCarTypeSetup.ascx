<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ucCarTypeSetup.ascx.vb" Inherits="Modules_ucCarTypeSetup" %>

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
    ClientInstanceName="taskGrid"  EnableRowsCache="false"
    AutoGenerateColumns="False"
    KeyFieldName="ID" SettingsBehavior-ConfirmDelete="true"
    SettingsBehavior-AllowDragDrop="true"
    SettingsPopup-EditForm-AllowResize="true"
    DataSourceID="SqlDataSource_CarType"
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

  <dx:BootstrapGridViewComboBoxColumn FieldName="InsureType" Caption="ประเภทประกันภัย">
            <PropertiesComboBox DataSourceID="SqlDataSource_InsureType" TextField="Name" ValueField="InsureType">
                <ValidationSettings>
                    <RequiredField IsRequired="true" />
                </ValidationSettings>
            </PropertiesComboBox>
        </dx:BootstrapGridViewComboBoxColumn>

         <dx:BootstrapGridViewTextColumn FieldName="Code" Caption="รหัสรถ"
            Settings-AllowFilterBySearchPanel="True">
            <PropertiesTextEdit>
                <ValidationSettings>
                    <RequiredField IsRequired="true" />
                </ValidationSettings>
            </PropertiesTextEdit>
        </dx:BootstrapGridViewTextColumn>

        <dx:BootstrapGridViewTextColumn FieldName="Name" Caption="รายละเอียดรหัสรถ"
            Settings-AllowFilterBySearchPanel="True">
            <PropertiesTextEdit>
                <ValidationSettings>
                    <RequiredField IsRequired="true" />
                </ValidationSettings>
            </PropertiesTextEdit>
        </dx:BootstrapGridViewTextColumn>
        
        <dx:BootstrapGridViewCheckColumn FieldName="IsActive" ></dx:BootstrapGridViewCheckColumn>


      <dx:BootstrapGridViewDateColumn FieldName="CreateDate"  PropertiesDateEdit-DisplayFormatString="dd/MM/yyyy HH:mm:ss" AdaptivePriority="2" SettingsEditForm-Visible="False" />
      <dx:BootstrapGridViewTextColumn FieldName="CreateBy" Settings-AllowFilterBySearchPanel="True"  SettingsEditForm-Visible="False" ></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewDateColumn FieldName="ModifyDate"  PropertiesDateEdit-DisplayFormatString="dd/MM/yyyy HH:mm:ss" AdaptivePriority="2" SettingsEditForm-Visible="False" />
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


<asp:SqlDataSource ID="SqlDataSource_InsureType" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
    SelectCommand="select Code as InsureType,  Name + ' (' + Code + ')' as Name  from tblInsureType order by OrderNo "></asp:SqlDataSource>

 
<asp:SqlDataSource ID="SqlDataSource_CarType" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
    SelectCommand="select * from tblCarType Order By Name"

    UpdateCommand="update tblCarType 
      set Name=@Name
      ,Code=@Code
    ,InsureType=@InsureType
      ,IsActive=@IsActive
      ,ModifyDate=getdate()
     ,ModifyBy=@UserName
    Where ID=@ID
    "
    InsertCommand="Insert into tblCarType(Name,Code,InsureType,IsActive,CreateDate, CreateBy )
    values(@Name,@Code,@InsureType,@IsActive,getdate(),@UserName)">

    <UpdateParameters>
        <asp:Parameter Name="Name" />
        <asp:Parameter Name="Code" />
         <asp:Parameter Name="InsureType" />
        <asp:Parameter Name="IsActive" />
        <asp:Parameter Name="UserName" />
        <asp:Parameter Name="ID" />
    </UpdateParameters>

    <InsertParameters>
        <asp:Parameter Name="Name" />
        <asp:Parameter Name="Code" />
         <asp:Parameter Name="InsureType" />
        <asp:Parameter Name="IsActive" />
        <asp:Parameter Name="UserName" />
    </InsertParameters>

</asp:SqlDataSource>
