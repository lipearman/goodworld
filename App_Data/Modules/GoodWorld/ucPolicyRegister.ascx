<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ucPolicyRegister.ascx.vb" Inherits="Modules_ucPolicyRegister" %>

<style>
    .saveBt {
        margin-right: 10px;
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
    DataSourceID="SqlDataSource_PolicyRegister"
    Width="100%"
    PopupAnimationType="Fade" CloseOnEscape="true" CloseAction="None">
    <CssClasses Control="tasks-grid" PreviewRow="text-muted" />
    <ClientSideEvents ToolbarItemClick="function(s,e){
                switch (e.item.name) {
                case 'NewPolicy':
                    TaskNewPopup.Show();
                    //TaskNewPopup.PerformCallback();
                    ASPxClientEdit.ClearEditorsInContainerById('newPolicyForm');
                    break;
            }
            //e.usePostBack = false;
            e.processOnServer = false;
        }" />
    <Toolbars>
        <dx:BootstrapGridViewToolbar>
            <Items>

                <dx:BootstrapGridViewToolbarItem Command="Custom" Name="NewPolicy" Text="New" IconCssClass="image fa fa-plus">
                </dx:BootstrapGridViewToolbarItem>


                <%--    <dx:BootstrapGridViewToolbarItem Command="New" />
                <dx:BootstrapGridViewToolbarItem Command="Edit" />
                --%>

                <dx:BootstrapGridViewToolbarItem Command="Refresh" BeginGroup="true" />
                <dx:BootstrapGridViewToolbarItem Command="ClearSorting" />
                <dx:BootstrapGridViewToolbarItem Command="ShowSearchPanel" />


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
        <dx:BootstrapGridViewTextColumn FieldName="ID" Visible="false"></dx:BootstrapGridViewTextColumn>


        <dx:BootstrapGridViewDateColumn FieldName="CreateDate" PropertiesDateEdit-DisplayFormatString="dd/MM/yyyy HH:mm:ss" AdaptivePriority="2" SettingsEditForm-Visible="False" />
        <dx:BootstrapGridViewTextColumn FieldName="FirstName" Settings-AllowFilterBySearchPanel="True"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="LastName" Settings-AllowFilterBySearchPanel="True"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="PolicyNo" Settings-AllowFilterBySearchPanel="True"></dx:BootstrapGridViewTextColumn>

        <dx:BootstrapGridViewComboBoxColumn FieldName="InsureType" Caption="ประเภทการประกันภัย">
            <PropertiesComboBox DataSourceID="SqlDataSource_InsureType" TextField="Name" ValueField="ID">
                <ValidationSettings>
                    <RequiredField IsRequired="true" />
                </ValidationSettings>
            </PropertiesComboBox>
        </dx:BootstrapGridViewComboBoxColumn>

        <dx:BootstrapGridViewComboBoxColumn FieldName="InsurerCode" Caption="บริษัทประกันภัย">
            <PropertiesComboBox DataSourceID="SqlDataSource_Insurer" TextField="InsurerName" ValueField="InsurerCode">
                <ValidationSettings>
                    <RequiredField IsRequired="true" />
                </ValidationSettings>
            </PropertiesComboBox>
        </dx:BootstrapGridViewComboBoxColumn>

        <dx:BootstrapGridViewDateColumn FieldName="EffectiveDate" Width="100" PropertiesDateEdit-DisplayFormatString="dd/MM/yyyy" AdaptivePriority="2" SettingsEditForm-Visible="False" />
        <dx:BootstrapGridViewDateColumn FieldName="ExpiredDate" Width="100" PropertiesDateEdit-DisplayFormatString="dd/MM/yyyy" AdaptivePriority="2" SettingsEditForm-Visible="False" />


        <dx:BootstrapGridViewSpinEditColumn FieldName="GrossPremium" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>



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

<asp:SqlDataSource ID="SqlDataSource_PolicyRegister" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
    SelectCommand="select * from tblPolicyRegister Order By CreateDate"></asp:SqlDataSource>

<asp:SqlDataSource ID="SqlDataSource_Insurer" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
    SelectCommand="select InsurerCode,  InsurerName + ' (' + InsurerCode + ')' as InsurerName  from tblInsurer "></asp:SqlDataSource>

<asp:SqlDataSource ID="SqlDataSource_InsureType" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
    SelectCommand="select ID, Name from tblInsureType Order by OrderNo "></asp:SqlDataSource>


<asp:SqlDataSource ID="SqlDataSource_SubBroker" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
    SelectCommand="select AgentCode,  AgentName + ' (' + AgentCode + ')' as AgentName  from tblSubBroker "></asp:SqlDataSource>

<dx:BootstrapPopupControl ID="TaskNewPopup" ClientInstanceName="TaskNewPopup" runat="server"
    ShowHeader="true" CloseOnEscape="false" CloseAction="CloseButton" HeaderText="ลงทะเบียนกรมธรรม์"
    PopupAnimationType="Fade">
    <SettingsAdaptivity Mode="Always" FixedHeader="true" VerticalAlign="WindowTop" />
    <SettingsBootstrap Sizing="Large" />

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
                //taskGrid.PerformCallback();
                taskGrid.Refresh();
            }
            else if(s.cpnewtask=='calbrokerage' )
            {

            }
            else
            {
                alert(s.cpnewtask);
            }
        }" />


    <ContentCollection>
        <dx:ContentControl ID="ContentControl1" runat="server">
            <%--            <fieldset>
                <legend class="text-primary">บริษัท</legend>
            </fieldset>--%>
            <dx:BootstrapFormLayout ID="BootstrapFormLayout1" runat="server" LayoutType="Horizontal">
                <Items>
                    <dx:BootstrapLayoutItem Caption="บริษัทประกันภัย" ColSpanMd="6">
                        <ContentCollection>
                            <dx:ContentControl ID="ContentControl12" runat="server">
                                <dx:BootstrapComboBox runat="server" ID="newInsurerCode"
                                    NullText="เลือกบริษัทประกันภัย..." DataSourceID="SqlDataSource_Insurer" TextField="InsurerName" ValueField="InsurerCode">
                                    <ValidationSettings RequiredField-IsRequired="true" ValidationGroup="newPolicyForm"></ValidationSettings>
                                    <ClientSideEvents SelectedIndexChanged="function(s,e){
                                        TaskNewPopup.PerformCallback('calbrokerage');
                                        }" />
                                </dx:BootstrapComboBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="ตัวแทน" ColSpanMd="6">
                        <ContentCollection>
                            <dx:ContentControl ID="ContentControl13" runat="server">
                                <dx:BootstrapComboBox runat="server" ID="newAgentCode" NullText="เลือกตัวแทน..." DataSourceID="SqlDataSource_SubBroker" TextField="AgentName" ValueField="AgentCode">
                                    <ValidationSettings RequiredField-IsRequired="true" ValidationGroup="newPolicyForm"></ValidationSettings>
                                    <ClientSideEvents SelectedIndexChanged="function(s,e){
                                        TaskNewPopup.PerformCallback('calbrokerage');
                                        }" />
                                </dx:BootstrapComboBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>

                </Items>
            </dx:BootstrapFormLayout>
            <fieldset>
                <legend class="text-primary">ผู้เอาประกัน</legend>
            </fieldset>
            <dx:BootstrapFormLayout ID="BootstrapFormLayout2" runat="server" LayoutType="Horizontal">
                <Items>
                    <dx:BootstrapLayoutItem Caption="ชื่อ" ColSpanMd="6">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="newFirstName" NullText="พิมพ์ชื่อ..." ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="newPolicyForm"></dx:BootstrapTextBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>

                    <dx:BootstrapLayoutItem Caption="นามสกุล" ColSpanMd="6">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="newLastName" NullText="พิมพ์นามสกุล..." ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="newPolicyForm"></dx:BootstrapTextBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>

                    <dx:BootstrapLayoutItem Caption="วันเดือนปีเกิด" ColSpanMd="6">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapDateEdit ID="newDOB" runat="server" NullText="เลือกวันเดือนปีเกิด..." EditFormatString="dd/MM/yyyy" ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="newPolicyForm">
                                </dx:BootstrapDateEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>

                    <dx:BootstrapLayoutItem Caption="บัตรประชาชน" ColSpanMd="6">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="newIdentityNo" NullText="พิมพ์บัตรประชาชน..." ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="newPolicyForm">
                                    <MaskSettings Mask="0-0000-00000-00-0" IncludeLiterals="None" />
                                </dx:BootstrapTextBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>


                    <dx:BootstrapLayoutItem Caption="ที่อยู่" ColSpanMd="6">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="newAddress1" NullText="พิมพ์ที่อยู่ 1..." ToolTip="ที่อยู่ 1" ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="newPolicyForm"></dx:BootstrapTextBox>
                                <dx:BootstrapTextBox runat="server" ID="newAddress2" NullText="พิมพ์ที่อยู่ 2..." ToolTip="ที่อยู่ 2" ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="newPolicyForm"></dx:BootstrapTextBox>


                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="โทรศัพท์/มือถือ" ColSpanMd="6">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" NullText="พิมพ์โทรศัพท์..." ToolTip="โทรศัพท์" ID="newTelNo" ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="newPolicyForm">
                                    <MaskSettings Mask="(000) 000-0000" IncludeLiterals="None" />
                                </dx:BootstrapTextBox>

                                <dx:BootstrapTextBox runat="server" NullText="พิมพ์มือถือ..." ToolTip="มือถือ" ID="newMobile" ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="newPolicyForm">
                                    <MaskSettings Mask="(000) 000-0000" IncludeLiterals="None" />
                                </dx:BootstrapTextBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                </Items>
            </dx:BootstrapFormLayout>
            <fieldset>
                <legend class="text-primary">รายละเอียดรถ</legend>
            </fieldset>
            <dx:BootstrapFormLayout ID="BootstrapFormLayout3" runat="server" LayoutType="Horizontal">
                <Items>

                    <dx:BootstrapLayoutItem Caption="ประเภทการประกันภัย" ColSpanMd="4">
                        <ContentCollection>
                            <dx:ContentControl ID="ContentControl2" runat="server">
                                <dx:BootstrapComboBox runat="server" ID="newInsureType" NullText="เลือกประเภทการประกันภัย..." DataSourceID="SqlDataSource_InsureType" TextField="Name" ValueField="ID">
                                    <ValidationSettings RequiredField-IsRequired="true" ValidationGroup="newPolicyForm"></ValidationSettings>
                                    <ClientSideEvents SelectedIndexChanged="function(s,e){
                                        TaskNewPopup.PerformCallback('calbrokerage');
                                        }" />
                                </dx:BootstrapComboBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="เบอร์กรมธรรม์" ColSpanMd="4">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="newPolicyNo" NullText="พิมพ์เบอร์กรมธรรม์..." ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="newPolicyForm"></dx:BootstrapTextBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="ใหม่/ต่ออายุ" ColSpanMd="4">
                        <ContentCollection>
                            <dx:ContentControl>
                                <%-- <dx:BootstrapRadioButtonList ID="BootstrapRadioButtonList1"
                                    ValidationSettings-RequiredField-IsRequired="true" RepeatDirection="Horizontal" RepeatColumns="2" runat="server">
                                    <Items>
                                        <dx:BootstrapListEditItem Text="ใหม่" Value="N" />
                                        <dx:BootstrapListEditItem Text="ต่ออายุ" Value="R" />
                                    </Items>
                                </dx:BootstrapRadioButtonList>--%>

                                <dx:BootstrapComboBox ID="newPolicyType" runat="server" NullText="เลือก..." ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="newPolicyForm">
                                    <Items>
                                        <dx:BootstrapListEditItem Text="ใหม่" Value="N" />
                                        <dx:BootstrapListEditItem Text="ต่ออายุ" Value="R" />
                                    </Items>
                                </dx:BootstrapComboBox>


                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>


                    <dx:BootstrapLayoutItem Caption="วันเริ่มคุ้มครอง" ColSpanMd="4">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapDateEdit ID="newEffectiveDate" runat="server" NullText="เลือกวันเริ่มคุ้มครอง..." EditFormatString="dd/MM/yyyy" ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="newPolicyForm">
                                </dx:BootstrapDateEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="วันสิ้นสุดคุ้มครอง" ColSpanMd="4">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapDateEdit ID="newExpiredDate" runat="server" NullText="เลือกวันสิ้นสุดคุ้มครอง..." EditFormatString="dd/MM/yyyy" ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="newPolicyForm">
                                </dx:BootstrapDateEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="ทุนประกัน" ColSpanMd="4">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapSpinEdit ID="newSuminsured" runat="server" DisplayFormatString="N0" AllowMouseWheel="false" NullText="พิมพ์ทุนประกัน..."
                                    SpinButtons-Enabled="false" SpinButtons-ClientVisible="false" ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="newPolicyForm">
                                </dx:BootstrapSpinEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>

                    <dx:BootstrapLayoutItem Caption="ทะเบียนรถ" ColSpanMd="4">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="newCarLicensePlate" NullText="พิมพ์ทะเบียนรถ..." ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="newPolicyForm"></dx:BootstrapTextBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="ปีจดทะเบียน" ColSpanMd="4">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="newCarRegYear" NullText="พิมพ์ปีจดทะเบียน..." ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="newPolicyForm"></dx:BootstrapTextBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>

                    <dx:BootstrapLayoutItem Caption="เบี้ยประกันภัย" ColSpanMd="4">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapSpinEdit ID="newPremium" runat="server" DisplayFormatString="N2" AllowMouseWheel="false" NullText="พิมพ์เบี้ยประกันภัย..."
                                    SpinButtons-Enabled="false" SpinButtons-ClientVisible="false" ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="newPolicyForm">
                                    <ClientSideEvents ValueChanged="function(s,e){
                                        TaskNewPopup.PerformCallback('calbrokerage');
                                        }" />

                                </dx:BootstrapSpinEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="อากร" ColSpanMd="4">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapSpinEdit ID="newStamp" ClientEnabled="false" runat="server" DisplayFormatString="N0" AllowMouseWheel="false" NullText="0"
                                    SpinButtons-Enabled="false" SpinButtons-ClientVisible="false">
                                </dx:BootstrapSpinEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="ภาษี" ColSpanMd="4">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapSpinEdit ID="newVat" ClientEnabled="false" runat="server" DisplayFormatString="N0" AllowMouseWheel="false" NullText="0.00"
                                    SpinButtons-Enabled="false" SpinButtons-ClientVisible="false">
                                </dx:BootstrapSpinEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>

                    <dx:BootstrapLayoutItem Caption="เบี้ยประกันภัยรวม" ColSpanMd="4">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapSpinEdit ID="newGrossPremium" ClientEnabled="false" runat="server" DisplayFormatString="N2" AllowMouseWheel="false" NullText="0.00"
                                    SpinButtons-Enabled="false" SpinButtons-ClientVisible="false">
                                </dx:BootstrapSpinEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>

                </Items>
            </dx:BootstrapFormLayout>
<nav>
  <div class="nav nav-tabs" id="nav-tab" role="tablist">
    <a class="nav-item nav-link active" id="nav-home-tab" data-toggle="tab" href="#nav-home" role="tab" aria-controls="nav-home" aria-selected="true">Home</a>
    <a class="nav-item nav-link" id="nav-profile-tab" data-toggle="tab" href="#nav-profile" role="tab" aria-controls="nav-profile" aria-selected="false">Profile</a>
    <a class="nav-item nav-link" id="nav-contact-tab" data-toggle="tab" href="#nav-contact" role="tab" aria-controls="nav-contact" aria-selected="false">Contact</a>
  </div>
</nav>
<div class="tab-content" id="nav-tabContent">
  <div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">...</div>
  <div class="tab-pane fade" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab">...</div>
  <div class="tab-pane fade" id="nav-contact" role="tabpanel" aria-labelledby="nav-contact-tab">...</div>
</div>
            <fieldset>
                <legend class="text-primary">ส่วนเจ้าหน้าที่</legend>
            </fieldset>
            <dx:BootstrapFormLayout ID="BootstrapFormLayout4" runat="server" LayoutType="Horizontal">
                <CssClasses Control="overview-fl" />
                <Items>
                    <dx:BootstrapLayoutItem Caption="ค่าคอม(ประกัน)" ColSpanMd="4">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapSpinEdit ID="newBRCommAmt" ClientEnabled="false" runat="server" DisplayFormatString="N2" AllowMouseWheel="false" NullText="0.00"
                                    SpinButtons-Enabled="false" SpinButtons-ClientVisible="false" ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="newPolicyForm">
                                </dx:BootstrapSpinEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="ค่าส่งเสริม" ColSpanMd="4">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapSpinEdit ID="newPRCommAmt" ClientEnabled="false" runat="server" DisplayFormatString="N2" AllowMouseWheel="false" NullText="0.00"
                                    SpinButtons-Enabled="false" SpinButtons-ClientVisible="false" ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="newPolicyForm">
                                </dx:BootstrapSpinEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="ค่านายหน้าจ่าย Sub" ColSpanMd="4">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapSpinEdit ID="newSubCommAmt" ClientEnabled="false" runat="server" DisplayFormatString="N2" AllowMouseWheel="false" NullText="0.00"
                                    SpinButtons-Enabled="false" SpinButtons-ClientVisible="false" ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="newPolicyForm">
                                </dx:BootstrapSpinEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>


                    <dx:BootstrapLayoutItem Caption="วันที่ส่งกรมธรรม์" ColSpanMd="4">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapDateEdit ID="newSentPolicyDate" runat="server" NullText="เลือกวันที่ส่งกรมธรรม์..." EditFormatString="dd/MM/yyyy">
                                </dx:BootstrapDateEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="วันที่ได้รับกรมธรรม์" ColSpanMd="4">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapDateEdit ID="newGetPolicyDate" runat="server" NullText="เลือกวันที่ได้รับกรมธรรม์..." EditFormatString="dd/MM/yyyy">
                                </dx:BootstrapDateEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="วันที่ Sub รับกรมธรรม์" ColSpanMd="4">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapDateEdit ID="newSubGetPolicyDate" runat="server" NullText="เลือก Sub รับกรมธรรม์..." EditFormatString="dd/MM/yyyy">
                                </dx:BootstrapDateEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>






                    <dx:BootstrapLayoutItem ShowCaption="False" ColSpanMd="12" HorizontalAlign="Left">
                        <ContentCollection>
                            <dx:ContentControl ID="ContentControl11" runat="server">
                                <dx:BootstrapButton ID="TaskSaveButton" runat="server" ValidationGroup="newPolicyForm" AutoPostBack="false" Text="Save" Width="100px">
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
    ShowHeader="true" CloseOnEscape="false" CloseAction="CloseButton" HeaderText="ลงทะเบียนกรมธรรม์"
    PopupAnimationType="Fade">
    <SettingsAdaptivity Mode="Always" FixedHeader="true" VerticalAlign="WindowTop" />
    <SettingsBootstrap Sizing="Large" />

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


            <dx:BootstrapFormLayout ID="BootstrapFormLayout5" runat="server" LayoutType="Horizontal">
                <CssClasses Control="overview-fl" />
                <Items>
                    <dx:BootstrapLayoutItem Caption="บริษัทประกันภัย" ColSpanMd="6" FieldName="InsurerCode">
                        <ContentCollection>
                            <dx:ContentControl ID="ContentControl8" runat="server">
                                <dx:BootstrapComboBox runat="server" ID="editInsurerCode" NullText="เลือกบริษัทประกันภัย..." DataSourceID="SqlDataSource_Insurer" TextField="InsurerName" ValueField="InsurerCode">
                                    <ValidationSettings RequiredField-IsRequired="true" ValidationGroup="editPolicyForm"></ValidationSettings>
                                    <ClientSideEvents SelectedIndexChanged="function(s,e){
                                        TaskEditPopup.PerformCallback('calbrokerage');
                                        }" />
                                </dx:BootstrapComboBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="ตัวแทน" ColSpanMd="6" FieldName="AgentCode">
                        <ContentCollection>
                            <dx:ContentControl ID="ContentControl9" runat="server">
                                <dx:BootstrapComboBox runat="server" ID="editAgentCode" NullText="เลือกตัวแทน..." DataSourceID="SqlDataSource_SubBroker" TextField="AgentName" ValueField="AgentCode">
                                    <ValidationSettings RequiredField-IsRequired="true" ValidationGroup="editPolicyForm"></ValidationSettings>
                                    <ClientSideEvents SelectedIndexChanged="function(s,e){
                                        TaskEditPopup.PerformCallback('calbrokerage');
                                        }" />
                                </dx:BootstrapComboBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                </Items>
            </dx:BootstrapFormLayout>
            <fieldset>
                <legend class="text-primary">ผู้เอาประกัน</legend>
            </fieldset>
            <dx:BootstrapFormLayout ID="BootstrapFormLayout6" runat="server" LayoutType="Horizontal">
                <CssClasses Control="overview-fl" />
                <Items>
                    <dx:BootstrapLayoutItem Caption="ชื่อ" ColSpanMd="6" FieldName="FirstName">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="editFirstName" NullText="พิมพ์ชื่อ..." ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="editPolicyForm"></dx:BootstrapTextBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>

                    <dx:BootstrapLayoutItem Caption="นามสกุล" ColSpanMd="6" FieldName="LastName">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="editLastName" NullText="พิมพ์นามสกุล..." ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="editPolicyForm"></dx:BootstrapTextBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>

                    <dx:BootstrapLayoutItem Caption="วันเดือนปีเกิด" ColSpanMd="6" FieldName="DOB">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapDateEdit ID="editDOB" runat="server" NullText="เลือกวันเดือนปีเกิด..." EditFormatString="dd/MM/yyyy" ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="editPolicyForm">
                                </dx:BootstrapDateEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>

                    <dx:BootstrapLayoutItem Caption="บัตรประชาชน" ColSpanMd="6" FieldName="IdentityNo">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="editIdentityNo" NullText="พิมพ์บัตรประชาชน..." ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="editPolicyForm">
                                    <MaskSettings Mask="0-0000-00000-00-0" IncludeLiterals="None" />
                                </dx:BootstrapTextBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>


                    <dx:BootstrapLayoutItem Caption="ที่อยู่" ColSpanMd="6">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="editAddress1" NullText="พิมพ์ที่อยู่ 1..." ToolTip="ที่อยู่ 1" ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="editPolicyForm"></dx:BootstrapTextBox>
                                <dx:BootstrapTextBox runat="server" ID="editAddress2" NullText="พิมพ์ที่อยู่ 2..." ToolTip="ที่อยู่ 2" ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="editPolicyForm"></dx:BootstrapTextBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="โทรศัพท์/มือถือ" ColSpanMd="6">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" NullText="พิมพ์โทรศัพท์..." ToolTip="โทรศัพท์" ID="editTelNo" ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="editPolicyForm">
                                    <MaskSettings Mask="(000) 000-0000" IncludeLiterals="None" />
                                </dx:BootstrapTextBox>

                                <dx:BootstrapTextBox runat="server" NullText="พิมพ์มือถือ..." ToolTip="มือถือ" ID="editMobile" ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="editPolicyForm">
                                    <MaskSettings Mask="(000) 000-0000" IncludeLiterals="None" />
                                </dx:BootstrapTextBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                </Items>
            </dx:BootstrapFormLayout>
            <fieldset>
                <legend class="text-primary">รายละเอียดรถ</legend>
            </fieldset>
            <dx:BootstrapFormLayout ID="BootstrapFormLayout7" runat="server" LayoutType="Horizontal">
                <CssClasses Control="overview-fl" />
                <Items>

                    <dx:BootstrapLayoutItem Caption="ประเภทการประกันภัย" ColSpanMd="4" FieldName="InsureType">
                        <ContentCollection>
                            <dx:ContentControl ID="ContentControl16" runat="server">
                                <dx:BootstrapComboBox runat="server" ID="editInsureType" NullText="เลือกประเภทการประกันภัย..." DataSourceID="SqlDataSource_InsureType" TextField="Name" ValueField="ID">
                                    <ValidationSettings RequiredField-IsRequired="true" ValidationGroup="editPolicyForm"></ValidationSettings>
                                    <ClientSideEvents SelectedIndexChanged="function(s,e){
                                        TaskEditPopup.PerformCallback('calbrokerage');
                                        }" />
                                </dx:BootstrapComboBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="เบอร์กรมธรรม์" ColSpanMd="4" FieldName="PolicyNo">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="editPolicyNo" NullText="พิมพ์เบอร์กรมธรรม์..." ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="editPolicyForm"></dx:BootstrapTextBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="ใหม่/ต่ออายุ" ColSpanMd="4" FieldName="PolicyType">
                        <ContentCollection>
                            <dx:ContentControl>
                                <%-- <dx:BootstrapRadioButtonList ID="BootstrapRadioButtonList1"
                                    ValidationSettings-RequiredField-IsRequired="true" RepeatDirection="Horizontal" RepeatColumns="2" runat="server">
                                    <Items>
                                        <dx:BootstrapListEditItem Text="ใหม่" Value="N" />
                                        <dx:BootstrapListEditItem Text="ต่ออายุ" Value="R" />
                                    </Items>
                                </dx:BootstrapRadioButtonList>--%>

                                <dx:BootstrapComboBox ID="editPolicyType" runat="server" NullText="เลือก..." ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="editPolicyForm">
                                    <Items>
                                        <dx:BootstrapListEditItem Text="ใหม่" Value="N" />
                                        <dx:BootstrapListEditItem Text="ต่ออายุ" Value="R" />
                                    </Items>
                                </dx:BootstrapComboBox>


                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>


                    <dx:BootstrapLayoutItem Caption="วันเริ่มคุ้มครอง" ColSpanMd="4" FieldName="EffectiveDate">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapDateEdit ID="editEffectiveDate" runat="server" NullText="เลือกวันเริ่มคุ้มครอง..." EditFormatString="dd/MM/yyyy" ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="editPolicyForm">
                                </dx:BootstrapDateEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="วันสิ้นสุดคุ้มครอง" ColSpanMd="4" FieldName="ExpiredDate">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapDateEdit ID="editExpiredDate" runat="server" NullText="เลือกวันสิ้นสุดคุ้มครอง..." EditFormatString="dd/MM/yyyy" ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="editPolicyForm">
                                </dx:BootstrapDateEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="ทุนประกัน" ColSpanMd="4" FieldName="Suminsured">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapSpinEdit ID="editSuminsured" runat="server" DisplayFormatString="N0" AllowMouseWheel="false" NullText="พิมพ์ทุนประกัน..."
                                    SpinButtons-Enabled="false" SpinButtons-ClientVisible="false" ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="editPolicyForm">
                                </dx:BootstrapSpinEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>

                    <dx:BootstrapLayoutItem Caption="ทะเบียนรถ" ColSpanMd="4" FieldName="CarLicensePlate">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="editCarLicensePlate" NullText="พิมพ์ทะเบียนรถ..." ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="editPolicyForm"></dx:BootstrapTextBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="ปีจดทะเบียน" ColSpanMd="4" FieldName="CarRegYear">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="editCarRegYear" NullText="พิมพ์ปีจดทะเบียน..." ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="editPolicyForm"></dx:BootstrapTextBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>

                    <dx:BootstrapLayoutItem Caption="เบี้ยประกันภัย" ColSpanMd="4" FieldName="Premium">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapSpinEdit ID="editPremium" runat="server" DisplayFormatString="N2" AllowMouseWheel="false" NullText="พิมพ์เบี้ยประกันภัย..."
                                    SpinButtons-Enabled="false" SpinButtons-ClientVisible="false" ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="editPolicyForm">
                                    <ClientSideEvents ValueChanged="function(s,e){
                                        TaskEditPopup.PerformCallback('calbrokerage');
                                        }" />

                                </dx:BootstrapSpinEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="อากร" ColSpanMd="4" FieldName="Stamp">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapSpinEdit ID="editStamp" ClientEnabled="false" runat="server" DisplayFormatString="N0" AllowMouseWheel="false" NullText="0"
                                    SpinButtons-Enabled="false" SpinButtons-ClientVisible="false">
                                </dx:BootstrapSpinEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="ภาษี" ColSpanMd="4" FieldName="Vat">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapSpinEdit ID="editVat" ClientEnabled="false" runat="server" DisplayFormatString="N0" AllowMouseWheel="false" NullText="0.00"
                                    SpinButtons-Enabled="false" SpinButtons-ClientVisible="false">
                                </dx:BootstrapSpinEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>

                    <dx:BootstrapLayoutItem Caption="เบี้ยประกันภัยรวม" ColSpanMd="4" FieldName="GrossPremium">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapSpinEdit ID="editGrossPremium" ClientEnabled="false" runat="server" DisplayFormatString="N2" AllowMouseWheel="false" NullText="0.00"
                                    SpinButtons-Enabled="false" SpinButtons-ClientVisible="false">
                                </dx:BootstrapSpinEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>

                </Items>
            </dx:BootstrapFormLayout>
            <fieldset>
                <legend class="text-primary">ส่วนเจ้าหน้าที่</legend>
            </fieldset>
            <dx:BootstrapFormLayout ID="BootstrapFormLayout8" runat="server" LayoutType="Horizontal">
                <CssClasses Control="overview-fl" />
                <Items>


                    <dx:BootstrapLayoutItem Caption="ค่าคอม(ประกัน)" ColSpanMd="4" FieldName="BRCommAmt">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapSpinEdit ID="editBRCommAmt" ClientEnabled="false" runat="server" DisplayFormatString="N2" AllowMouseWheel="false" NullText="0.00"
                                    SpinButtons-Enabled="false" SpinButtons-ClientVisible="false" ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="editPolicyForm">
                                </dx:BootstrapSpinEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="ค่าส่งเสริม" ColSpanMd="4" FieldName="PRCommAmt">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapSpinEdit ID="editPRCommAmt" ClientEnabled="false" runat="server" DisplayFormatString="N2" AllowMouseWheel="false" NullText="0.00"
                                    SpinButtons-Enabled="false" SpinButtons-ClientVisible="false" ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="editPolicyForm">
                                </dx:BootstrapSpinEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="ค่านายหน้าจ่าย Sub" ColSpanMd="4" FieldName="SubCommAmt">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapSpinEdit ID="editSubCommAmt" ClientEnabled="false" runat="server" DisplayFormatString="N2" AllowMouseWheel="false" NullText="0.00"
                                    SpinButtons-Enabled="false" SpinButtons-ClientVisible="false" ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="editPolicyForm">
                                </dx:BootstrapSpinEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>


                    <dx:BootstrapLayoutItem Caption="วันที่ส่งกรมธรรม์" ColSpanMd="4" FieldName="SentPolicyDate">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapDateEdit ID="editSentPolicyDate" runat="server" NullText="เลือกวันที่ส่งกรมธรรม์..." EditFormatString="dd/MM/yyyy">
                                </dx:BootstrapDateEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="วันที่ได้รับกรมธรรม์" ColSpanMd="4" FieldName="GetPolicyDate">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapDateEdit ID="editGetPolicyDate" runat="server" NullText="เลือกวันที่ได้รับกรมธรรม์..." EditFormatString="dd/MM/yyyy">
                                </dx:BootstrapDateEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="วันที่ Sub รับกรมธรรม์" ColSpanMd="4" FieldName="SubGetPolicyDate">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapDateEdit ID="editSubGetPolicyDate" runat="server" NullText="เลือก Sub รับกรมธรรม์..." EditFormatString="dd/MM/yyyy">
                                </dx:BootstrapDateEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>




                    <dx:BootstrapLayoutItem Caption="ผู้บันทึก" ColSpanMd="6">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="editCreateBy" ClientEnabled="false"></dx:BootstrapTextBox>

                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>

                    <dx:BootstrapLayoutItem Caption="ผู้แก้ไข" ColSpanMd="6">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="editModifyBy" ClientEnabled="false"></dx:BootstrapTextBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>


                    <dx:BootstrapLayoutItem ShowCaption="False" ColSpanMd="12" HorizontalAlign="Left">
                        <ContentCollection>
                            <dx:ContentControl ID="ContentControl18" runat="server">
                                <dx:BootstrapButton ID="BootstrapButton1" runat="server" AutoPostBack="false" Text="Save" ValidationGroup="editPolicyForm" Width="100px">
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
