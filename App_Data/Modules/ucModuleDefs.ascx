<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ucModuleDefs.ascx.vb" Inherits="Modules_ucModuleDefs" %>

<style>
    .saveBt
    {
        margin-right: 10px;
    }
</style>

<dx:BootstrapGridView ID="TaskGrid" runat="server"
    ClientInstanceName="taskGrid"
    AutoGenerateColumns="False"
    KeyFieldName="ModuleDefId" SettingsBehavior-ConfirmDelete="true"
    SettingsBehavior-AllowDragDrop="true"
    SettingsPopup-EditForm-AllowResize="true"
    DataSourceID="SqlDataSource_Modules"
    Width="100%"
    PopupAnimationType="Fade" CloseOnEscape="true" CloseAction="None">
    <ClientSideEvents ToolbarItemClick="function(s,e){
             switch (e.item.name) {
                case 'ExportToPDF':
                case 'ExportToXLSX':
                case 'Upload':
                    pcUpload.Show();
                    //e.processOnServer = true;
                    //e.usePostBack = true;
                    DXUploadedFilesContainer.Clear();
                    break;
            }
        
        }" />

    <CssClasses Control="tasks-grid" PreviewRow="text-muted" />
    <Toolbars>
        <dx:BootstrapGridViewToolbar>
            <Items>
                <dx:BootstrapGridViewToolbarItem Command="New" />
                <dx:BootstrapGridViewToolbarItem Command="Edit" />
                <dx:BootstrapGridViewToolbarItem Command="Delete" />
                <dx:BootstrapGridViewToolbarItem Command="Refresh" BeginGroup="true" />
                <dx:BootstrapGridViewToolbarItem Command="ClearGrouping" />
                <dx:BootstrapGridViewToolbarItem Command="ClearSorting" />
                <dx:BootstrapGridViewToolbarItem Command="ShowGroupPanel" BeginGroup="true" />
                <dx:BootstrapGridViewToolbarItem Command="ShowSearchPanel" />

                <dx:BootstrapGridViewToolbarItem BeginGroup="true"
                    Command="Custom" Name="Upload" Text="Upload Control">
                </dx:BootstrapGridViewToolbarItem>

                <%--<dx:BootstrapGridViewToolbarItem Text="Upload Control" Command="Custom">
                    <Template>
                        <dx:BootstrapButton ID="BootstrapButton1" runat="server" AutoPostBack="false" Text="Upload"></dx:BootstrapButton>
                    </Template>
                </dx:BootstrapGridViewToolbarItem>--%>
            </Items>
        </dx:BootstrapGridViewToolbar>
    </Toolbars>
    <Columns>
        <dx:BootstrapGridViewTextColumn FieldName="ModuleDefName"
            Settings-AllowFilterBySearchPanel="True">
            <PropertiesTextEdit>
                <ValidationSettings>
                    <RequiredField IsRequired="true" />
                </ValidationSettings>
            </PropertiesTextEdit>
        </dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewComboBoxColumn
            FieldName="ModuleDefSourceFile">
            <PropertiesComboBox DataSourceID="ObjectDataSource_ModuleFiles">
                <ValidationSettings>
                    <RequiredField IsRequired="true" />
                </ValidationSettings>
            </PropertiesComboBox>
        </dx:BootstrapGridViewComboBoxColumn>
        <dx:BootstrapGridViewDateColumn FieldName="CreateDate" Width="100" PropertiesDateEdit-DisplayFormatString="dd/MM/yyyy" AdaptivePriority="2" SettingsEditForm-Visible="False" />
        <dx:BootstrapGridViewDateColumn FieldName="ModifyDate" Width="100" PropertiesDateEdit-DisplayFormatString="dd/MM/yyyy" AdaptivePriority="2" SettingsEditForm-Visible="False" />


    </Columns>
    <SettingsEditing Mode="PopupEditForm" EditFormColumnSpan="12">
        <FormLayoutProperties LayoutType="Horizontal"></FormLayoutProperties>
    </SettingsEditing>
    <SettingsBehavior AllowFocusedRow="true" />
    <Settings ShowGroupPanel="true" />
    <SettingsDataSecurity AllowEdit="true" AllowInsert="true" AllowDelete="true" />
    <SettingsPager AlwaysShowPager="true" ShowEmptyDataRows="false" PageSize="5">
        <PageSizeItemSettings Visible="true" Items="5,8,12,20" />
    </SettingsPager>

    <SettingsCommandButton>
        <EditButton CssClass="edit-btn" RenderMode="Button" Text=" " />
        <UpdateButton RenderMode="Button" Text="Save" CssClass="saveBt" />
        <CancelButton RenderMode="Button" />
    </SettingsCommandButton>

    <%--    
    <SettingsPopup EditForm-ResizingMode="Live" CustomizationWindow-AllowResize="true"></SettingsPopup>
    <SettingsDataSecurity AllowEdit="true" AllowInsert="true" />--%>

    <%--<SettingsAdaptivity AdaptivityMode="HideDataCells" ></SettingsAdaptivity>--%>


    <%--    <SettingsSearchPanel CustomEditorID="SearchBox" />
    <SettingsBehavior AllowFocusedRow="true" />
    --%>
</dx:BootstrapGridView>





<asp:ObjectDataSource ID="ObjectDataSource_ModuleFiles" runat="server" SelectMethod="GetModulePath" TypeName="MyObjectDataSource">
    <SelectParameters>
        <asp:Parameter Name="rootpath" />
        <asp:Parameter Name="pathname" />
    </SelectParameters>
</asp:ObjectDataSource>


<asp:SqlDataSource ID="SqlDataSource_Modules" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
    SelectCommand="select * from PortalCfg_ModuleDefinitions 
    Where PortalId=@PortalId and ModuleDefSourceFile like @ModulePathName + '%'
    Order By ModuleDefName"
    UpdateCommand="update PortalCfg_ModuleDefinitions 
    set  ModuleDefName=@ModuleDefName
    ,ModuleDefSourceFile=@ModuleDefSourceFile
    ,ModifyDate=getdate()
    Where ModuleDefId=@ModuleDefId"
    InsertCommand="Insert into PortalCfg_ModuleDefinitions(
                                            PortalID
                                            ,ModuleDefCode
                                            ,ModuleDefName
                                            ,ModuleDefDesc
                                            ,ModuleDefSourceFile
                                            ,CreateDate )
    values(
       @PortalID
     , newid()
     , @ModuleDefName
     , @ModuleDefDesc
    , @ModuleDefSourceFile
    , getdate()
    )

   

    "
    DeleteCommand="delete from PortalCfg_ModuleDefinitions where ModuleDefId=@ModuleDefId;
    delete from PortalCfg_Modules where ModuleDefId=@ModuleDefId;
    ">
    <UpdateParameters>

        <asp:Parameter Name="ModuleDefName" />
        <asp:Parameter Name="ModuleDefSourceFile" />
        <asp:Parameter Name="ModuleDefId" DbType="Int32" />
    </UpdateParameters>

    <DeleteParameters>
        <asp:Parameter Name="ModuleDefId" DbType="Int32" />
    </DeleteParameters>


    <InsertParameters>
        <asp:SessionParameter Name="PortalId" SessionField="PortalId" />
        <asp:Parameter Name="ModuleDefName" />
        <asp:Parameter Name="ModuleDefDesc" />
        <asp:Parameter Name="ModuleDefSourceFile" />



    </InsertParameters>


    <SelectParameters>
        <asp:SessionParameter Name="PortalId" SessionField="PortalId" />
        <asp:Parameter Name="ModulePathName" />
    </SelectParameters>

</asp:SqlDataSource>

<dx:BootstrapPopupControl ID="pcUpload"
    ClientInstanceName="pcUpload"
    runat="server" Modal="true" HeaderText="Upload Control"
    PopupElementCssSelector="#default-popup-control-5"
    PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="TopSides" Width="500px" 
    CloseAction="CloseButton">
    <ContentCollection>

        <dx:ContentControl>

            <dx:BootstrapUploadControl ID="UploadControlMultiSelection" ClientInstanceName="uploadcontrol"
                runat="server" ShowUploadButton="true" NullText="Select multiple files...">
                <%--BeginHide--%>
                <CssClasses Control="ctrl-fixed-width-lg" />
                <%--EndHide--%>

                <ValidationSettings MaxFileSize="4194304" AllowedFileExtensions=".vb,.ascx" />
                <AdvancedModeSettings EnableMultiSelect="true" EnableFileList="true" />

                <ClientSideEvents FilesUploadComplete="function(s,e){
                    
                    alert('Upload Complete.');
                    pcUpload.Hide();
                    }" />
            </dx:BootstrapUploadControl>

        </dx:ContentControl>


    </ContentCollection>

</dx:BootstrapPopupControl>
