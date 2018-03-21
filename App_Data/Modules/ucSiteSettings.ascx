<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ucSiteSettings.ascx.vb" Inherits="Modules_ucSiteSettings" %>
<style>
    .saveBt {
    margin-right:10px;
}
</style>

<dx:BootstrapGridView ID="TaskGrid" runat="server"
    ClientInstanceName="taskGrid"
    AutoGenerateColumns="False"
    KeyFieldName="PortalId" 
    DataSourceID="SqlDataSource_Project"
    Width="100%"
    PopupAnimationType="Fade" CloseOnEscape="true" CloseAction="None">
   <%--     <CssClasses Control="tasks-grid" PreviewRow="text-muted" />--%>

    <Columns>
      <dx:BootstrapGridViewCommandColumn ShowEditButton="true">
 
        </dx:BootstrapGridViewCommandColumn>


        <dx:BootstrapGridViewTextColumn FieldName="PortalCode" Settings-AllowFilterBySearchPanel="True" SettingsEditForm-Visible="False" />
        <dx:BootstrapGridViewTextColumn FieldName="PortalName" Settings-AllowFilterBySearchPanel="True" />
        <dx:BootstrapGridViewCheckColumn FieldName="UnderConstruction" Settings-AllowFilterBySearchPanel="True" />
        <dx:BootstrapGridViewDateColumn FieldName="CreateDate" Width="100" PropertiesDateEdit-DisplayFormatString="dd/MM/yyyy" AdaptivePriority="2" SettingsEditForm-Visible="False" />
        <dx:BootstrapGridViewDateColumn FieldName="ModifyDate" Width="100" PropertiesDateEdit-DisplayFormatString="dd/MM/yyyy" AdaptivePriority="2" SettingsEditForm-Visible="False" />

  
    </Columns>
<SettingsEditing Mode="PopupEditForm" EditFormColumnSpan="12">
        <FormLayoutProperties LayoutType="Horizontal"></FormLayoutProperties>
    </SettingsEditing>


  
 
    <SettingsCommandButton>
        <EditButton RenderMode="Button" CssClass="edit-btn" Text=" " />
        <UpdateButton RenderMode="Button" Text="Save" CssClass="saveBt" />
        <CancelButton RenderMode="Button" />
        
    </SettingsCommandButton>
    <SettingsDataSecurity AllowEdit="true" />
 
</dx:BootstrapGridView>





<asp:SqlDataSource ID="SqlDataSource_Project" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
    SelectCommand="select * from PortalCfg_Globals Where PortalId=@PortalId"
    UpdateCommand="update PortalCfg_Globals 
    set PortalName=@PortalName
        ,UnderConstruction=@UnderConstruction
        ,PortalCode=@PortalCode
        ,PortalPage=@PortalPage
        ,ModifyDate=getdate()
 
    Where PortalId=@PortalId"
    InsertCommand="Insert into PortalCfg_Globals(PortalName
                                                ,UnderConstruction
                                                ,PortalCode
                                                ,PortalPage
                                                ,CreateDate
                                                )
    values(
     @PortalName
     , @UnderConstruction
     , @PortalCode
     , @PortalPage
     , getdate()
 
    )



    ">
    <UpdateParameters>
        <asp:Parameter Name="PortalName" />
        <asp:Parameter Name="UnderConstruction" />
        <asp:Parameter Name="PortalCode" />
        <asp:Parameter Name="PortalPage" />

        <asp:Parameter Name="PortalId" DbType="Int32" />
    </UpdateParameters>




    <InsertParameters>
        <asp:Parameter Name="PortalName" />
        <asp:Parameter Name="UnderConstruction" />
        <asp:Parameter Name="PortalCode" />
        <asp:Parameter Name="PortalPage" />

    </InsertParameters>


    <SelectParameters>
        <asp:SessionParameter Name="PortalId" SessionField="PortalId" />
    </SelectParameters>


</asp:SqlDataSource>
