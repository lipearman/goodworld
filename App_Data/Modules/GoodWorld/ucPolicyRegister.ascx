<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ucPolicyRegister.ascx.vb" Inherits="Modules_ucPolicyRegister" %>
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
    DataSourceID="SqlDataSource_PolicyRegister"
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


                case 'NewPolicy':
                    TaskNewPopup.Show();
                    //TaskNewPopup.PerformCallback();
                    ASPxClientEdit.ClearEditorsInContainerById('newPolicyForm');
                    e.processOnServer = false;
                    break;
            }
            //e.usePostBack = false;
            //e.processOnServer = false;
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
         <dx:BootstrapGridViewDateColumn FieldName="EffectiveDate" PropertiesDateEdit-DisplayFormatString="dd/MM/yyyy"   />
       

    <%--     <dx:BootstrapGridViewDateColumn FieldName="CreateDate" SortOrder="Descending" PropertiesDateEdit-DisplayFormatString="dd/MM/yyyy HH:mm:ss" SettingsEditForm-Visible="False" />
       <dx:BootstrapGridViewTextColumn FieldName="FirstName" Settings-AllowFilterBySearchPanel="True"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="LastName" Settings-AllowFilterBySearchPanel="True"></dx:BootstrapGridViewTextColumn>
        --%>
        <dx:BootstrapGridViewTextColumn FieldName="ClientName" Settings-AllowFilterBySearchPanel="True"></dx:BootstrapGridViewTextColumn>
        
        <dx:BootstrapGridViewTextColumn FieldName="PolicyNo" Settings-AllowFilterBySearchPanel="True"></dx:BootstrapGridViewTextColumn>


 <dx:BootstrapGridViewTextColumn FieldName="CarLicensePlate"   Caption="ทะเบียนรถ"  ></dx:BootstrapGridViewTextColumn>
       


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

        <dx:BootstrapGridViewDateColumn FieldName="ExpiredDate" PropertiesDateEdit-DisplayFormatString="dd/MM/yyyy"  SettingsEditForm-Visible="False" />


        <dx:BootstrapGridViewSpinEditColumn FieldName="GrossPremium" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>













  <dx:BootstrapGridViewTextColumn FieldName="DOB" Visible="false" Caption="วันเกิด"></dx:BootstrapGridViewTextColumn>
         <dx:BootstrapGridViewTextColumn FieldName="IdentityNo" Visible="false" Caption="บัตรประชาชน"></dx:BootstrapGridViewTextColumn>
       


        <dx:BootstrapGridViewTextColumn FieldName="Suminsured" Visible="false" Caption="จำนวนเงินเอาประกันภัย"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="Premium" Visible="false" Caption="เบี้ยประกันภัย"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="Vat" Visible="false" Caption="ภาษี"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="Stamp" Visible="false" Caption="อากร"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="SentPolicyDate" Visible="false" Caption="วันที่ออกกรมธรรม์"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="GetPolicyDate" Visible="false" Caption="วันที่ได้รับกรมธรรม์"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="CreateDate" Visible="false" Caption="วันที่ทำรายการ "></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="CreateBy" Visible="false" Caption="เจ้าหน้าที่บันทึก"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="ModifyDate" Visible="false" Caption="วันที่แก้ไข"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="ModifyBy" Visible="false" Caption="เจ้าหน้าที่แก้ไข"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="Status" Visible="false" Caption="Status"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="CarRegYear" Visible="false" Caption="ปีรุ่น"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="CustomerType" Visible="false" Caption="CustomerType"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="Fax" Visible="false" Caption="Fax"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="Email" Visible="false" Caption="Email"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="SocialMediaNo" Visible="false" Caption="Line ID /FaceBook"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="BenefitName" Visible="false" Caption="ผู้รับผลประโยชน์"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="NewRenew" Visible="false" Caption="NewRenew"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="RenewPolicyYear" Visible="false" Caption="กรมธรรม์ต่ออายุปีที่"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="CarType" Visible="false" Caption="รหัสรถ"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="CarBrandModel" Visible="false" Caption="ยี่ห้อรถ"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="Engine" Visible="false" Caption="เลขเครื่อง"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="Chassis" Visible="false" Caption="เลขตัวถัง"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="CarSize" Visible="false" Caption="ขนาด/น้ำหนัก/ที่นั่ง"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="ChassisType" Visible="false" Caption="แบบตัวถัง"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="CarUse" Visible="false" Caption="การใช้"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="DriverName1" Visible="false" Caption="ผู้ขับขี่ที่ 1 "></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="DriverDOB1" Visible="false" Caption="วันเดือนปีเกิด"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="DriverName2" Visible="false" Caption="ผู้ขับขี่ที่ 2"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="DriverDOB2" Visible="false" Caption="วันเดือนปีเกิด"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="SendPolicy2CustomerDate" Visible="false" Caption="วันที่ส่งกรมธรรม์ให้ลูกค้า"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="CustomerGetPolicyDate" Visible="false" Caption="วันที่ลูกค้ารับกรมธรรม์"></dx:BootstrapGridViewTextColumn>



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
    <SettingsSearchPanel  Visible="true"/>
</dx:BootstrapGridView>

<asp:SqlDataSource ID="SqlDataSource_PolicyRegister" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
    SelectCommand="select * from tblPolicyRegister Order By CreateDate desc"></asp:SqlDataSource>

<asp:SqlDataSource ID="SqlDataSource_Insurer" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
    SelectCommand="select InsurerCode,  InsurerName + ' (' + InsurerCode + ')' as InsurerName  from tblInsurer "></asp:SqlDataSource>

<asp:SqlDataSource ID="SqlDataSource_InsureType" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
    SelectCommand="select ID, Name from tblInsureType Order by OrderNo "></asp:SqlDataSource>

<asp:SqlDataSource ID="SqlDataSource_PolicyType" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
    SelectCommand="select ID, Name from tblPolicyType Order by OrderNo "></asp:SqlDataSource>


<asp:SqlDataSource ID="SqlDataSource_SubBroker" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
    SelectCommand="select AgentCode,  AgentName + ' (' + AgentCode + ')' as AgentName  from tblSubBroker "></asp:SqlDataSource>


<asp:SqlDataSource ID="SqlDataSource_CarType" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
    SelectCommand="select ID, Code + ' - ' + Name as Name from tblCarType Order by Code "></asp:SqlDataSource>

<asp:SqlDataSource ID="SqlDataSource_CarBrandModel" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
    SelectCommand="select ID, [CarBrand] + ' - ' + [CarModel] as Name from tblCarBrandModel Order by [CarBrand],[CarModel] "></asp:SqlDataSource>


<asp:SqlDataSource ID="SqlDataSource_ClientName" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
    SelectCommand="select ClientName
    from tblPolicyRegister 
    Group By ClientName
    Order By ClientName"></asp:SqlDataSource>


<dx:BootstrapPopupControl ID="TaskNewPopup" ClientInstanceName="TaskNewPopup" runat="server"
    ShowHeader="true" CloseOnEscape="false" CloseAction="CloseButton" HeaderText="ลงทะเบียนกรมธรรม์"
    PopupAnimationType="Fade">
    <SettingsAdaptivity Mode="Always" FixedHeader="true" VerticalAlign="WindowTop" />
    <SettingsBootstrap Sizing="Large" />
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
            else if(s.cpnewtask.indexOf('error') != -1)
            {
                alert(s.cpnewtask);
            }

        }" />


    <ContentCollection>
        <dx:ContentControl ID="ContentControl1" runat="server">
            <fieldset>
                <legend class="text-primary"><i class="fa fa-lg fa-arrow-right">บริษัทประกัน/ตัวแทน</i></legend>
            </fieldset>
            <dx:BootstrapFormLayout ID="BootstrapFormLayout1" runat="server" LayoutType="Horizontal">
                <Items>
                    <dx:BootstrapLayoutItem Caption="บริษัทประกันภัย" ColSpanMd="6">
                        <ContentCollection>
                            <dx:ContentControl ID="ContentControl12" runat="server">
                                <dx:BootstrapComboBox runat="server" ID="newInsurerCode"
                                    NullText="เลือกบริษัทประกันภัย..." DataSourceID="SqlDataSource_Insurer" TextField="InsurerName" ValueField="InsurerCode">
                                    <ValidationSettings></ValidationSettings>

                                </dx:BootstrapComboBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="ตัวแทน" ColSpanMd="6">
                        <ContentCollection>
                            <dx:ContentControl ID="ContentControl13" runat="server">
                                <dx:BootstrapComboBox runat="server" ID="newAgentCode" NullText="เลือกตัวแทน..." DataSourceID="SqlDataSource_SubBroker" TextField="AgentName" ValueField="AgentCode">
                                    <ValidationSettings></ValidationSettings>

                                </dx:BootstrapComboBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>

                </Items>
            </dx:BootstrapFormLayout>
            <fieldset>
                <legend class="text-primary"><i class="fa fa-lg fa-arrow-right">ผู้เอาประกัน</i></legend>
            </fieldset>
            <dx:BootstrapFormLayout ID="BootstrapFormLayout2" runat="server" LayoutType="Horizontal">
                <Items>
                    <dx:BootstrapLayoutItem Caption="บุคลธรรมดา/นิติบุคล" ColSpanMd="6">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapComboBox runat="server" ID="newCustomerType" NullText="เลือก...">
                                    <ValidationSettings></ValidationSettings>
                                    <Items>
                                        <dx:BootstrapListEditItem Text="บุคลธรรมดา" Value="P"></dx:BootstrapListEditItem>
                                        <dx:BootstrapListEditItem Text="นิติบุคล" Value="C"></dx:BootstrapListEditItem>
                                    </Items>
                                </dx:BootstrapComboBox>


                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="ชื่อ" ColSpanMd="6"  >
                        <ContentCollection>
                            <dx:ContentControl>
                                <%--<dx:BootstrapTextBox runat="server" ID="newFirstName" NullText="พิมพ์ชื่อ..."></dx:BootstrapTextBox>--%>
                            
                            <dx:BootstrapComboBox runat="server" DataSourceID="SqlDataSource_ClientName" ID="newClientName" DropDownStyle="DropDown"  
                                TextField="ClientName" ValueField="ClientName" SelectedIndex="0" CallbackPageSize="25" ForceDataBinding="true" EnableCallbackMode="true">
                               <ClientSideEvents SelectedIndexChanged="function(s,e){
                                    TaskNewPopup.PerformCallback('clientselect');
                                   }" />
                            </dx:BootstrapComboBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>

<%--                    <dx:BootstrapLayoutItem Caption="นามสกุล" ColSpanMd="6">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="newLastName" NullText="พิมพ์นามสกุล..."></dx:BootstrapTextBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>--%>


                    <dx:BootstrapLayoutItem Caption="วันเดือนปีเกิด" ColSpanMd="6">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapDateEdit ID="newDOB" runat="server" NullText="เลือกวันเดือนปีเกิด..." EditFormatString="dd/MM/yyyy">
                                </dx:BootstrapDateEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>

                    <dx:BootstrapLayoutItem Caption="บัตรประชาชน" ColSpanMd="6">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="newIdentityNo" NullText="พิมพ์บัตรประชาชน...">
                            
                                </dx:BootstrapTextBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>


                    <dx:BootstrapLayoutItem Caption="ที่อยู่ 1" ColSpanMd="6">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="newAddress1" NullText="พิมพ์ที่อยู่ 1..." ToolTip="ที่อยู่ 1"></dx:BootstrapTextBox>

                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>

                    <dx:BootstrapLayoutItem Caption="ที่อยู่ 2" ColSpanMd="6">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="newAddress2" NullText="พิมพ์ที่อยู่ 2..." ToolTip="ที่อยู่ 2"></dx:BootstrapTextBox>



                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>


                    <dx:BootstrapLayoutItem Caption="โทรศัทพ์บ้าน/สำนักงาน" ColSpanMd="6">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" NullText="พิมพ์โทรศัพท์..." ToolTip="โทรศัพท์" ID="newTelNo">
                                    <%-- <MaskSettings Mask="(000) 000-0000" IncludeLiterals="None" />--%>
                                </dx:BootstrapTextBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="โทรศัพท์มือถือ" ColSpanMd="6">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" NullText="พิมพ์มือถือ..." ToolTip="มือถือ" ID="newMobile">
                                    <%-- <MaskSettings Mask="(000) 000-0000" IncludeLiterals="None" />--%>
                                </dx:BootstrapTextBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="Fax" ColSpanMd="6">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="newFax" NullText="Fax..."></dx:BootstrapTextBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>


                    <dx:BootstrapLayoutItem Caption="Email" ColSpanMd="6">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="newEmail" NullText="Email..."></dx:BootstrapTextBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="Line ID/FaceBook" ColSpanMd="6">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="newSocialMediaNo" NullText="Line..."></dx:BootstrapTextBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>


                    <dx:BootstrapLayoutItem Caption="ผู้รับผลประโยชน์" ColSpanMd="6">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="newBenefitName" NullText="พิมพ์ชื่อ..."></dx:BootstrapTextBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                </Items>
            </dx:BootstrapFormLayout>


            <div id="content">
                <ul id="tabs" class="nav nav-tabs" data-tabs="tabs">
                    <li class="active">
                        <a href="#newtab1" class="fa fa-lg fa-arrow-right" style="font-size: large" data-toggle="tab">รายละเอียดกรมธรรม์</a>

                    </li>
                    <li><a href="#newtab2" class="fa fa-lg fa-arrow-right" style="font-size: large" data-toggle="tab">รายละเอียดรถคันที่เอาประกันภัย</a></li>

                </ul>
                <div id="my-tab-content" class="tab-content">
                    <div class="tab-pane active" id="newtab1">
                        <%--        <fieldset>
                            <legend class="text-primary">รายละเอียดรถ</legend>
                        </fieldset>--%>
                        <dx:BootstrapFormLayout ID="BootstrapFormLayout3" runat="server" LayoutType="Horizontal">
                            <Items>

                                <dx:BootstrapLayoutItem Caption="ประเภทการประกันภัย" ColSpanMd="6">
                                    <ContentCollection>
                                        <dx:ContentControl ID="ContentControl2" runat="server">
                                            <dx:BootstrapComboBox runat="server" ID="newInsureType" NullText="เลือกประเภทการประกันภัย..." DataSourceID="SqlDataSource_InsureType" TextField="Name" ValueField="ID">
                                                <ValidationSettings></ValidationSettings>

                                            </dx:BootstrapComboBox>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                                <dx:BootstrapLayoutItem Caption="ใหม่/ต่ออายุ" ColSpanMd="6">
                                    <ContentCollection>
                                        <dx:ContentControl>
                                            <dx:BootstrapComboBox ID="newNewRenew" runat="server" NullText="เลือก...">
                                                <Items>
                                                    <dx:BootstrapListEditItem Text="ใหม่" Value="N" />
                                                    <dx:BootstrapListEditItem Text="ต่ออายุ" Value="R" />
                                                </Items>
                                            </dx:BootstrapComboBox>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                                <dx:BootstrapLayoutItem Caption="ปีที่ต่ออายุ" ColSpanMd="6">
                                    <ContentCollection>
                                        <dx:ContentControl>
                                            <dx:BootstrapSpinEdit ID="newRenewPolicyYear" runat="server" DisplayFormatString="N0" AllowMouseWheel="false" NullText="ปีที่ต่ออายุ..."
                                                SpinButtons-Enabled="false" SpinButtons-ClientVisible="false">
                                            </dx:BootstrapSpinEdit>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                                <dx:BootstrapLayoutItem Caption="เบอร์กรมธรรม์" ColSpanMd="6">
                                    <ContentCollection>
                                        <dx:ContentControl>
                                            <dx:BootstrapTextBox runat="server" ID="newPolicyNo" NullText="พิมพ์เบอร์กรมธรรม์..."></dx:BootstrapTextBox>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                                <dx:BootstrapLayoutItem Caption="วันเริ่มคุ้มครอง" ColSpanMd="6">
                                    <ContentCollection>
                                        <dx:ContentControl>
                                            <dx:BootstrapDateEdit ID="newEffectiveDate" runat="server" NullText="เลือกวันเริ่มคุ้มครอง..." EditFormatString="dd/MM/yyyy">
                                            </dx:BootstrapDateEdit>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                                <dx:BootstrapLayoutItem Caption="วันสิ้นสุดคุ้มครอง" ColSpanMd="6">
                                    <ContentCollection>
                                        <dx:ContentControl>
                                            <dx:BootstrapDateEdit ID="newExpiredDate" runat="server" NullText="เลือกวันสิ้นสุดคุ้มครอง..." EditFormatString="dd/MM/yyyy">
                                            </dx:BootstrapDateEdit>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>

                                <dx:BootstrapLayoutItem Caption="ประเภทกรมธรรม์" ColSpanMd="6">
                                    <ContentCollection>
                                        <dx:ContentControl ID="ContentControl3" runat="server">
                                            <dx:BootstrapComboBox runat="server" ID="newPolicyType" NullText="เลือกประเภทกรมธรรม์..." DataSourceID="SqlDataSource_PolicyType" TextField="Name" ValueField="ID">
                                                <ValidationSettings></ValidationSettings>

                                            </dx:BootstrapComboBox>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>








                            </Items>
                        </dx:BootstrapFormLayout>

                    </div>
                    <div class="tab-pane" id="newtab2">
                        <dx:BootstrapFormLayout ID="BootstrapFormLayout9" runat="server" LayoutType="Horizontal">
                            <Items>

                                <dx:BootstrapLayoutItem Caption="รหัสรถ" ColSpanMd="6">
                                    <ContentCollection>
                                        <dx:ContentControl>
                                            <dx:BootstrapComboBox runat="server" ID="newCarType" DataSourceID="SqlDataSource_CarType" TextField="Name" ValueField="ID">
                                            </dx:BootstrapComboBox>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                                <dx:BootstrapLayoutItem Caption="ยี่ห้อรถ" ColSpanMd="6">
                                    <ContentCollection>
                                        <dx:ContentControl>
                                            <dx:BootstrapComboBox runat="server" ID="newCarBrandModel" DataSourceID="SqlDataSource_CarBrandModel" TextField="Name" ValueField="ID">
                                            </dx:BootstrapComboBox>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>



                                <dx:BootstrapLayoutItem Caption="ปีรถ" ColSpanMd="6">
                                    <ContentCollection>
                                        <dx:ContentControl>
                                            <dx:BootstrapTextBox runat="server" ID="newCarRegYear"></dx:BootstrapTextBox>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                                <dx:BootstrapLayoutItem Caption="ทะเบียนรถ" ColSpanMd="6">
                                    <ContentCollection>
                                        <dx:ContentControl>
                                            <dx:BootstrapTextBox runat="server" ID="newCarLicensePlate"></dx:BootstrapTextBox>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>



                                <dx:BootstrapLayoutItem Caption="เลขเครื่อง" ColSpanMd="6">
                                    <ContentCollection>
                                        <dx:ContentControl>
                                            <dx:BootstrapTextBox runat="server" ID="newEngine"></dx:BootstrapTextBox>

                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                                <dx:BootstrapLayoutItem Caption="เลขถัง" ColSpanMd="6">
                                    <ContentCollection>
                                        <dx:ContentControl>
                                            <dx:BootstrapTextBox runat="server" ID="newChassis"></dx:BootstrapTextBox>

                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>


                                <dx:BootstrapLayoutItem Caption="ขนาด/น้ำหนัก/ที่นั่ง" ColSpanMd="6">
                                    <ContentCollection>
                                        <dx:ContentControl>
                                            <dx:BootstrapTextBox runat="server" ID="newCarSize"></dx:BootstrapTextBox>

                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                                <dx:BootstrapLayoutItem Caption="แบบตัวถัง" ColSpanMd="6">
                                    <ContentCollection>
                                        <dx:ContentControl>
                                            <dx:BootstrapTextBox runat="server" ID="newChassisType"></dx:BootstrapTextBox>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>

                                <dx:BootstrapLayoutItem Caption="การใช้" ColSpanMd="6">
                                    <ContentCollection>
                                        <dx:ContentControl>
                                            <dx:BootstrapComboBox ID="newCarUse" runat="server">
                                                <Items>
                                                    <dx:BootstrapListEditItem Text="บุคคล" Value="P" />
                                                    <dx:BootstrapListEditItem Text="พาณิชย์" Value="C" />
                                                </Items>
                                            </dx:BootstrapComboBox>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>


                                <dx:BootstrapLayoutItem Caption="ผู้ขับขี่ที่ 1" ColSpanMd="6" BeginRow="true">
                                    <ContentCollection>
                                        <dx:ContentControl>
                                            <dx:BootstrapTextBox runat="server" ID="newDriverName1"></dx:BootstrapTextBox>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                                <dx:BootstrapLayoutItem Caption="วันเดือนปีเกิด" ColSpanMd="6">
                                    <ContentCollection>
                                        <dx:ContentControl>

                                            <dx:BootstrapDateEdit ID="newDriverDOB1" runat="server" EditFormatString="dd/MM/yyyy">
                                            </dx:BootstrapDateEdit>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                                <dx:BootstrapLayoutItem Caption="ผู้ขับขี่ที่ 2" ColSpanMd="6">
                                    <ContentCollection>
                                        <dx:ContentControl>
                                            <dx:BootstrapTextBox runat="server" ID="newDriverName2"></dx:BootstrapTextBox>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                                <dx:BootstrapLayoutItem Caption="วันเดือนปีเกิด" ColSpanMd="6">
                                    <ContentCollection>
                                        <dx:ContentControl>
                                            <dx:BootstrapDateEdit ID="newDriverDOB2" runat="server" EditFormatString="dd/MM/yyyy">
                                            </dx:BootstrapDateEdit>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>

                            </Items>
                        </dx:BootstrapFormLayout>
                    </div>


                </div>
            </div>

            <fieldset>
                <legend class="text-primary"><i class="fa fa-lg fa-arrow-right">รายละเอียดความคุ้มครอง</i></legend>
            </fieldset>
            <dx:BootstrapFormLayout ID="BootstrapFormLayout4" runat="server" LayoutType="Horizontal">
                <CssClasses Control="overview-fl" />
                <Items>

                    <dx:BootstrapLayoutItem Caption="จำนวนเงินเอาประกันภัย" ColSpanMd="4" BeginRow="true">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapSpinEdit ID="newSuminsured" runat="server" DisplayFormatString="N0" AllowMouseWheel="false" NullText="พิมพ์ทุนประกัน..."
                                    SpinButtons-Enabled="false" SpinButtons-ClientVisible="false" Number="0">
                                </dx:BootstrapSpinEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>

                    <dx:BootstrapLayoutItem Caption="เบี้ยประกันภัย" ColSpanMd="4">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapSpinEdit ID="newPremium" runat="server" DisplayFormatString="N2" AllowMouseWheel="false" NullText="พิมพ์เบี้ยประกันภัย..."
                                    SpinButtons-Enabled="false" SpinButtons-ClientVisible="false" Number="0.00">
                                     <ClientSideEvents ValueChanged="function(s,e){
                                        TaskNewPopup.PerformCallback('calpremium');
                                        }" />
                                </dx:BootstrapSpinEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="อากร" ColSpanMd="4">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapSpinEdit ID="newStamp" runat="server" DisplayFormatString="N2" AllowMouseWheel="false" NullText="0.00"
                                    SpinButtons-Enabled="false" SpinButtons-ClientVisible="false" Number="0.00">
                                     <ClientSideEvents ValueChanged="function(s,e){
                                        TaskNewPopup.PerformCallback('calvatstamp');
                                        }" />
                                </dx:BootstrapSpinEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="ภาษี" ColSpanMd="4">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapSpinEdit ID="newVat" runat="server" DisplayFormatString="N2" AllowMouseWheel="false" NullText="0.00"
                                    SpinButtons-Enabled="false" SpinButtons-ClientVisible="false" Number="0.00">
                                      <ClientSideEvents ValueChanged="function(s,e){
                                        TaskNewPopup.PerformCallback('calvatstamp');
                                        }" />
                                </dx:BootstrapSpinEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>

                    <dx:BootstrapLayoutItem Caption="เบี้ยประกันภัยรวม" ColSpanMd="4">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapSpinEdit ID="newGrossPremium" runat="server" DisplayFormatString="N2" AllowMouseWheel="false" NullText="0.00"
                                    SpinButtons-Enabled="false" SpinButtons-ClientVisible="false" Number="0.00">
                                </dx:BootstrapSpinEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>


                    <dx:BootstrapLayoutItem Caption="ค่าคอม(ประกัน)" ColSpanMd="4">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapSpinEdit ID="newBRCommAmt" runat="server" DisplayFormatString="N2" AllowMouseWheel="false" NullText="0.00"
                                    SpinButtons-Enabled="false" SpinButtons-ClientVisible="false" Number="0.00">
                                </dx:BootstrapSpinEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="ค่าส่งเสริม" ColSpanMd="4">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapSpinEdit ID="newPRCommAmt" runat="server" DisplayFormatString="N2" AllowMouseWheel="false" NullText="0.00"
                                    SpinButtons-Enabled="false" SpinButtons-ClientVisible="false" Number="0.00">
                                </dx:BootstrapSpinEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="ค่านายหน้าจ่าย Sub" ColSpanMd="4">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapSpinEdit ID="newSubCommAmt" runat="server" DisplayFormatString="N2" AllowMouseWheel="false" NullText="0.00"
                                    SpinButtons-Enabled="false" SpinButtons-ClientVisible="false" Number="0.00">
                                </dx:BootstrapSpinEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>


                    <dx:BootstrapLayoutItem Caption="วันที่ออก กธ." ColSpanMd="4">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapDateEdit ID="newSentPolicyDate" runat="server" EditFormatString="dd/MM/yyyy">
                                </dx:BootstrapDateEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="วันที่ได้รับ กธ." ColSpanMd="4">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapDateEdit ID="newGetPolicyDate" runat="server" EditFormatString="dd/MM/yyyy">
                                </dx:BootstrapDateEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>

                    <dx:BootstrapLayoutItem Caption="วันที่ส่ง กธ.ให้ลูกค้า" ColSpanMd="4">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapDateEdit ID="newSendPolicy2CustomerDate" runat="server" EditFormatString="dd/MM/yyyy">
                                </dx:BootstrapDateEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>

                    <dx:BootstrapLayoutItem Caption="วันที่ลูกค้ารับ กธ." ColSpanMd="4">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapDateEdit ID="newCustomerGetPolicyDate" runat="server" EditFormatString="dd/MM/yyyy">
                                </dx:BootstrapDateEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>


                    <%--          <dx:BootstrapLayoutItem Caption="วันที่ Sub รับกรมธรรม์" ColSpanMd="4">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapDateEdit ID="newSubGetPolicyDate" runat="server" NullText="เลือก Sub รับกรมธรรม์..." EditFormatString="dd/MM/yyyy">
                                </dx:BootstrapDateEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>--%>






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
    ShowHeader="true" CloseOnEscape="false" CloseAction="CloseButton" HeaderText="ลงทะเบียนกรมธรรม์"
    PopupAnimationType="Fade">
    <SettingsAdaptivity Mode="Always" FixedHeader="true" VerticalAlign="WindowTop" />
    <SettingsBootstrap Sizing="Large" />
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
            else if(s.cpedittask.indexOf('error') != -1)
            {
                alert(s.cpedittask);
            }

        }" />


    <ContentCollection>
        <dx:ContentControl ID="ContentControl7" runat="server">
            <dx:ASPxHiddenField runat="server" ID="hdID"></dx:ASPxHiddenField>

            <fieldset>
                <legend class="text-primary"><i class="fa fa-lg fa-arrow-right">บริษัทประกัน/ตัวแทน</i></legend>
            </fieldset>
            <dx:BootstrapFormLayout ID="BootstrapFormEdit1" runat="server" LayoutType="Horizontal">
                <CssClasses Control="overview-fl" />
                <Items>
                    <dx:BootstrapLayoutItem Caption="บริษัทประกันภัย" ColSpanMd="6" FieldName="InsurerCode">
                        <ContentCollection>
                            <dx:ContentControl ID="ContentControl8" runat="server">
                                <dx:BootstrapComboBox runat="server" ID="editInsurerCode" NullText="เลือกบริษัทประกันภัย..." DataSourceID="SqlDataSource_Insurer" TextField="InsurerName" ValueField="InsurerCode">
                                    <ValidationSettings></ValidationSettings>

                                </dx:BootstrapComboBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="ตัวแทน" ColSpanMd="6" FieldName="AgentCode">
                        <ContentCollection>
                            <dx:ContentControl ID="ContentControl9" runat="server">
                                <dx:BootstrapComboBox runat="server" ID="editAgentCode" NullText="เลือกตัวแทน..." DataSourceID="SqlDataSource_SubBroker" TextField="AgentName" ValueField="AgentCode">
                                    <ValidationSettings></ValidationSettings>

                                </dx:BootstrapComboBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                </Items>
            </dx:BootstrapFormLayout>
            <fieldset>
                <legend class="text-primary"><i class="fa fa-lg fa-arrow-right">ผู้เอาประกัน</i></legend>
            </fieldset>
            <dx:BootstrapFormLayout ID="BootstrapFormEdit2" runat="server" LayoutType="Horizontal">
                <CssClasses Control="overview-fl" />
                <Items>

                    <dx:BootstrapLayoutItem Caption="บุคลธรรมดา/นิติบุคล" ColSpanMd="6" FieldName="CustomerType">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapComboBox runat="server" ID="editCustomerType" NullText="เลือก...">
                                    <ValidationSettings></ValidationSettings>
                                    <Items>
                                        <dx:BootstrapListEditItem Text="บุคลธรรมดา" Value="P"></dx:BootstrapListEditItem>
                                        <dx:BootstrapListEditItem Text="นิติบุคล" Value="C"></dx:BootstrapListEditItem>
                                    </Items>
                                </dx:BootstrapComboBox>


                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>

                    <dx:BootstrapLayoutItem Caption="ชื่อ" ColSpanMd="6" FieldName="ClientName">
                        <ContentCollection>
                            <dx:ContentControl>
                               <%-- <dx:BootstrapTextBox runat="server" ID="editFirstName" NullText="พิมพ์ชื่อ..."></dx:BootstrapTextBox>
                            --%>
                              <dx:BootstrapComboBox runat="server" DataSourceID="SqlDataSource_ClientName" ID="editClientName" DropDownStyle="DropDown"  
                                TextField="ClientName" ValueField="ClientName" SelectedIndex="0" CallbackPageSize="25" EnableCallbackMode="true">
                                  <ClientSideEvents SelectedIndexChanged="function(s,e){
                                    TaskEditPopup.PerformCallback('clientselect');
                                   }" />
                            </dx:BootstrapComboBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>

                <%--    <dx:BootstrapLayoutItem Caption="นามสกุล" ColSpanMd="6" FieldName="LastName">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="editLastName" NullText="พิมพ์นามสกุล..."></dx:BootstrapTextBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>--%>

                    <dx:BootstrapLayoutItem Caption="วันเดือนปีเกิด" ColSpanMd="6" FieldName="DOB">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapDateEdit ID="editDOB" runat="server" NullText="เลือกวันเดือนปีเกิด..." EditFormatString="dd/MM/yyyy">
                                </dx:BootstrapDateEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="บัตรประชาชน" ColSpanMd="6" FieldName="IdentityNo">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="editIdentityNo" NullText="พิมพ์บัตรประชาชน...">
                                   
                                </dx:BootstrapTextBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>


                    <dx:BootstrapLayoutItem Caption="ที่อยู่ 1" ColSpanMd="6" FieldName="Address1">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="editAddress1" NullText="พิมพ์ที่อยู่ 1..." ToolTip="ที่อยู่ 1"></dx:BootstrapTextBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="ที่อยู่ 2" ColSpanMd="6" FieldName="Address2">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="editAddress2" NullText="พิมพ์ที่อยู่ 2..." ToolTip="ที่อยู่ 2"></dx:BootstrapTextBox>

                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>



                    <dx:BootstrapLayoutItem Caption="โทรศัทพ์บ้าน/สำนักงาน" ColSpanMd="6" FieldName="TelNo">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" NullText="พิมพ์โทรศัพท์..." ToolTip="โทรศัพท์" ID="editTelNo">
                                </dx:BootstrapTextBox>


                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="โทรศัพท์มือถือ" ColSpanMd="6" FieldName="Mobile">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" NullText="พิมพ์มือถือ..." ToolTip="มือถือ" ID="editMobile">
                                </dx:BootstrapTextBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>


                    <dx:BootstrapLayoutItem Caption="Fax" ColSpanMd="6" FieldName="Fax">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="editFax" NullText="Fax..."></dx:BootstrapTextBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>




                    <dx:BootstrapLayoutItem Caption="Email" ColSpanMd="6" FieldName="Email">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="editEmail" NullText="Email..."></dx:BootstrapTextBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="Line ID/FaceBook" ColSpanMd="6" FieldName="SocialMediaNo">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="editSocialMediaNo" NullText="Line..."></dx:BootstrapTextBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>


                    <dx:BootstrapLayoutItem Caption="ผู้รับผลประโยชน์" ColSpanMd="6" FieldName="BenefitName">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="editBenefitName" NullText="พิมพ์ชื่อ..."></dx:BootstrapTextBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                </Items>
            </dx:BootstrapFormLayout>

            <div id="content">
                <ul id="tabs" class="nav nav-tabs" data-tabs="tabs">
                    <li class="active">
                        <a href="#edittab1" class="fa fa-lg fa-arrow-right" style="font-size: large" data-toggle="tab">รายละเอียดกรมธรรม์</a>

                    </li>
                    <li><a href="#edittab2" class="fa fa-lg fa-arrow-right" style="font-size: large" data-toggle="tab">รายละเอียดรถคันที่เอาประกันภัย</a></li>

                </ul>
                <div id="my-tab-content" class="tab-content">
                    <div class="tab-pane active" id="edittab1">
                        <dx:BootstrapFormLayout ID="BootstrapFormEdit3" runat="server" LayoutType="Horizontal">
                            <Items>

                                <dx:BootstrapLayoutItem Caption="ประเภทการประกันภัย" ColSpanMd="6" FieldName="InsureType">
                                    <ContentCollection>
                                        <dx:ContentControl ID="ContentControl4" runat="server">
                                            <dx:BootstrapComboBox runat="server" ID="editInsureType" NullText="เลือกประเภทการประกันภัย..." DataSourceID="SqlDataSource_InsureType" TextField="Name" ValueField="ID">
                                                <ValidationSettings></ValidationSettings>

                                            </dx:BootstrapComboBox>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                                <dx:BootstrapLayoutItem Caption="ใหม่/ต่ออายุ" ColSpanMd="6" FieldName="NewRenew">
                                    <ContentCollection>
                                        <dx:ContentControl>
                                            <dx:BootstrapComboBox ID="editNewRenew" runat="server" NullText="เลือก...">
                                                <Items>
                                                    <dx:BootstrapListEditItem Text="ใหม่" Value="N" />
                                                    <dx:BootstrapListEditItem Text="ต่ออายุ" Value="R" />
                                                </Items>
                                            </dx:BootstrapComboBox>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                                <dx:BootstrapLayoutItem Caption="ปีที่ต่ออายุ" ColSpanMd="6" FieldName="RenewPolicyYear">
                                    <ContentCollection>
                                        <dx:ContentControl>
                                            <dx:BootstrapSpinEdit ID="editRenewPolicyYear" runat="server" DisplayFormatString="N0" AllowMouseWheel="false" NullText="ปีที่ต่ออายุ..."
                                                SpinButtons-Enabled="false" SpinButtons-ClientVisible="false">
                                            </dx:BootstrapSpinEdit>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                                <dx:BootstrapLayoutItem Caption="เบอร์กรมธรรม์" ColSpanMd="6" FieldName="PolicyNo">
                                    <ContentCollection>
                                        <dx:ContentControl>
                                            <dx:BootstrapTextBox runat="server" ID="editPolicyNo" NullText="พิมพ์เบอร์กรมธรรม์..."></dx:BootstrapTextBox>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                                <dx:BootstrapLayoutItem Caption="วันเริ่มคุ้มครอง" ColSpanMd="6" FieldName="EffectiveDate">
                                    <ContentCollection>
                                        <dx:ContentControl>
                                            <dx:BootstrapDateEdit ID="editEffectiveDate" runat="server" NullText="เลือกวันเริ่มคุ้มครอง..." EditFormatString="dd/MM/yyyy">
                                            </dx:BootstrapDateEdit>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                                <dx:BootstrapLayoutItem Caption="วันสิ้นสุดคุ้มครอง" ColSpanMd="6" FieldName="ExpiredDate">
                                    <ContentCollection>
                                        <dx:ContentControl>
                                            <dx:BootstrapDateEdit ID="editExpiredDate" runat="server" NullText="เลือกวันสิ้นสุดคุ้มครอง..." EditFormatString="dd/MM/yyyy">
                                            </dx:BootstrapDateEdit>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>

                                <dx:BootstrapLayoutItem Caption="ประเภทกรมธรรม์" ColSpanMd="6" FieldName="PolicyType">
                                    <ContentCollection>
                                        <dx:ContentControl ID="ContentControl5" runat="server">
                                            <dx:BootstrapComboBox runat="server" ID="editPolicyType" NullText="เลือกประเภทกรมธรรม์..." DataSourceID="SqlDataSource_PolicyType" TextField="Name" ValueField="ID">
                                                <ValidationSettings></ValidationSettings>

                                            </dx:BootstrapComboBox>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>








                            </Items>
                        </dx:BootstrapFormLayout>

                    </div>
                    <div class="tab-pane" id="edittab2">
                        <dx:BootstrapFormLayout ID="BootstrapFormEdit4" runat="server" LayoutType="Horizontal">
                            <Items>

                                <dx:BootstrapLayoutItem Caption="รหัสรถ" ColSpanMd="6" FieldName="CarType">
                                    <ContentCollection>
                                        <dx:ContentControl>
                                            <dx:BootstrapComboBox runat="server" ID="editCarType" DataSourceID="SqlDataSource_CarType" TextField="Name" ValueField="ID">
                                            </dx:BootstrapComboBox>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                                <dx:BootstrapLayoutItem Caption="ยี่ห้อรถ" ColSpanMd="6" FieldName="CarBrandModel">
                                    <ContentCollection>
                                        <dx:ContentControl>
                                            <dx:BootstrapComboBox runat="server" ID="editCarBrandModel" DataSourceID="SqlDataSource_CarBrandModel" TextField="Name" ValueField="ID">
                                            </dx:BootstrapComboBox>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>


                                <dx:BootstrapLayoutItem Caption="ปีรถ" ColSpanMd="6" FieldName="CarRegYear">
                                    <ContentCollection>
                                        <dx:ContentControl>
                                            <dx:BootstrapTextBox runat="server" ID="editCarRegYear"></dx:BootstrapTextBox>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>

                                <dx:BootstrapLayoutItem Caption="ทะเบียนรถ" ColSpanMd="6" FieldName="CarLicensePlate">
                                    <ContentCollection>
                                        <dx:ContentControl>
                                            <dx:BootstrapTextBox runat="server" ID="editCarLicensePlate"></dx:BootstrapTextBox>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>



                                <dx:BootstrapLayoutItem Caption="เลขเครื่อง" ColSpanMd="6" FieldName="Engine">
                                    <ContentCollection>
                                        <dx:ContentControl>
                                            <dx:BootstrapTextBox runat="server" ID="editEngine"></dx:BootstrapTextBox>

                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                                <dx:BootstrapLayoutItem Caption="เลขถัง" ColSpanMd="6" FieldName="Chassis">
                                    <ContentCollection>
                                        <dx:ContentControl>
                                            <dx:BootstrapTextBox runat="server" ID="editChassis"></dx:BootstrapTextBox>

                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>


                                <dx:BootstrapLayoutItem Caption="ขนาด/น้ำหนัก/ที่นั่ง" ColSpanMd="6" FieldName="CarSize">
                                    <ContentCollection>
                                        <dx:ContentControl>
                                            <dx:BootstrapTextBox runat="server" ID="editCarSize"></dx:BootstrapTextBox>

                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                                <dx:BootstrapLayoutItem Caption="แบบตัวถัง" ColSpanMd="6" FieldName="ChassisType">
                                    <ContentCollection>
                                        <dx:ContentControl>
                                            <dx:BootstrapTextBox runat="server" ID="editChassisType"></dx:BootstrapTextBox>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>

                                <dx:BootstrapLayoutItem Caption="การใช้" ColSpanMd="6" FieldName="CarUse">
                                    <ContentCollection>
                                        <dx:ContentControl>
                                            <dx:BootstrapComboBox ID="editCarUse" runat="server">
                                                <Items>
                                                    <dx:BootstrapListEditItem Text="บุคคล" Value="P" />
                                                    <dx:BootstrapListEditItem Text="พาณิชย์" Value="C" />
                                                </Items>
                                            </dx:BootstrapComboBox>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>


                                <dx:BootstrapLayoutItem Caption="ผู้ขับขี่ที่ 1" ColSpanMd="6" BeginRow="true" FieldName="DriverName1">
                                    <ContentCollection>
                                        <dx:ContentControl>
                                            <dx:BootstrapTextBox runat="server" ID="editDriverName1"></dx:BootstrapTextBox>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                                <dx:BootstrapLayoutItem Caption="วันเดือนปีเกิด" ColSpanMd="6" FieldName="DriverDOB1">
                                    <ContentCollection>
                                        <dx:ContentControl>

                                            <dx:BootstrapDateEdit ID="editDriverDOB1" runat="server" EditFormatString="dd/MM/yyyy">
                                            </dx:BootstrapDateEdit>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                                <dx:BootstrapLayoutItem Caption="ผู้ขับขี่ที่ 2" ColSpanMd="6" FieldName="DriverName2">
                                    <ContentCollection>
                                        <dx:ContentControl>
                                            <dx:BootstrapTextBox runat="server" ID="editDriverName2"></dx:BootstrapTextBox>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                                <dx:BootstrapLayoutItem Caption="วันเดือนปีเกิด" ColSpanMd="6" FieldName="DriverDOB2">
                                    <ContentCollection>
                                        <dx:ContentControl>
                                            <dx:BootstrapDateEdit ID="editDriverDOB2" runat="server" EditFormatString="dd/MM/yyyy">
                                            </dx:BootstrapDateEdit>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>

                            </Items>
                        </dx:BootstrapFormLayout>
                    </div>


                </div>
            </div>

            <fieldset>
                <legend class="text-primary"><i class="fa fa-lg fa-arrow-right">รายละเอียดความคุ้มครอง</i></legend>
            </fieldset>
            <dx:BootstrapFormLayout ID="BootstrapFormEdit5" runat="server" LayoutType="Horizontal">
                <CssClasses Control="overview-fl" />
                <Items>

                    <dx:BootstrapLayoutItem Caption="จำนวนเงินเอาประกันภัย" ColSpanMd="4" FieldName="Suminsured">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapSpinEdit ID="editSuminsured" runat="server" DisplayFormatString="N0" AllowMouseWheel="false" NullText="พิมพ์ทุนประกัน..."
                                    SpinButtons-Enabled="false" SpinButtons-ClientVisible="false">
                                </dx:BootstrapSpinEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>

                    <dx:BootstrapLayoutItem Caption="เบี้ยประกันภัย" ColSpanMd="4" FieldName="Premium">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapSpinEdit ID="editPremium" runat="server" DisplayFormatString="N2" AllowMouseWheel="false" NullText="พิมพ์เบี้ยประกันภัย..."
                                    SpinButtons-Enabled="false" SpinButtons-ClientVisible="false">
                                     <ClientSideEvents ValueChanged="function(s,e){
                                        TaskEditPopup.PerformCallback('calpremium');
                                        }" />
                                </dx:BootstrapSpinEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="อากร" ColSpanMd="4" FieldName="Stamp">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapSpinEdit ID="editStamp" runat="server" DisplayFormatString="N2" AllowMouseWheel="false" NullText="0"
                                    SpinButtons-Enabled="false" SpinButtons-ClientVisible="false">
                                    <ClientSideEvents ValueChanged="function(s,e){
                                        TaskEditPopup.PerformCallback('calvatstamp');
                                        }" />
                                </dx:BootstrapSpinEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="ภาษี" ColSpanMd="4" FieldName="Vat">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapSpinEdit ID="editVat" runat="server" DisplayFormatString="N2" AllowMouseWheel="false" NullText="0.00"
                                    SpinButtons-Enabled="false" SpinButtons-ClientVisible="false">
                                    <ClientSideEvents ValueChanged="function(s,e){
                                        TaskEditPopup.PerformCallback('calvatstamp');
                                        }" />
                                </dx:BootstrapSpinEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>

                    <dx:BootstrapLayoutItem Caption="เบี้ยประกันภัยรวม" ColSpanMd="4" FieldName="GrossPremium">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapSpinEdit ID="editGrossPremium" runat="server" DisplayFormatString="N2" AllowMouseWheel="false" NullText="0.00"
                                    SpinButtons-Enabled="false" SpinButtons-ClientVisible="false">
                                </dx:BootstrapSpinEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>




                    <dx:BootstrapLayoutItem Caption="ค่าคอม(ประกัน)" ColSpanMd="4" FieldName="BRCommAmt">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapSpinEdit ID="editBRCommAmt" runat="server" DisplayFormatString="N2" AllowMouseWheel="false" NullText="0.00"
                                    SpinButtons-Enabled="false" SpinButtons-ClientVisible="false">
                                </dx:BootstrapSpinEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>

                    <dx:BootstrapLayoutItem Caption="ค่าส่งเสริม" ColSpanMd="4" FieldName="PRCommAmt">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapSpinEdit ID="editPRCommAmt" runat="server" DisplayFormatString="N2" AllowMouseWheel="false" NullText="0.00"
                                    SpinButtons-Enabled="false" SpinButtons-ClientVisible="false">
                                </dx:BootstrapSpinEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="ค่านายหน้าจ่าย Sub" ColSpanMd="4" FieldName="SubCommAmt">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapSpinEdit ID="editSubCommAmt" runat="server" DisplayFormatString="N2" AllowMouseWheel="false" NullText="0.00"
                                    SpinButtons-Enabled="false" SpinButtons-ClientVisible="false">
                                </dx:BootstrapSpinEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>


                    <dx:BootstrapLayoutItem Caption="วันที่ออก กธ." ColSpanMd="4" FieldName="SentPolicyDate">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapDateEdit ID="editSentPolicyDate" runat="server" NullText="เลือกวันที่ออก กธ...." EditFormatString="dd/MM/yyyy">
                                </dx:BootstrapDateEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="วันที่ได้รับ กธ." ColSpanMd="4" FieldName="GetPolicyDate">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapDateEdit ID="editGetPolicyDate" runat="server" NullText="เลือกวันที่ได้รับ กธ...." EditFormatString="dd/MM/yyyy">
                                </dx:BootstrapDateEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <%-- <dx:BootstrapLayoutItem Caption="วันที่ Sub รับกรมธรรม์" ColSpanMd="4" FieldName="SubGetPolicyDate">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapDateEdit ID="editSubGetPolicyDate" runat="server" NullText="เลือก Sub รับกรมธรรม์..." EditFormatString="dd/MM/yyyy">
                                </dx:BootstrapDateEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>--%>
                    <dx:BootstrapLayoutItem Caption="วันที่ส่ง กธ.ให้ลูกค้า" ColSpanMd="4" FieldName="SendPolicy2CustomerDate">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapDateEdit ID="editSendPolicy2CustomerDate" runat="server" EditFormatString="dd/MM/yyyy">
                                </dx:BootstrapDateEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>

                    <dx:BootstrapLayoutItem Caption="วันที่ลูกค้ารับ กธ." ColSpanMd="4" FieldName="CustomerGetPolicyDate">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapDateEdit ID="editCustomerGetPolicyDate" runat="server" EditFormatString="dd/MM/yyyy">
                                </dx:BootstrapDateEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>


                    <dx:BootstrapLayoutItem Caption="สถานะ" ColSpanMd="4" FieldName="Status">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapComboBox ID="editStatus" runat="server">
                                    <Items>
                                        <dx:BootstrapListEditItem Text="Active" Value="1" />
                                        <dx:BootstrapListEditItem Text="Cancel" Value="0" />
                                    </Items>
                                </dx:BootstrapComboBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>


                    <dx:BootstrapLayoutItem Caption="หมายเหตุ" ColSpanMd="8" FieldName="Remark">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="editRemark"></dx:BootstrapTextBox>
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
