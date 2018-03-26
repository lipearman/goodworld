<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ucClaimRegister.ascx.vb" Inherits="Modules_ucClaimRegister" %>
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



<fieldset>
    <legend class="text-primary"><%=PageName %></legend>
</fieldset>
<dx:BootstrapGridView ID="TaskGrid" runat="server"
    ClientInstanceName="taskGrid"
    AutoGenerateColumns="False"
    KeyFieldName="ID" SettingsBehavior-ConfirmDelete="true"
    SettingsBehavior-AllowDragDrop="true"
    SettingsPopup-EditForm-AllowResize="true"
    DataSourceID="SqlDataSource_ClaimRegister"
    Width="100%" CssClasses-HeaderRow="removeWrapping" CssClasses-Row="removeWrapping"
    PopupAnimationType="Fade" CloseOnEscape="true" CloseAction="None">
    <CssClasses Control="tasks-grid" PreviewRow="text-muted" />
    <ClientSideEvents ToolbarItemClick="function(s,e){
                switch (e.item.name) {

                case 'ExportToXLSX':
                case 'ExportToXLS':
                    e.processOnServer = true;
                    e.usePostBack = true;
                    break;


                case 'NewClaim':
                    TaskNewPopup.Show();
                    ASPxClientEdit.ClearEditorsInContainerById('newClaimForm');
                    e.processOnServer = false;
                    break;
            }
        }" />

    <Toolbars>
        <dx:BootstrapGridViewToolbar>
            <Items>

                <dx:BootstrapGridViewToolbarItem Command="Custom" Name="NewClaim" Text="New" IconCssClass="image fa fa-plus">
                </dx:BootstrapGridViewToolbarItem>


                <%--          <dx:BootstrapGridViewToolbarItem Command="New" />
                <dx:BootstrapGridViewToolbarItem Command="Edit" />--%>


                <dx:BootstrapGridViewToolbarItem Command="Refresh" BeginGroup="true" />
                <dx:BootstrapGridViewToolbarItem Command="ClearSorting" />
                <dx:BootstrapGridViewToolbarItem Command="ShowSearchPanel" />

                <dx:BootstrapGridViewToolbarItem Command="Custom" Text="Export To">
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
        <dx:BootstrapGridViewDataColumn>
            <DataItemTemplate>
                <dx:BootstrapButton runat="server" ID="EditButton" Text=" " AutoPostBack="false" CssClasses-Icon="image fa fa-pencil" UseSubmitBehavior="False">
                    <ClientSideEvents Click="function(s,e){
                                TaskEditPopup.PerformCallback('edit|' + s.cpID);
                                 TaskEditPopup.Show();
                            }" />
                    <SettingsBootstrap RenderOption="Link" />
                </dx:BootstrapButton>
            </DataItemTemplate>

        </dx:BootstrapGridViewDataColumn>
        <dx:BootstrapGridViewTextColumn FieldName="ID" Visible="false">
        </dx:BootstrapGridViewTextColumn>


        <dx:BootstrapGridViewDateColumn FieldName="CreateDate" SortOrder="Descending" Caption="วันที่ทำรายการ" PropertiesDateEdit-DisplayFormatString="dd/MM/yyyy HH:mm:ss" SettingsEditForm-Visible="False" />
        <dx:BootstrapGridViewTextColumn FieldName="ClaimNo" Caption="เลขที่เคลม" Settings-AllowFilterBySearchPanel="True"></dx:BootstrapGridViewTextColumn>

        <dx:BootstrapGridViewTextColumn FieldName="PolicyNo" Caption="เลขที่ กธ." Settings-AllowFilterBySearchPanel="True"></dx:BootstrapGridViewTextColumn>

        <%--  <dx:BootstrapGridViewComboBoxColumn FieldName="PolicyId" Caption="เลขที่ กธ." Settings-AllowFilterBySearchPanel="True">
            <PropertiesComboBox DataSourceID="SqlDataSource_PolicyRegister" ValueField="ID"
                IncrementalFilteringMode="StartsWith"
                EnableCallbackMode="true" DropDownStyle="DropDown"
                CallbackPageSize="10">
                <Fields>
                    <dx:BootstrapListBoxField FieldName="PolicyNo" />
                    <dx:BootstrapListBoxField FieldName="CarLicensePlate" />
                    <dx:BootstrapListBoxField FieldName="FirstName" />
                    <dx:BootstrapListBoxField FieldName="LastName" />
                    <dx:BootstrapListBoxField FieldName="EffectiveDate" />
                    <dx:BootstrapListBoxField FieldName="ExpiredDate" />
                    <dx:BootstrapListBoxField FieldName="GrossPremium" />
                </Fields>
            </PropertiesComboBox>

        </dx:BootstrapGridViewComboBoxColumn>--%>


        <dx:BootstrapGridViewTextColumn FieldName="FirstName" Caption="ชื่อ" Settings-AllowFilterBySearchPanel="True"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="LastName" Caption="นามสกุล" Settings-AllowFilterBySearchPanel="True"></dx:BootstrapGridViewTextColumn>

        <dx:BootstrapGridViewTextColumn FieldName="CarLicensePlate" Caption="ทะเบียนรถ" Settings-AllowFilterBySearchPanel="True"></dx:BootstrapGridViewTextColumn>

        <dx:BootstrapGridViewDateColumn FieldName="AccidentDate" Caption="วันที่เกิดเหตุ"></dx:BootstrapGridViewDateColumn>
        <dx:BootstrapGridViewTextColumn FieldName="AccisentPlace" Caption="สถานที่เกิดเหตุ"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="AccidentType" Caption="ลักษณะการเกิดเหตุ"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewCheckColumn FieldName="IsRight" Caption="ถูก/ผิด"></dx:BootstrapGridViewCheckColumn>
        <dx:BootstrapGridViewSpinEditColumn FieldName="ClaimAmount" Caption="ค่าสินไหมจ่าย" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>


        <dx:BootstrapGridViewDateColumn FieldName="EffectiveDate" Visible="false" PropertiesDateEdit-DisplayFormatString="dd/MM/yyyy" AdaptivePriority="2" SettingsEditForm-Visible="False" />
        <dx:BootstrapGridViewDateColumn FieldName="ExpiredDate" Visible="false" PropertiesDateEdit-DisplayFormatString="dd/MM/yyyy" AdaptivePriority="2" SettingsEditForm-Visible="False" />
        <dx:BootstrapGridViewSpinEditColumn FieldName="GrossPremium" Visible="false" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>


        <dx:BootstrapGridViewTextColumn FieldName="CreateBy" Visible="false" Caption="เจ้าหน้าที่บันทึก"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="ModifyDate" Visible="false" Caption="วันที่แก้ไข"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="ModifyBy" Visible="false" Caption="เจ้าหน้าที่แก้ไข"></dx:BootstrapGridViewTextColumn>



    </Columns>
    <SettingsEditing Mode="PopupEditForm" EditFormColumnSpan="12">
        <FormLayoutProperties LayoutType="Horizontal"></FormLayoutProperties>
    </SettingsEditing>
    <SettingsBehavior AllowFocusedRow="true" />
    <SettingsDataSecurity AllowEdit="true" AllowInsert="true" AllowDelete="false" />
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

</dx:BootstrapGridView>

<asp:SqlDataSource ID="SqlDataSource_ClaimRegister" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
    SelectCommand="select * from tblClaimRegister Order By CreateDate"></asp:SqlDataSource>


<asp:SqlDataSource ID="SqlDataSource_PolicyRegister" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
    SelectCommand="select * from tblPolicyRegister Order By CreateDate"></asp:SqlDataSource>





<dx:BootstrapPopupControl ID="TaskNewPopup" ClientInstanceName="TaskNewPopup" runat="server"
    ShowHeader="true" CloseOnEscape="false" CloseAction="CloseButton" HeaderText="สินไหม"
    PopupAnimationType="Fade">
    <SettingsAdaptivity Mode="Always" FixedHeader="true" VerticalAlign="WindowTop" />
    <SettingsBootstrap Sizing="Normal" />
    <CssClasses Header="text-primary" />

    <ClientSideEvents
        BeginCallback="function(s,e){LoadingPanel.Show();}"
        CallbackError="function(s,e){
            LoadingPanel.Hide();
            alert(e.result);
        }"
        EndCallback="function(s,e){
            LoadingPanel.Hide();
            if(s.cpnewtask=='savenew' )
            {
                TaskNewPopup.Hide();
                taskGrid.Refresh();
            }
            else
            {
                alert(s.cpnewtask);
            }
        }" />


    <ContentCollection>
        <dx:ContentControl ID="ContentControl1" runat="server">
            <fieldset>
                <legend class="text-primary"><i class="fa fa-lg fa-arrow-right">กรมธรรม์/สินไหม</i></legend>
            </fieldset>


            <dx:BootstrapFormLayout ID="BootstrapFormLayout1" runat="server" LayoutType="Horizontal">
                <CssClasses Control="overview-fl" />
                <Items>
                    <dx:BootstrapLayoutItem Caption="กรมธรรม์" ColSpanMd="12">
                        <ContentCollection>
                            <dx:ContentControl ID="ContentControl2" runat="server">
                                <dx:ASPxComboBox ID="newPolicyId" runat="server"
                                    DropDownStyle="DropDownList"
                                    DataSourceID="SqlDataSource_PolicyRegister"
                                    ValueField="ID"
                                    ValueType="System.String" TextFormatString="{0}"
                                    EnableCallbackMode="true"
                                    IncrementalFilteringMode="StartsWith"
                                    CallbackPageSize="30">
                                    <Columns>
                                        <dx:ListBoxColumn FieldName="PolicyNo" />
                                        <dx:ListBoxColumn FieldName="CarLicensePlate" />
                                        <dx:ListBoxColumn FieldName="FirstName" />
                                        <dx:ListBoxColumn FieldName="LastName" />
                                        <dx:ListBoxColumn FieldName="EffectiveDate" />
                                        <dx:ListBoxColumn FieldName="ExpiredDate" />
                                        <dx:ListBoxColumn FieldName="GrossPremium" />
                                    </Columns>
                                </dx:ASPxComboBox>

                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>


                    <dx:BootstrapLayoutItem Caption="เลขที่เคลม" ColSpanMd="12" BeginRow="true">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="newClaimNo" NullText="พิมพ์เลขที่เคลม..."></dx:BootstrapTextBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>

                    <dx:BootstrapLayoutItem Caption="วันที่เกิดเหตุ" ColSpanMd="12">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapDateEdit ID="newAccidentDate" runat="server" NullText="เลือกวันที่เกิดเหตุ..." EditFormatString="dd/MM/yyyy">
                                </dx:BootstrapDateEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>

                    <dx:BootstrapLayoutItem Caption="สถานที่เกิดเหตุ" ColSpanMd="12" BeginRow="true">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="newAccisentPlace" NullText="พิมพ์สถานที่เกิดเหตุ..."></dx:BootstrapTextBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>

                    <dx:BootstrapLayoutItem Caption="ลักษณะการเกิดเหตุ" ColSpanMd="12" BeginRow="true">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="newAccidentType" NullText="พิมพ์ลักษณะการเกิดเหตุ..."></dx:BootstrapTextBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>

                    <dx:BootstrapLayoutItem Caption="ถูก/ผิด" ColSpanMd="12" BeginRow="true">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapCheckBox runat="server" ID="newIsRight" NullText="เลือกถูก/ผิด..."></dx:BootstrapCheckBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>

                    <dx:BootstrapLayoutItem Caption="ค่าสินไหมจ่าย" ColSpanMd="12">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapSpinEdit ID="newClaimAmount" runat="server" DisplayFormatString="N2" AllowMouseWheel="false" NullText="0.00"
                                    SpinButtons-Enabled="false" SpinButtons-ClientVisible="false" Number="0.00">
                                </dx:BootstrapSpinEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>


                    <dx:BootstrapLayoutItem ShowCaption="False" ColSpanMd="12" HorizontalAlign="Left">
                        <ContentCollection>
                            <dx:ContentControl ID="ContentControl11" runat="server">
                                <dx:BootstrapButton ID="TaskSaveButton" runat="server" AutoPostBack="false" Text="Save" Width="100px">
                                    <ClientSideEvents Click="function(s,e){

                                         if(ASPxClientEdit.ValidateEditorsInContainer(TaskNewPopup.GetMainElement()))
                                         {
                                          TaskNewPopup.PerformCallback('savenew');
                                         }


                                        }" />
                                    <SettingsBootstrap RenderOption="Primary" />
                                </dx:BootstrapButton>
                                <dx:BootstrapButton ID="TaskCancelButton" runat="server" AutoPostBack="False" CausesValidation="false" UseSubmitBehavior="False" Text="Cancel" Width="100px">
                                    <ClientSideEvents Click="function(s,e){
                                          TaskNewPopup.Hide();
                                        }" />
                                </dx:BootstrapButton>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                </Items>
            </dx:BootstrapFormLayout>

        </dx:ContentControl>
    </ContentCollection>
</dx:BootstrapPopupControl>



<dx:BootstrapPopupControl ID="TaskEditPopup" ClientInstanceName="TaskEditPopup" runat="server"
    ShowHeader="true" CloseOnEscape="false" CloseAction="CloseButton" HeaderText="สินไหม"
    PopupAnimationType="Fade">
    <SettingsAdaptivity Mode="Always" FixedHeader="true" VerticalAlign="WindowTop" />
    <SettingsBootstrap Sizing="Normal" />
    <CssClasses Header="text-primary" />
    <ClientSideEvents
        BeginCallback="function(s,e){
            LoadingPanel.Show();
        }"
        CallbackError="function(s,e){
            LoadingPanel.Hide();
            alert(e.result);
        }"
        EndCallback="function(s,e){

            LoadingPanel.Hide();

            if(s.cpedittask=='saveedit' )
            {
     
                TaskEditPopup.Hide();
                taskGrid.Refresh();
            }
            else if(s.cpedittask=='edit' )
            {
               
                ASPxClientEdit.ValidateEditorsInContainer(TaskEditPopup.GetMainElement());
            }
            else
            {
                alert(s.cpedittask);
            }

        }" />


    <ContentCollection>
        <dx:ContentControl ID="ContentControl7" runat="server">
            <dx:ASPxHiddenField runat="server" ID="hdID"></dx:ASPxHiddenField>
             <fieldset>
                <legend class="text-primary"><i class="fa fa-lg fa-arrow-right">กรมธรรม์/สินไหม</i></legend>
            </fieldset>


            <dx:BootstrapFormLayout ID="BootstrapFormEdit1" runat="server" LayoutType="Horizontal">
                <CssClasses Control="overview-fl" />
                <Items>


                    <dx:BootstrapLayoutItem Caption="สินไหม" FieldName="PolicyId" ColSpanMd="12">
                        <ContentCollection>
                            <dx:ContentControl ID="ContentControl3" runat="server">
                                <dx:ASPxComboBox ID="editPolicyId" runat="server"
                                    DropDownStyle="DropDownList"
                                    DataSourceID="SqlDataSource_PolicyRegister"
                                    ValueField="ID"
                                    ValueType="System.String" TextFormatString="{0}"
                                    EnableCallbackMode="true"
                                    IncrementalFilteringMode="StartsWith"
                                    CallbackPageSize="30">
                                    <Columns>
                                        <dx:ListBoxColumn FieldName="PolicyNo" />
                                        <dx:ListBoxColumn FieldName="CarLicensePlate" />
                                        <dx:ListBoxColumn FieldName="FirstName" />
                                        <dx:ListBoxColumn FieldName="LastName" />
                                        <dx:ListBoxColumn FieldName="EffectiveDate" />
                                        <dx:ListBoxColumn FieldName="ExpiredDate" />
                                        <dx:ListBoxColumn FieldName="GrossPremium" />
                                    </Columns>
                                </dx:ASPxComboBox>

                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>


                    <dx:BootstrapLayoutItem Caption="เลขที่เคลม" ColSpanMd="12" FieldName="ClaimNo">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="editClaimNo" NullText="พิมพ์เลขที่เคลม..."></dx:BootstrapTextBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>

                    <dx:BootstrapLayoutItem Caption="วันที่เกิดเหตุ" ColSpanMd="12" FieldName="AccidentDate" >
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapDateEdit ID="editAccidentDate" runat="server" NullText="เลือกวันที่เกิดเหตุ..." EditFormatString="dd/MM/yyyy">
                                </dx:BootstrapDateEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>

                    <dx:BootstrapLayoutItem Caption="สถานที่เกิดเหตุ" ColSpanMd="12" FieldName="AccisentPlace">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="editAccisentPlace" NullText="พิมพ์สถานที่เกิดเหตุ..."></dx:BootstrapTextBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>

                    <dx:BootstrapLayoutItem Caption="ลักษณะการเกิดเหตุ" ColSpanMd="12" FieldName="AccidentType">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="editAccidentType" NullText="พิมพ์ลักษณะการเกิดเหตุ..."></dx:BootstrapTextBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>

                    <dx:BootstrapLayoutItem Caption="ถูก/ผิด" ColSpanMd="12"  FieldName="IsRight">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapCheckBox runat="server" ID="editIsRight" NullText="เลือกถูก/ผิด..."></dx:BootstrapCheckBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>

                    <dx:BootstrapLayoutItem Caption="ค่าสินไหมจ่าย" ColSpanMd="12" FieldName="ClaimAmount">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapSpinEdit ID="editClaimAmount" runat="server" DisplayFormatString="N2" AllowMouseWheel="false" NullText="0.00"
                                    SpinButtons-Enabled="false" SpinButtons-ClientVisible="false" Number="0.00">
                                </dx:BootstrapSpinEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>


                </Items>
            </dx:BootstrapFormLayout>

            <fieldset>
                <legend class="text-primary"><i class="fa fa-lg fa-arrow-right">ส่วนเจ้าหน้าที่ </i></legend>
            </fieldset>
            <dx:BootstrapFormLayout ID="BootstrapFormEdit6" runat="server" LayoutType="Horizontal">
                <CssClasses Control="overview-fl" />
                <Items>

                    <dx:BootstrapLayoutItem Caption="ผู้บันทึก" ColSpanMd="12">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="editCreateBy" ClientEnabled="false"></dx:BootstrapTextBox>

                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>

                    <dx:BootstrapLayoutItem Caption="ผู้แก้ไข" ColSpanMd="12">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="editModifyBy" ClientEnabled="false"></dx:BootstrapTextBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>


                    <dx:BootstrapLayoutItem ShowCaption="False" ColSpanMd="12" HorizontalAlign="Left">
                        <ContentCollection>
                            <dx:ContentControl ID="ContentControl18" runat="server">
                                <dx:BootstrapButton ID="BootstrapButton1" runat="server" AutoPostBack="false" Text="Save" Width="100px">
                                    <ClientSideEvents Click="function(s,e){
                                            if(ASPxClientEdit.ValidateEditorsInContainer(TaskEditPopup.GetMainElement()))
                                            {
                                                TaskEditPopup.PerformCallback('saveedit');
                                            }
                                        }" />
                                    <SettingsBootstrap RenderOption="Primary" />
                                </dx:BootstrapButton>
                                <dx:BootstrapButton ID="BootstrapButton2" runat="server" AutoPostBack="False" CausesValidation="false" UseSubmitBehavior="False" Text="Cancel" Width="100px">
                                    <ClientSideEvents Click="function(s,e){
                                        TaskEditPopup.Hide();
                                        }" />
                                </dx:BootstrapButton>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>



                </Items>
            </dx:BootstrapFormLayout>


        </dx:ContentControl>
    </ContentCollection>
</dx:BootstrapPopupControl>
