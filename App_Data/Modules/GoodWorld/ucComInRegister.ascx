<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ucComInRegister.ascx.vb" Inherits="Modules_ucComInRegister" %>

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
        <%--เลขที่
เบอร์กรมธรรม์
ชื่อผู้เอาประกัน

เบี้ยประกัน
แสตมป์
ภาษี
เบี้ยรวมภาษี
ส่วนลด
ส่วนลด
เบี้ยสุทธิ

ลงวันที่--%>
        <dx:BootstrapGridViewTextColumn FieldName="PolicyNo" Caption="เบอร์กรมธรรม์" Settings-AllowFilterBySearchPanel="True"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn Caption="เลขที่ใบเสร็จ"></dx:BootstrapGridViewTextColumn>

        <dx:BootstrapGridViewSpinEditColumn FieldName="Premium" Caption="เบี้ยประกัน" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>
        <dx:BootstrapGridViewSpinEditColumn FieldName="Stamp" Caption="แสตมป์" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>
        <dx:BootstrapGridViewSpinEditColumn FieldName="Vat" Caption="ภาษี" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>
        <dx:BootstrapGridViewSpinEditColumn FieldName="GrossPremium" Caption="เบี้ยรวมภาษี" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>
        
<dx:BootstrapGridViewSpinEditColumn FieldName="BRCommAmt" Caption="ค่านายหน้า" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>
                <dx:BootstrapGridViewComboBoxColumn FieldName="InsurerCode" Caption="บริษัทประกันภัย">
            <PropertiesComboBox DataSourceID="SqlDataSource_Insurer" TextField="InsurerName" ValueField="InsurerCode">
                <ValidationSettings>
                    <RequiredField IsRequired="true" />
                </ValidationSettings>
            </PropertiesComboBox>
        </dx:BootstrapGridViewComboBoxColumn>


   <dx:BootstrapGridViewComboBoxColumn FieldName="InsureType" Caption="ประเภทการประกันภัย">
            <PropertiesComboBox DataSourceID="SqlDataSource_InsureType" TextField="Name" ValueField="ID">
                <ValidationSettings>
                    <RequiredField IsRequired="true" />
                </ValidationSettings>
            </PropertiesComboBox>
        </dx:BootstrapGridViewComboBoxColumn>

 <dx:BootstrapGridViewDateColumn FieldName="CreateDate" Width="100" AdaptivePriority="2"  Caption="วันที่รับเงิน" PropertiesDateEdit-DisplayFormatString="dd/MM/yyyy HH:mm:ss"  SettingsEditForm-Visible="False" />


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
    ShowHeader="true" CloseOnEscape="false" CloseAction="CloseButton" HeaderText="ค่านายหน้า"
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

            <fieldset>
                <legend class="text-primary">ค่านายหน้า</legend>
            </fieldset>
            <dx:BootstrapFormLayout ID="BootstrapFormLayout4" runat="server" LayoutType="Horizontal">
                <CssClasses Control="overview-fl" />
                <Items>

                     <dx:BootstrapLayoutItem Caption="บริษัทประกันภัย" ColSpanMd="6">
                        <ContentCollection>
                            <dx:ContentControl ID="ContentControl2" runat="server">
                                <dx:BootstrapComboBox runat="server" ID="BootstrapComboBox1"
                                    NullText="เลือกบริษัทประกันภัย..." DataSourceID="SqlDataSource_Insurer" TextField="InsurerName" ValueField="InsurerCode">
                                    <ValidationSettings RequiredField-IsRequired="true" ValidationGroup="newPolicyForm"></ValidationSettings>
                                    <ClientSideEvents SelectedIndexChanged="function(s,e){
                                        TaskNewPopup.PerformCallback('calbrokerage');
                                        }" />
                                </dx:BootstrapComboBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="เบอร์กรมธรรม์" ColSpanMd="6">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="newPolicyNo" NullText="พิมพ์เบอร์กรมธรรม์..." ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="newPolicyForm"></dx:BootstrapTextBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>

 
                    
                    <dx:BootstrapLayoutItem Caption="ค่านายหน้า" ColSpanMd="4" BeginRow="true">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapSpinEdit ID="newBRCommAmt" ClientEnabled="false" runat="server" DisplayFormatString="N2" AllowMouseWheel="false" NullText="0.00"
                                    SpinButtons-Enabled="false" SpinButtons-ClientVisible="false" ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="newPolicyForm">
                                </dx:BootstrapSpinEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>

                           <dx:BootstrapLayoutItem Caption="ภาษีมูลค่าเพิ่ม" ColSpanMd="4">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapSpinEdit ID="newVat" ClientEnabled="false" runat="server" DisplayFormatString="N0" AllowMouseWheel="false" NullText="0.00"
                                    SpinButtons-Enabled="false" SpinButtons-ClientVisible="false">
                                </dx:BootstrapSpinEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>

                    
              
                    <dx:BootstrapLayoutItem Caption="รวมเป็นเงิน" ColSpanMd="4"  >
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapSpinEdit ID="newGrossPremium" ClientEnabled="false" runat="server" DisplayFormatString="N2" AllowMouseWheel="false" NullText="0.00"
                                    SpinButtons-Enabled="false" SpinButtons-ClientVisible="false">
                                </dx:BootstrapSpinEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>

                     



                       <dx:BootstrapLayoutItem Caption="ชำระโดย" ColSpanMd="6" BeginRow="true">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="BootstrapTextBox7" NullText="..." ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="newPolicyForm"></dx:BootstrapTextBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>

                          <dx:BootstrapLayoutItem Caption="ธนาคาร" ColSpanMd="6" >
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="BootstrapTextBox2" NullText="..." ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="newPolicyForm"></dx:BootstrapTextBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>

             <dx:BootstrapLayoutItem Caption="สาขา" ColSpanMd="4"  BeginRow="true">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="BootstrapTextBox3" NullText="..." ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="newPolicyForm"></dx:BootstrapTextBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    
                    <dx:BootstrapLayoutItem Caption="เลขที่" ColSpanMd="4">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="BootstrapTextBox1" NullText="..." ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="newPolicyForm"></dx:BootstrapTextBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>

                    <dx:BootstrapLayoutItem Caption="ลงวันที่" ColSpanMd="4" >
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapDateEdit ID="newSentPolicyDate" ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="newPolicyForm" runat="server" NullText="เลือกวันที่..." EditFormatString="dd/MM/yyyy">
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
    ShowHeader="true" CloseOnEscape="false" CloseAction="CloseButton" HeaderText="ค่านายหน้า"
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

            <fieldset>
                <legend class="text-primary">ค่านายหน้า</legend>
            </fieldset>
            <dx:BootstrapFormLayout ID="BootstrapFormLayout8" runat="server" LayoutType="Horizontal">
                <CssClasses Control="overview-fl" />
                <Items>

                       <dx:BootstrapLayoutItem Caption="บริษัทประกันภัย" ColSpanMd="6">
                        <ContentCollection>
                            <dx:ContentControl ID="ContentControl3" runat="server">
                                <dx:BootstrapComboBox runat="server" ID="BootstrapComboBox2"
                                    NullText="เลือกบริษัทประกันภัย..." DataSourceID="SqlDataSource_Insurer" TextField="InsurerName" ValueField="InsurerCode">
                                    <ValidationSettings RequiredField-IsRequired="true" ValidationGroup="newPolicyForm"></ValidationSettings>
                                    <ClientSideEvents SelectedIndexChanged="function(s,e){
                                        TaskNewPopup.PerformCallback('calbrokerage');
                                        }" />
                                </dx:BootstrapComboBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="เบอร์กรมธรรม์" ColSpanMd="6">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="BootstrapTextBox4" NullText="พิมพ์เบอร์กรมธรรม์..." ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="newPolicyForm"></dx:BootstrapTextBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>

 
                    
                    <dx:BootstrapLayoutItem Caption="ค่านายหน้า" ColSpanMd="4" BeginRow="true">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapSpinEdit ID="BootstrapSpinEdit1" ClientEnabled="false" runat="server" DisplayFormatString="N2" AllowMouseWheel="false" NullText="0.00"
                                    SpinButtons-Enabled="false" SpinButtons-ClientVisible="false" ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="newPolicyForm">
                                </dx:BootstrapSpinEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>

                           <dx:BootstrapLayoutItem Caption="ภาษีมูลค่าเพิ่ม" ColSpanMd="4">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapSpinEdit ID="BootstrapSpinEdit2" ClientEnabled="false" runat="server" DisplayFormatString="N0" AllowMouseWheel="false" NullText="0.00"
                                    SpinButtons-Enabled="false" SpinButtons-ClientVisible="false">
                                </dx:BootstrapSpinEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>

                    
              
                    <dx:BootstrapLayoutItem Caption="รวมเป็นเงิน" ColSpanMd="4"  >
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapSpinEdit ID="BootstrapSpinEdit3" ClientEnabled="false" runat="server" DisplayFormatString="N2" AllowMouseWheel="false" NullText="0.00"
                                    SpinButtons-Enabled="false" SpinButtons-ClientVisible="false">
                                </dx:BootstrapSpinEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>

                     



                       <dx:BootstrapLayoutItem Caption="ชำระโดย" ColSpanMd="6" BeginRow="true">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="BootstrapTextBox5" NullText="..." ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="newPolicyForm"></dx:BootstrapTextBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>

                          <dx:BootstrapLayoutItem Caption="ธนาคาร" ColSpanMd="6" >
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="BootstrapTextBox6" NullText="..." ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="newPolicyForm"></dx:BootstrapTextBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>

             <dx:BootstrapLayoutItem Caption="สาขา" ColSpanMd="4"  BeginRow="true">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="BootstrapTextBox8" NullText="..." ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="newPolicyForm"></dx:BootstrapTextBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    
                    <dx:BootstrapLayoutItem Caption="เลขที่" ColSpanMd="4">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="BootstrapTextBox9" NullText="..." ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="newPolicyForm"></dx:BootstrapTextBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>

                    <dx:BootstrapLayoutItem Caption="ลงวันที่" ColSpanMd="4" >
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapDateEdit ID="BootstrapDateEdit1" ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="newPolicyForm" runat="server" NullText="เลือกวันที่..." EditFormatString="dd/MM/yyyy">
                                </dx:BootstrapDateEdit>
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
