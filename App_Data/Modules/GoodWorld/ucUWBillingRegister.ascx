<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ucUWBillingRegister.ascx.vb" Inherits="Modules_ucUWBillingRegister" %>

<style>
    legend {
        display: block;
        width: 100%;
        padding: 0;
        margin-bottom: 23px;
        font-size: 14px;
        line-height: inherit;
        color: #212121;
        border: 0;
        border-bottom: 1px solid #e5e5e5;
    }

    .text-primary {
        color: #2196f3;
        font-size: 14px;
    }
</style>
<style>
    .saveBt {
        margin-right: 10px;
    }
</style>

<fieldset>
    <legend class="text-primary"><%=PageName %></legend>
</fieldset>
<table>
    <tr>
        <td>

            <asp:SqlDataSource ID="SqlDataSource_Insurer" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                SelectCommand="select * 
                ,case when BranchCode='HO' then N'สำนักงานใหญ่'
                else N'สาขาย่อย'
                 end  as BranchName
                from tblInsurer Order By InsurerName"></asp:SqlDataSource>



            <dx:ASPxComboBox ID="InsurerFilter" ClientInstanceName="InsurerFilter"
                runat="server" Caption="วางบิลบริษัทประกันภัย"
                DataSourceID="SqlDataSource_Insurer"
                ValueType="System.String"
                ValueField="InsurerCode"
                TextFormatString="{1}"
                Width="250px"
                DropDownStyle="DropDown">

                <Columns>
                    <dx:ListBoxColumn FieldName="InsurerCode" Caption="รหัส" Width="50" />
                    <dx:ListBoxColumn FieldName="InsurerName" Caption="บริษัทประกันภัย" Width="250" />
                </Columns>

            </dx:ASPxComboBox>
        </td>
        <td>&nbsp;
        </td>
        <td>
            <dx:BootstrapDateEdit runat="server" ID="UWBillingDate" Caption="วันที่วางบิล" ClientInstanceName="UWBillingDate"></dx:BootstrapDateEdit>


        </td>
        <td>&nbsp;
        </td>
        <td>

            <dx:ASPxButton ID="AddUWBilling" AutoPostBack="false"
                runat="server" Border-BorderWidth="0" CausesValidation="false"
                Image-IconID="actions_download_16x16office2013"
                Text="Add">
                <ClientSideEvents Click="function(s,e){
                                                    var code = InsurerFilter.GetValue();
                                                    var billingdate = UWBillingDate.GetValue();
                                                    if(code==null || billingdate==null)
                                                    {
                                                        alert('กรุณาเลือก บริษัทประกันภัย และวันที่วางบิล');
                                                        e.processOnServer = false;
                                                    }
                                                    else
                                                    {
                                                        e.processOnServer = true;
                                                    }
                                                
                                                }" />

            </dx:ASPxButton>

        </td>
    </tr>
</table>
<br />


<dx:BootstrapGridView ID="taskGrid" runat="server"
    ClientInstanceName="taskGrid"
    AutoGenerateColumns="False" CssClasses-HeaderRow="removeWrapping" CssClasses-Row="removeWrapping"
    KeyFieldName="ID" SettingsBehavior-ConfirmDelete="true"
    SettingsBehavior-AllowDragDrop="true"
    SettingsPopup-EditForm-AllowResize="true"
    DataSourceID="SqlDataSource_UWBillingRegister"
    Width="100%"
    PopupAnimationType="Fade" CloseOnEscape="true" CloseAction="None">

    <SettingsEditing Mode="PopupEditForm" EditFormColumnSpan="12">
        <FormLayoutProperties LayoutType="Horizontal"></FormLayoutProperties>
    </SettingsEditing>
    <SettingsBehavior AllowFocusedRow="true" />
    <SettingsDataSecurity AllowEdit="true" AllowInsert="true" AllowDelete="true" />
    <SettingsPager AlwaysShowPager="true" ShowEmptyDataRows="false" PageSize="5">
        <PageSizeItemSettings Visible="true" Items="5,8,12,20" />
    </SettingsPager>
    <SettingsCustomizationDialog Enabled="true" />
    <SettingsCommandButton>
        <EditButton CssClass="edit-btn" RenderMode="Button" Text=" " />
        <UpdateButton RenderMode="Button" Text="Save" CssClass="saveBt" />
        <CancelButton RenderMode="Button" />
    </SettingsCommandButton>

    <SettingsAdaptivity AdaptivityMode="HideDataCells" AllowOnlyOneAdaptiveDetailExpanded="true" />

    <SettingsBootstrap Sizing="Large" />


    <CssClasses Control="tasks-grid" PreviewRow="text-muted" />
    <ClientSideEvents ToolbarItemClick="function(s,e){
                switch (e.item.name) {
                case 'ExportToXLSX':
                case 'ExportToXLS':
                    e.processOnServer = true;
                    e.usePostBack = true;
                    break;
            }
        }" />




    <Toolbars>
        <dx:BootstrapGridViewToolbar>
            <Items>
                <dx:BootstrapGridViewToolbarItem Command="Delete" BeginGroup="true" />
                <dx:BootstrapGridViewToolbarItem Command="Refresh" BeginGroup="true" />
                <dx:BootstrapGridViewToolbarItem Command="ClearSorting" BeginGroup="true" />
                <dx:BootstrapGridViewToolbarItem Command="ShowSearchPanel" BeginGroup="true" />
                <dx:BootstrapGridViewToolbarItem Command="Custom" Text="Export To" BeginGroup="true">
                    <Items>
                        <dx:BootstrapGridViewToolbarMenuItem Name="ExportToXLSX" Text="XLSX" />
                        <dx:BootstrapGridViewToolbarMenuItem Name="ExportToXLS" Text="XLS" />
                    </Items>
                </dx:BootstrapGridViewToolbarItem>
                <dx:BootstrapGridViewToolbarItem Command="ShowCustomizationDialog" BeginGroup="true">
                </dx:BootstrapGridViewToolbarItem>
            </Items>
        </dx:BootstrapGridViewToolbar>
    </Toolbars>
    <Columns>
        <dx:BootstrapGridViewDataColumn Width="100">
            <DataItemTemplate>
                <dx:BootstrapButton runat="server" ID="EditButton" Text="เพิ่มรายการ" Width="100" AutoPostBack="false" CssClasses-Icon="image fa fa-plus-square-o" UseSubmitBehavior="False">
                    <ClientSideEvents Click="function(s,e){
                                //TaskEditPopup.PerformCallback('edit|' + s.cpID);
                                //TaskEditPopup.Show();


                                 clientView.SetContentUrl('applications/UWBillingRegister.aspx?ID=' + s.cpID);
                                 clientView.Show();      
                            }" />
                    <SettingsBootstrap RenderOption="Link" />
                </dx:BootstrapButton>
            </DataItemTemplate>
        </dx:BootstrapGridViewDataColumn>

        <dx:BootstrapGridViewTextColumn FieldName="InsurerName" Caption="บริษัทประกันภัย" Width="200" ReadOnly="true" />


        <dx:BootstrapGridViewDateColumn FieldName="BillingDate" Caption="วันที่วางบิล" Width="100" PropertiesDateEdit-ValidationSettings-RequiredField-IsRequired="true" PropertiesDateEdit-DisplayFormatString="dd/MM/yyyy" />


        <dx:BootstrapGridViewSpinEditColumn FieldName="BRCommAmt" Width="100" AdaptivePriority="2" Caption="ค่าคอม" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>
        <dx:BootstrapGridViewSpinEditColumn FieldName="VAT7Amt" Width="100" AdaptivePriority="2" Caption="Vat(7%)" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>
        <dx:BootstrapGridViewSpinEditColumn FieldName="TAX3Amt" Width="100" AdaptivePriority="2" Caption="Tax(3%)" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>
        <dx:BootstrapGridViewSpinEditColumn FieldName="ServiceFreeAmt" Width="100" AdaptivePriority="2" Caption="ค่าจัดการ" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>
        <dx:BootstrapGridViewSpinEditColumn FieldName="ServiceFreeVAT7Amt" Width="100" AdaptivePriority="2" Caption="Vat 7%" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>
        <dx:BootstrapGridViewSpinEditColumn FieldName="ServiceFreeTAX3Amt" Width="100" AdaptivePriority="2" Caption="Tax 3%" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>

        <dx:BootstrapGridViewSpinEditColumn FieldName="TotalPremium" Width="100" AdaptivePriority="2" Caption="จ่ายสุทธิ" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>




        <dx:BootstrapGridViewDateColumn FieldName="CreateDate" Caption="วันที่่บันทึก" Visible="false"
            PropertiesDateEdit-DisplayFormatString="dd/MM/yyyy HH:mm:ss" SettingsEditForm-Visible="False" />
        <dx:BootstrapGridViewTextColumn FieldName="CreateBy" Caption="ผู้บันทึก" Visible="false">
            <SettingsEditForm Visible="False" />
        </dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="ModifyDate" Caption="วันที่แก้ไข" Visible="false">
            <SettingsEditForm Visible="False" />
        </dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="ModifyBy" Caption="ผู้แก้ไข" Visible="false">
            <SettingsEditForm Visible="False" />
        </dx:BootstrapGridViewTextColumn>
    </Columns>


</dx:BootstrapGridView>

<asp:SqlDataSource ID="SqlDataSource_UWBillingRegister" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
    SelectCommand="select * from v_UWBillingRegister Order By CreateDate desc"
    DeleteCommand="delete from tblUWBillingRegister where ID=@ID;
    delete from tblUWBillingPremium where UWBillingID=@ID;
    delete from tblUWBillingPolicy where UWBillingID=@ID;">

    <DeleteParameters>
        <asp:Parameter Name="ID" />
    </DeleteParameters>


</asp:SqlDataSource>



<dx:ASPxPopupControl ID="clientView" runat="server" ClientInstanceName="clientView"
    Modal="True" Maximized="true"
    PopupHorizontalAlign="WindowCenter"
    PopupVerticalAlign="WindowCenter"
    HeaderText="วางบิลบริษัทประกันภัย"
    AllowDragging="true"
    AllowResize="True"
    DragElement="Window"
    EnableAnimation="true"
    CloseAction="CloseButton"
    EnableCallbackAnimation="true"
    EnableViewState="true"
    ShowPageScrollbarWhenModal="true"
    ScrollBars="Auto"
    ShowMaximizeButton="true"
    HeaderImage-IconID="businessobjects_botask_32x32"
    HeaderStyle-BackColor="WindowFrame"
    Width="800"
    Height="680"
    FooterText=""
    ShowFooter="false">
    <HeaderStyle BackColor="#4796CE" ForeColor="White" />
    <ContentStyle>
        <Paddings Padding="0px" />
    </ContentStyle>
    <ClientSideEvents Closing="function(s,e){
        taskGrid.Refresh();
        }" />


    <ContentCollection>
        <dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server">
        </dx:PopupControlContentControl>
    </ContentCollection>
</dx:ASPxPopupControl>







 

