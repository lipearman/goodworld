<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ucInsurerSetup.ascx.vb" Inherits="Modules_ucInsurerSetup" %>

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
    AutoGenerateColumns="False" CssClasses-HeaderRow="removeWrapping" CssClasses-Row="removeWrapping"
    KeyFieldName="ID" SettingsBehavior-ConfirmDelete="true"
    SettingsBehavior-AllowDragDrop="true"
    SettingsPopup-EditForm-AllowResize="true"
    DataSourceID="SqlDataSource_Insurer"
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

        <dx:BootstrapGridViewTextColumn FieldName="InsurerCode"
            Settings-AllowFilterBySearchPanel="True">
            <PropertiesTextEdit>
                <ValidationSettings>
                    <RequiredField IsRequired="true" />
                </ValidationSettings>
            </PropertiesTextEdit>
        </dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="InsurerName"
            Settings-AllowFilterBySearchPanel="True">
            <PropertiesTextEdit>
                <ValidationSettings>
                    <RequiredField IsRequired="true" />
                </ValidationSettings>
            </PropertiesTextEdit>
        </dx:BootstrapGridViewTextColumn>

         <dx:BootstrapGridViewComboBoxColumn FieldName="BranchCode" Caption="สาขา">
            <PropertiesComboBox >
                <Items>
                    <dx:BootstrapListEditItem Text="สำนักงานใหญ่" Value="HO" > </dx:BootstrapListEditItem>
                    <dx:BootstrapListEditItem Text="สาขาย่อย" Value="BR" > </dx:BootstrapListEditItem>
                </Items>
                <ValidationSettings>
                    <RequiredField IsRequired="true" />
                </ValidationSettings>
            </PropertiesComboBox>
        </dx:BootstrapGridViewComboBoxColumn>

        <dx:BootstrapGridViewTextColumn FieldName="AgentCode" Settings-AllowFilterBySearchPanel="True">
        </dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="Address1" Settings-AllowFilterBySearchPanel="True">
        </dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="Address2" Settings-AllowFilterBySearchPanel="True">
        </dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="Address3" Settings-AllowFilterBySearchPanel="True">
        </dx:BootstrapGridViewTextColumn>

         <dx:BootstrapGridViewTextColumn FieldName="CertificateNo" Caption="เลขที่" Settings-AllowFilterBySearchPanel="True">
        </dx:BootstrapGridViewTextColumn>

        <dx:BootstrapGridViewCheckColumn FieldName="IsActive"></dx:BootstrapGridViewCheckColumn>

        <dx:BootstrapGridViewDateColumn FieldName="CreateDate"  PropertiesDateEdit-DisplayFormatString="dd/MM/yyyy HH:mm:ss" AdaptivePriority="2" SettingsEditForm-Visible="False" />

        <dx:BootstrapGridViewDateColumn FieldName="ModifyDate"   PropertiesDateEdit-DisplayFormatString="dd/MM/yyyy HH:mm:ss" AdaptivePriority="2" SettingsEditForm-Visible="False" />
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


<asp:SqlDataSource ID="SqlDataSource_Insurer" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
    SelectCommand="select * from tblInsurer Order By InsurerName"
    UpdateCommand="update tblInsurer 
      set InsurerCode=@InsurerCode
      ,InsurerName=@InsurerName
      ,BranchCode=@BranchCode
      ,AgentCode=@AgentCode
      ,Address1=@Address1
      ,Address2=@Address2
      ,Address3=@Address3
      ,IsActive=@IsActive
      ,CertificateNo=@CertificateNo
      ,ModifyDate=getdate()
      ,ModifyBy=@UserName
    Where ID=@ID
    "
    InsertCommand="Insert into tblInsurer(
       InsurerCode
      ,InsurerName
    ,BranchCode
      ,AgentCode
      ,Address1
      ,Address2
      ,Address3
      ,IsActive
    ,CertificateNo
      ,CreateDate 
      ,CreateBy 
    )
    values(
       @InsurerCode
      ,@InsurerName
    ,@BranchCode
      ,@AgentCode
      ,@Address1
      ,@Address2
      ,@Address3
      ,@IsActive
    ,@CertificateNo
      ,getdate()
      ,@UserName
    )">

    <UpdateParameters>
        <asp:Parameter Name="InsurerCode" />
        <asp:Parameter Name="InsurerName" />
        <asp:Parameter Name="BranchCode" />
        <asp:Parameter Name="AgentCode" />
        <asp:Parameter Name="Address1" />
        <asp:Parameter Name="Address2" />
        <asp:Parameter Name="Address3" />
        <asp:Parameter Name="IsActive" />
        <asp:Parameter Name="ID" />
        <asp:Parameter Name="UserName" />
         <asp:Parameter Name="CertificateNo" />
    </UpdateParameters>

    <InsertParameters>
        <asp:Parameter Name="InsurerCode" />
        <asp:Parameter Name="InsurerName" />
         <asp:Parameter Name="BranchCode" />
        <asp:Parameter Name="AgentCode" />
        <asp:Parameter Name="Address1" />
        <asp:Parameter Name="Address2" />
        <asp:Parameter Name="Address3" />
        <asp:Parameter Name="IsActive" />
        <asp:Parameter Name="UserName" />
        <asp:Parameter Name="CertificateNo" />
    </InsertParameters>

</asp:SqlDataSource>
