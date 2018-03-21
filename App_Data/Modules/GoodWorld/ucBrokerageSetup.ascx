<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ucBrokerageSetup.ascx.vb" Inherits="Modules_ucBrokerageSetup" %>

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
    KeyFieldName="BRID" SettingsBehavior-ConfirmDelete="true"
    SettingsBehavior-AllowDragDrop="true"
    SettingsPopup-EditForm-AllowResize="true"
    DataSourceID="SqlDataSource_Brokerage"
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


        <dx:BootstrapGridViewComboBoxColumn FieldName="InsurerCode" Caption="บริษัทประกันภัย" Width="250">
            <PropertiesComboBox DataSourceID="SqlDataSource_Insurer" TextField="InsurerName" ValueField="InsurerCode">
                <ValidationSettings>
                    <RequiredField IsRequired="true" />
                </ValidationSettings>
            </PropertiesComboBox>
        </dx:BootstrapGridViewComboBoxColumn>
        <dx:BootstrapGridViewComboBoxColumn FieldName="PolicyType" Caption="ประเภทกรมธรรม์" Width="300">
            <PropertiesComboBox DataSourceID="SqlDataSource_PolicyType" TextField="Name" ValueField="ID">
                <ValidationSettings>
                    <RequiredField IsRequired="true" />
                </ValidationSettings>
            </PropertiesComboBox>
        </dx:BootstrapGridViewComboBoxColumn>
        <dx:BootstrapGridViewSpinEditColumn FieldName="BRCommP"  Caption="ค่าคอมตามกฎหมาย(%)"
            PropertiesSpinEdit-NumberType="Float"  
            PropertiesSpinEdit-NullText="0.00" PropertiesSpinEdit-AllowNull="false" PropertiesSpinEdit-MinValue="0.00" PropertiesSpinEdit-MaxValue="99.00"
            PropertiesSpinEdit-DisplayFormatString="{0:N2}" >
            <PropertiesSpinEdit>
                <ValidationSettings RequiredField-IsRequired="true"></ValidationSettings>
            </PropertiesSpinEdit>
        </dx:BootstrapGridViewSpinEditColumn>
        <dx:BootstrapGridViewSpinEditColumn FieldName="PRCommP"   Caption="ค่าส่งเสริมการขาย(%)"
            PropertiesSpinEdit-NumberType="Float"  
            PropertiesSpinEdit-NullText="0.00" PropertiesSpinEdit-AllowNull="false" PropertiesSpinEdit-MinValue="0.00" PropertiesSpinEdit-MaxValue="99.00"
            PropertiesSpinEdit-DisplayFormatString="{0:N2}" >
            <PropertiesSpinEdit>
                <ValidationSettings RequiredField-IsRequired="true"></ValidationSettings>
            </PropertiesSpinEdit>
        </dx:BootstrapGridViewSpinEditColumn>

        <dx:BootstrapGridViewCheckColumn FieldName="IsActive"></dx:BootstrapGridViewCheckColumn>
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

<asp:SqlDataSource ID="SqlDataSource_Brokerage" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
    SelectCommand="select * from tblBrokerage "
    UpdateCommand="update tblBrokerage 
      set InsurerCode=@InsurerCode
      ,PolicyType=@PolicyType
      ,BRCommP=@BRCommP
      ,PRCommP=@PRCommP
    ,IsActive=@IsActive
      ,ModifyDate=getdate()
      ,ModifyBy=@UserName
    Where BRID=@BRID
    "
    InsertCommand="Insert into tblBrokerage(
         InsurerCode
        ,PolicyType
        ,BRCommP
        ,PRCommP
        ,IsActive
        ,CreateDate
        ,CreateBy
    )
    values(
       @InsurerCode
      ,@PolicyType
      ,@BRCommP
      ,@PRCommP
      ,@IsActive
      ,getdate()
      ,@UserName
    )">

    <UpdateParameters>
        <asp:Parameter Name="InsurerCode" />
        <asp:Parameter Name="PolicyType" />
        <asp:Parameter Name="BRCommP" />
        <asp:Parameter Name="PRCommP" />
        <asp:Parameter Name="IsActive" />
        <asp:Parameter Name="BRID" />
        <asp:Parameter Name="UserName" />
    </UpdateParameters>

    <InsertParameters>
        <asp:Parameter Name="InsurerCode" />
        <asp:Parameter Name="PolicyType" />
        <asp:Parameter Name="BRCommP" />
        <asp:Parameter Name="PRCommP" />
        <asp:Parameter Name="IsActive" />
        <asp:Parameter Name="UserName" />
    </InsertParameters>

</asp:SqlDataSource>



 <asp:SqlDataSource ID="SqlDataSource_Insurer" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
    SelectCommand="select InsurerCode,  InsurerName + ' (' + InsurerCode + ')' as InsurerName  from tblInsurer ">
</asp:SqlDataSource>

 <asp:SqlDataSource ID="SqlDataSource_PolicyType" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
    SelectCommand="select a.ID
     ,  a.Code + ' - ' + a.Name + ' (' + b.Name + ')' as Name
     
     from tblPolicyType a
     inner join tblInsureType b on a.InsureType = b.Code
     Order by a.OrderNo ">
</asp:SqlDataSource>
