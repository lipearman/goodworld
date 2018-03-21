<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ucUsers.ascx.vb" Inherits="ucUsers" %>


<style>
    .saveBt
    {
        margin-right: 10px;
    }
</style>
<asp:SqlDataSource ID="SqlDataSource_Users" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
    SelectCommand="select * from ProjectRoleUsers where UserID not in(1)"
    DeleteCommand="
    delete from Portal_Users_DefaultPage where UserID=@UserID and UserID not in(1);
    delete from Portal_UserTabs where UserID=@UserID and UserID not in(1);
    delete from Portal_UserRoles where UserID=@UserID and UserID not in(1);
    delete from Portal_Users where UserID=@UserID and UserID not in(1);
    "
    InsertCommand="insert into Portal_Users(
         UserName
        ,Password
        ,Email
        ,CreationDate
        ,IsActive
    )
    Values
    (
         @UserName
        ,@Password
        ,@Email
        ,getdate()
        ,@IsActive
    );
    insert into Portal_UserRoles(UserID,RoleID)
    select UserID,@RoleID from Portal_Users where UserName=@UserName;
    "
     UpdateCommand="

     UPDATE Portal_Users
     SET  Password = @Password 
          ,Email = @Email 
          ,IsActive = @IsActive
     WHERE UserID=@UserID;

    update Portal_UserRoles
    set RoleID=@RoleID
    where UserID=@UserID;




    "
    
    >
    <UpdateParameters>
        <asp:Parameter Name="UserID" />
        <asp:Parameter Name="Password" />
        <asp:Parameter Name="RoleID" />
        <asp:Parameter Name="Email" />
        <asp:Parameter Name="IsActive" />
    </UpdateParameters>
    <InsertParameters>
        <asp:Parameter Name="UserName" />
        <asp:Parameter Name="Password" />
        <asp:Parameter Name="RoleID" />
        <asp:Parameter Name="Email" />
        <asp:Parameter Name="IsActive" />

    </InsertParameters>
    <DeleteParameters>
        <asp:Parameter Name="UserID" />
    </DeleteParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="SqlDataSource_Role" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
    SelectCommand="select * from Portal_Roles"></asp:SqlDataSource>

<dx:BootstrapGridView ID="TaskGrid" runat="server"
    ClientInstanceName="taskGrid"
    AutoGenerateColumns="False"
    KeyFieldName="UserID" SettingsBehavior-ConfirmDelete="true"
    SettingsBehavior-AllowDragDrop="true"
    SettingsPopup-EditForm-AllowResize="true"
    DataSourceID="SqlDataSource_Users"
    Width="100%"
    PopupAnimationType="Fade" CloseOnEscape="true" CloseAction="None">
    <CssClasses Control="tasks-grid" PreviewRow="text-muted" />

    <ClientSideEvents EndCallback="function(s,e){
        
         if (s.IsNewRowEditing()) {
             
            } 
        else
            if (s.IsEditing()) {
                s.GetEditor('UserName').SetEnabled(false);
            }
        }" />


    <Toolbars>
        <dx:BootstrapGridViewToolbar>
            <Items>
                <dx:BootstrapGridViewToolbarItem Command="New" />
                <dx:BootstrapGridViewToolbarItem Command="Edit" />
                <dx:BootstrapGridViewToolbarItem Command="Delete" />
                <dx:BootstrapGridViewToolbarItem Command="Refresh" BeginGroup="true" />
                <%--               <dx:BootstrapGridViewToolbarItem Command="ClearGrouping" />
                <dx:BootstrapGridViewToolbarItem Command="ClearSorting" />
                <dx:BootstrapGridViewToolbarItem Command="ShowGroupPanel" BeginGroup="true" />--%>
                <dx:BootstrapGridViewToolbarItem Command="ShowSearchPanel" />
            </Items>
        </dx:BootstrapGridViewToolbar>
    </Toolbars>
    <Columns>

<%--        <dx:BootstrapGridViewTextColumn FieldName="UserID" SettingsEditForm-Visible="False">
        </dx:BootstrapGridViewTextColumn>--%>
        <dx:BootstrapGridViewTextColumn FieldName="UserName" PropertiesTextEdit-ValidationSettings-RequiredField-IsRequired="true"
            Settings-AllowFilterBySearchPanel="True">
            <SettingsEditForm Visible="True" VisibleIndex="0" />
        </dx:BootstrapGridViewTextColumn>

        <dx:BootstrapGridViewTextColumn FieldName="Password">
            <PropertiesTextEdit>
                <ValidationSettings RequiredField-IsRequired="true"></ValidationSettings>
            </PropertiesTextEdit>
            <SettingsEditForm Visible="True" VisibleIndex="1" />
        </dx:BootstrapGridViewTextColumn>

        <dx:BootstrapGridViewTextColumn FieldName="Email"
            PropertiesTextEdit-ValidationSettings-RequiredField-IsRequired="true">
            <SettingsEditForm Visible="True" VisibleIndex="2" />
        </dx:BootstrapGridViewTextColumn>

        <dx:BootstrapGridViewDateColumn FieldName="CreationDate" Width="100" PropertiesDateEdit-DisplayFormatString="dd/MM/yyyy" AdaptivePriority="2" SettingsEditForm-Visible="False" />
        <%--<dx:BootstrapGridViewDateColumn FieldName="ExpiredDate" Width="100" PropertiesDateEdit-DisplayFormatString="dd/MM/yyyy" AdaptivePriority="2" SettingsEditForm-Visible="False" />--%>

        <dx:BootstrapGridViewComboBoxColumn Caption="Role"
            FieldName="RoleID">
            <PropertiesComboBox DataSourceID="SqlDataSource_Role" TextField="RoleName" ValueField="RoleID">
                <ValidationSettings>
                    <RequiredField IsRequired="true" />
                </ValidationSettings>
            </PropertiesComboBox>
            <SettingsEditForm Visible="True" VisibleIndex="3" />
        </dx:BootstrapGridViewComboBoxColumn>


        <dx:BootstrapGridViewCheckColumn FieldName="IsActive">
            <SettingsEditForm Visible="True" VisibleIndex="4" />
        </dx:BootstrapGridViewCheckColumn>
    </Columns>
    <SettingsEditing Mode="PopupEditForm" EditFormColumnSpan="12">
        <FormLayoutProperties LayoutType="Horizontal"></FormLayoutProperties>
    </SettingsEditing>
    <SettingsBehavior AllowFocusedRow="true" />
    <SettingsDataSecurity AllowEdit="true" AllowInsert="true" AllowDelete="true" />
    <SettingsPager AlwaysShowPager="true" ShowEmptyDataRows="false" PageSize="5">
        <PageSizeItemSettings Visible="true" Items="5,8,12,20" />
    </SettingsPager>

        <SettingsCommandButton>
        <EditButton RenderMode="Button" CssClass="edit-btn" Text=" " />
        <UpdateButton RenderMode="Button" Text="Save" CssClass="saveBt" />
        <CancelButton RenderMode="Button" />
        
    </SettingsCommandButton>
</dx:BootstrapGridView>


