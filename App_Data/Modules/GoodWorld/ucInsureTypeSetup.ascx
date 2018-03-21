<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ucInsureTypeSetup.ascx.vb" Inherits="Modules_ucInsureTypeSetup" %>

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
    DataSourceID="SqlDataSource_InsureType"
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
         
        <dx:BootstrapGridViewTextColumn FieldName="Name"
            Settings-AllowFilterBySearchPanel="True">
            <PropertiesTextEdit>
                <ValidationSettings>
                    <RequiredField IsRequired="true" />
                </ValidationSettings>
            </PropertiesTextEdit>
        </dx:BootstrapGridViewTextColumn>
         <dx:BootstrapGridViewTextColumn FieldName="Code"
            Settings-AllowFilterBySearchPanel="True">
            <PropertiesTextEdit>
                <ValidationSettings>
                    <RequiredField IsRequired="true" />
                </ValidationSettings>
            </PropertiesTextEdit>
        </dx:BootstrapGridViewTextColumn>

        <dx:BootstrapGridViewCheckColumn FieldName="IsActive" ></dx:BootstrapGridViewCheckColumn>

        <dx:BootstrapGridViewSpinEditColumn FieldName="OrderNo" 
            PropertiesSpinEdit-NumberType="Integer"  
            PropertiesSpinEdit-NullText="1" PropertiesSpinEdit-AllowNull="false" PropertiesSpinEdit-MinValue="1" PropertiesSpinEdit-MaxValue="99"
            PropertiesSpinEdit-DisplayFormatString="{0:N0}" >
            <PropertiesSpinEdit>
                <ValidationSettings RequiredField-IsRequired="true"></ValidationSettings>
            </PropertiesSpinEdit>
        </dx:BootstrapGridViewSpinEditColumn>


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
    SelectCommand="select * from tblInsureType Order By OrderNo"

    UpdateCommand="update tblInsureType 
      set Name=@Name
      ,Code=@Code
      ,OrderNo=@OrderNo
      ,IsActive=@IsActive
      ,ModifyDate=getdate()
     ,ModifyBy=@UserName
    Where ID=@ID
    "
    InsertCommand="Insert into tblInsureType(Name,Code,OrderNo,IsActive,CreateDate, CreateBy )
    values(@Name,@Code,@OrderNo,@IsActive,getdate(),@UserName)">

    <UpdateParameters>
        <asp:Parameter Name="Name" />
        <asp:Parameter Name="Code" />
        <asp:Parameter Name="OrderNo" />
        <asp:Parameter Name="IsActive" />
        <asp:Parameter Name="UserName" />
        <asp:Parameter Name="ID" />
    </UpdateParameters>

    <InsertParameters>
        <asp:Parameter Name="Name" />
        <asp:Parameter Name="Code" />
        <asp:Parameter Name="OrderNo" />
        <asp:Parameter Name="IsActive" />
        <asp:Parameter Name="UserName" />
    </InsertParameters>

</asp:SqlDataSource>
