<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ucBillingRegister.ascx.vb" Inherits="Modules_ucBillingRegister" %>

<style>
    .saveBt {
        margin-right: 10px;
    }
</style>

<fieldset>
    <legend class="text-primary"><%=PageName %></legend>
</fieldset>
<dx:BootstrapGridView ID="TaskGrid" runat="server"
    ClientInstanceName="taskGrid" OnInitNewRow="TaskGrid_InitNewRow"
    AutoGenerateColumns="False"
    KeyFieldName="ID" SettingsBehavior-ConfirmDelete="true"
    SettingsBehavior-AllowDragDrop="true"
    SettingsPopup-EditForm-AllowResize="true"
    DataSourceID="SqlDataSource_BillingRegister"
    Width="100%"
    PopupAnimationType="Fade" CloseOnEscape="true" CloseAction="None">
    <CssClasses Control="tasks-grid" PreviewRow="text-muted" />

    <Toolbars>
        <dx:BootstrapGridViewToolbar>
            <Items>
                <dx:BootstrapGridViewToolbarItem Command="New" BeginGroup="true" />
                   <dx:BootstrapGridViewToolbarItem Command="Edit" BeginGroup="true" />
                <dx:BootstrapGridViewToolbarItem Command="Refresh" BeginGroup="true" />
                <dx:BootstrapGridViewToolbarItem Command="ClearSorting" BeginGroup="true"/>
                <dx:BootstrapGridViewToolbarItem Command="ShowSearchPanel" BeginGroup="true" />
            </Items>
        </dx:BootstrapGridViewToolbar>
    </Toolbars>
    <Columns>
        <dx:BootstrapGridViewDataColumn Width="50">
            <DataItemTemplate>
                <dx:BootstrapButton runat="server" ID="EditButton" Text="เพิ่มรายการ" AutoPostBack="false" CssClasses-Icon="image fa fa-plus-square-o" UseSubmitBehavior="False">
                    <ClientSideEvents Click="function(s,e){
                                TaskEditPopup.PerformCallback('edit|' + s.cpID);
                                 TaskEditPopup.Show();
                            }" />
                    <SettingsBootstrap RenderOption="Link" />
                </dx:BootstrapButton>
            </DataItemTemplate>
        </dx:BootstrapGridViewDataColumn>

        <dx:BootstrapGridViewTextColumn FieldName="BillingNo" Caption="เลขที่" Settings-AllowFilterBySearchPanel="True" PropertiesTextEdit-ValidationSettings-RequiredField-IsRequired="true"></dx:BootstrapGridViewTextColumn>

        <dx:BootstrapGridViewTextColumn FieldName="BillingName" Caption="ออกในนาม" Settings-AllowFilterBySearchPanel="True" PropertiesTextEdit-ValidationSettings-RequiredField-IsRequired="true"></dx:BootstrapGridViewTextColumn>

        <dx:BootstrapGridViewComboBoxColumn FieldName="BillingType" Caption="ประเภท" PropertiesComboBox-ValidationSettings-RequiredField-IsRequired="true">
            <PropertiesComboBox>
                <Items>
                    <dx:BootstrapListEditItem Text="บุคลธรรมดา" Value="P"></dx:BootstrapListEditItem>
                    <dx:BootstrapListEditItem Text="นิติบุคล" Value="C"></dx:BootstrapListEditItem>
                </Items>
            </PropertiesComboBox>

        </dx:BootstrapGridViewComboBoxColumn>

        <dx:BootstrapGridViewTextColumn FieldName="TaxID" Caption="เลขประจำตัวผู้เสียภาษี" Settings-AllowFilterBySearchPanel="True" ></dx:BootstrapGridViewTextColumn>

        <dx:BootstrapGridViewSpinEditColumn FieldName="TaxP" Caption="หักภาษี(%)" PropertiesSpinEdit-ValidationSettings-RequiredField-IsRequired="true">
            <PropertiesSpinEdit DisplayFormatString="N2" AllowMouseWheel="false" NullText="0.00"
                SpinButtons-Enabled="false" SpinButtons-ClientVisible="false">
            </PropertiesSpinEdit>
        </dx:BootstrapGridViewSpinEditColumn>

        <dx:BootstrapGridViewSpinEditColumn FieldName="DiscountP" Caption="หักส่วนลด(%)" PropertiesSpinEdit-ValidationSettings-RequiredField-IsRequired="true">
            <PropertiesSpinEdit DisplayFormatString="N2" AllowMouseWheel="false" NullText="0.00"
                SpinButtons-Enabled="false" SpinButtons-ClientVisible="false">
            </PropertiesSpinEdit>
        </dx:BootstrapGridViewSpinEditColumn>


        <dx:BootstrapGridViewDateColumn FieldName="CreateDate" Caption="วันที่่บันทึก" PropertiesDateEdit-DisplayFormatString="dd/MM/yyyy HH:mm:ss" SettingsEditForm-Visible="False" />


        <dx:BootstrapGridViewTextColumn FieldName="CreateBy" Caption="ผู้บันทึก">
            <SettingsEditForm Visible="False" />
        </dx:BootstrapGridViewTextColumn>

        <dx:BootstrapGridViewTextColumn FieldName="ModifyDate" Caption="วันที่แก้ไข">
            <SettingsEditForm Visible="False" />
        </dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="ModifyBy" Caption="ผู้แก้ไข">
            <SettingsEditForm Visible="False" />
        </dx:BootstrapGridViewTextColumn>


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

</dx:BootstrapGridView>

<asp:SqlDataSource ID="SqlDataSource_BillingRegister" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
    SelectCommand="select * from tblBillingRegister Order By CreateDate desc"
    InsertCommand="insert into tblBillingRegister(BillingNo,BillingName,BillingType,TaxID,TaxP,DiscountP,CreateDate,CreateBy)
    Values(@BillingNo,@BillingName,@BillingType,@TaxID,@TaxP,@DiscountP,getdate(),@UserName)
    "
    UpdateCommand="
    update tblBillingRegister
    set
    BillingNo=@BillingNo
    ,BillingName=@BillingName
    ,BillingType=@BillingType
    ,TaxID=@TaxID
    ,TaxP=@TaxP
    ,DiscountP=@DiscountP
    ,ModifyDate=getdate()
    ,ModifyBy=@UserName

    where ID=@ID
    "
    >
    <InsertParameters>
        <asp:Parameter Name="BillingNo" />
        <asp:Parameter Name="BillingName" />
        <asp:Parameter Name="BillingType" />
        <asp:Parameter Name="TaxID" />
        <asp:Parameter Name="TaxP" />
        <asp:Parameter Name="DiscountP" />
        <asp:Parameter Name="UserName" />
    </InsertParameters>
    <UpdateParameters>
        <asp:Parameter Name="BillingNo" />
        <asp:Parameter Name="BillingName" />
        <asp:Parameter Name="BillingType" />
        <asp:Parameter Name="TaxID" />
        <asp:Parameter Name="TaxP" />
        <asp:Parameter Name="DiscountP" />
        <asp:Parameter Name="UserName" />
        <asp:Parameter Name="ID" />
    </UpdateParameters>

</asp:SqlDataSource>






<asp:SqlDataSource ID="SqlDataSource_Insurer" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
    SelectCommand="select InsurerCode,  InsurerName + ' (' + InsurerCode + ')' as InsurerName  from tblInsurer 
    where InsurerCode in (SELECT distinct InsurerCode FROM tblPolicyRegister where [InsurerCode] is not null)
    
    "></asp:SqlDataSource>

<asp:SqlDataSource ID="SqlDataSource_InsureType" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
    SelectCommand="select ID, Name from tblInsureType Order by OrderNo "></asp:SqlDataSource>


<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"></asp:SqlDataSource>

<asp:SqlDataSource ID="SqlDataSource_SubBroker" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
    SelectCommand="select AgentCode,  AgentName + ' (' + AgentCode + ')' as AgentName  from tblSubBroker "></asp:SqlDataSource>


<dx:ASPxPopupControl ID="TaskEditPopup" ClientInstanceName="TaskEditPopup" runat="server"
    ShowHeader="true" CloseOnEscape="false" CloseAction="CloseButton" HeaderText="ใบวางบิล"
    Modal="true" Maximized="true"
    PopupAnimationType="Fade">


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

            if(s.cpedittask=='edit' )
            {
                MyGridDetails.Refresh();
                ASPxClientEdit.ValidateEditorsInContainer(TaskEditPopup.GetMainElement());
            }
            else if(s.cpedittask=='cpaddtask' )
            {
                MyGridDetails.Refresh();
            }
            else if(s.cpedittask=='No Data' )
            {
                alert(s.cpedittask);
            }
            else
            {
                alert(s.cpedittask);
            }

        }" />


    <ContentCollection>
        <dx:PopupControlContentControl ID="PopupControlContentControl5" runat="server">
            <dx:ASPxHiddenField runat="server" ID="hdID"></dx:ASPxHiddenField>
            <dx:ASPxFormLayout ID="formPreview" Styles-LayoutGroupBox-Caption-ForeColor="#0000ff"
                SettingsItems-VerticalAlign="Top"
                runat="server"
                Width="100%"
                AlignItemCaptionsInAllGroups="True">
                <Styles>
                    <LayoutItem Caption-Font-Bold="true"></LayoutItem>
                </Styles>
                <Items>
                    <dx:LayoutGroup GroupBoxDecoration="Box" ShowCaption="False" ColCount="2">
                        <Items>
                            <dx:LayoutItem Caption="เลขที่" FieldName="BillingNo">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer1" runat="server">

                                        <dx:ASPxLabel ID="ASPxLabel1" Wrap="False" AllowEllipsisInText="true" runat="server"></dx:ASPxLabel>

                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>

                            <dx:LayoutItem Caption="ออกในนาม" FieldName="BillingName">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer2" runat="server">

                                        <dx:ASPxLabel ID="ASPxLabel2" Wrap="False" AllowEllipsisInText="true" runat="server"></dx:ASPxLabel>

                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>

                            <dx:LayoutItem Caption="ประเภท" FieldName="BillingType">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer3" runat="server">

                                        <dx:ASPxLabel ID="ASPxLabel3" Wrap="False" AllowEllipsisInText="true" runat="server"></dx:ASPxLabel>

                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption="หักภาษี" FieldName="TaxP">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer4" runat="server">

                                        <dx:ASPxLabel ID="ASPxLabel4" Wrap="False" AllowEllipsisInText="true" runat="server"></dx:ASPxLabel>

                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>

                            <dx:LayoutItem Caption="หักส่วนลด" FieldName="DiscountP">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer5" runat="server">

                                        <dx:ASPxLabel ID="ASPxLabel5" Wrap="False" AllowEllipsisInText="true" runat="server"></dx:ASPxLabel>

                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>


                            <dx:LayoutItem ShowCaption="False" ColSpan="2">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer7" runat="server">
                                        <dx:ASPxComboBox ID="PolicyNoFilter" ClientInstanceName="PolicyNoFilter"
                                            runat="server" Caption="ค้นหาเลขกรมธรรม์"
                                            EnableCallbackMode="true"
                                            CallbackPageSize="10"
                                            ValueType="System.String"
                                            ValueField="ID"
                                            TextFormatString="{1}"
                                            Width="250px"
                                            DropDownStyle="DropDown">

                                            <Columns>
                                                <dx:ListBoxColumn FieldName="ID" Width="50" />
                                                <dx:ListBoxColumn FieldName="PolicyNo" Width="200" />
                                                <dx:ListBoxColumn FieldName="ClientName" Width="250" />
                                                <dx:ListBoxColumn FieldName="EffectiveDate" Width="100">
                                                    <CellTemplate>
                                                        <%# Eval("EffectiveDate", "{0:dd/MM/yyyy}") %>
                                                    </CellTemplate>
                                                </dx:ListBoxColumn>
                                                <dx:ListBoxColumn FieldName="ExpiredDate" Width="100">
                                                    <CellTemplate>
                                                        <%# Eval("ExpiredDate", "{0:dd/MM/yyyy}") %>
                                                    </CellTemplate>
                                                </dx:ListBoxColumn>
                                                <dx:ListBoxColumn FieldName="InsurerCode" Width="100" />
                                                <dx:ListBoxColumn FieldName="InsureTypeCode" Width="100" />
                                                <dx:ListBoxColumn FieldName="CustomerType" Width="100" />
                                                <dx:ListBoxColumn FieldName="Suminsured" Width="100">
                                                    <CellTemplate>
                                                        <%# Eval("Suminsured", "{0:N0}") %>
                                                    </CellTemplate>
                                                </dx:ListBoxColumn>
                                                <dx:ListBoxColumn FieldName="GrossPremium" Width="100">
                                                    <CellTemplate>
                                                        <%# Eval("GrossPremium", "{0:N2}") %>
                                                    </CellTemplate>
                                                </dx:ListBoxColumn>
                                            </Columns>

                                        </dx:ASPxComboBox>
                                        <dx:ASPxButton ID="AddPolicyNo" AutoPostBack="false"
                                            runat="server" Border-BorderWidth="0"
                                            Image-IconID="actions_download_16x16office2013"
                                            Text="Add">
                                            <ClientSideEvents Click="function(s,e){
                                                
                                                var polno = PolicyNoFilter.GetValue();
                                                TaskEditPopup.PerformCallback('addpolicy|' + polno);
                                                
                                                }" />

                                        </dx:ASPxButton>


                                        <dx:ASPxGridView runat="server"
                                            ID="MyGridDetails"
                                            SettingsLoadingPanel-Mode="ShowAsPopup"
                                            ClientInstanceName="MyGridDetails"
                                            Width="100%"
                                            KeyFieldName="ID"
                                            SettingsBehavior-ConfirmDelete="true"
                                            DataSourceID="SqlDataSource_BilingDetails"
                                            SettingsBehavior-AllowEllipsisInText="true"
                                            Settings-HorizontalScrollBarMode="Visible">
                                            <SettingsPager Mode="ShowAllRecords"></SettingsPager>
                                            <Styles>
                                                <Header Font-Bold="true" Font-Underline="true" HorizontalAlign="Center"></Header>
                                                <Footer Font-Bold="true" Font-Underline="true" HorizontalAlign="Center"></Footer>
                                            </Styles>


                                            <Settings ShowFooter="True" />
                                            <SettingsBehavior AllowDragDrop="True" AllowFocusedRow="true" ColumnResizeMode="Control" />
                                            <SettingsSearchPanel CustomEditorID="tbToolbarSearch1" />
                                            <SettingsExport EnableClientSideExportAPI="true" ExcelExportMode="WYSIWYG" />

                                            <Toolbars>
                                                <dx:GridViewToolbar ItemAlign="Left">
                                                    <Items>

                                                        <dx:GridViewToolbarItem Command="Delete" BeginGroup="true" />
                                                        <dx:GridViewToolbarItem Command="ExportToXlsx" BeginGroup="true" />
                                                        <dx:GridViewToolbarItem Command="Refresh" BeginGroup="true" />

                                                        <dx:GridViewToolbarItem BeginGroup="true">
                                                            <Template>
                                                                <dx:ASPxButton ID="btnPreview" runat="server" RenderMode="Button" OnClick="btnPreview_Click"
                                                                    Width="90px" Text="Preview" CausesValidation="false">
                                                                    <Image IconID="print_preview_16x16office2013"></Image>

                                                                </dx:ASPxButton>
                                                            </Template>
                                                        </dx:GridViewToolbarItem>

                                                        <dx:GridViewToolbarItem BeginGroup="true">
                                                            <Template>
                                                                <dx:ASPxButton ID="btnClose" runat="server" RenderMode="Button"
                                                                    Width="90px" Text="Close" AutoPostBack="false" CausesValidation="false">
                                                                    <Image IconID="actions_close_16x16office2013"></Image>
                                                                    <ClientSideEvents Click="function(s, e) {   TaskEditPopup.Hide();    }" />
                                                                </dx:ASPxButton>
                                                            </Template>
                                                        </dx:GridViewToolbarItem>

                                                    </Items>
                                                </dx:GridViewToolbar>
                                            </Toolbars>




                                            <Columns>

                                                <dx:GridViewDataTextColumn FieldName="InsurerName" Caption="บริษัทประกันภัย" Width="200">
                                                    <EditFormSettings Visible="False" />
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn FieldName="ClientName" Caption="ชื่อ" Width="200">
                                                    <EditFormSettings Visible="False" />
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn FieldName="CarLicensePlate" Caption="เลขทะเบียนรถ" Width="200">
                                                    <EditFormSettings Visible="False" />
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn FieldName="PolicyNo" Caption="เลขที่" Width="200">
                                                    <EditFormSettings Visible="False" />
                                                </dx:GridViewDataTextColumn>




                                                <dx:GridViewDataTextColumn FieldName="EffectiveDate" Caption="วันเริ่มต้น" Width="100">
                                                    <EditFormSettings Visible="False" />
                                                    <PropertiesTextEdit DisplayFormatString="dd/MM/yyyy"></PropertiesTextEdit>
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn FieldName="ExpiredDate" Caption="วันสิ้นสุด" Width="100">
                                                    <EditFormSettings Visible="False" />
                                                    <PropertiesTextEdit DisplayFormatString="dd/MM/yyyy"></PropertiesTextEdit>
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn FieldName="InsureType" Caption="ประเภท" Width="100">
                                                    <EditFormSettings Visible="False" />
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn FieldName="Suminsured" Caption="ทุน" Width="100">
                                                    <EditFormSettings Visible="False" />
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn FieldName="Premium" Caption="เบี้ยประกันภัย" Width="100">
                                                    <EditFormSettings Visible="False" />
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn FieldName="Stamp" Caption="อากร" Width="100">
                                                    <EditFormSettings Visible="False" />
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn FieldName="Vat" Caption="ภาษี" Width="100">
                                                    <EditFormSettings Visible="False" />
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn FieldName="GrossPremium" Caption="เบี้ยรวม" Width="100">
                                                    <EditFormSettings Visible="False" />
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn FieldName="AgentName" Caption="SUB." Width="100">
                                                    <EditFormSettings Visible="False" />
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn FieldName="Brokerage" Caption="% คอม" Width="100">
                                                    <EditFormSettings Visible="False" />
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn FieldName="BrokerageAmt" Caption="J/O" Width="100">
                                                    <EditFormSettings Visible="False" />
                                                </dx:GridViewDataTextColumn>

                                                <%--   <dx:GridViewDataTextColumn Caption="จ่าย บ.ประกัน" Settings-AllowFilterBySearchPanel="True"></dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn Caption="รับชำระเบี้ย" Settings-AllowFilterBySearchPanel="True"></dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn Caption="ชำระค่าคอม" Settings-AllowFilterBySearchPanel="True"></dx:GridViewDataTextColumn>--%>

                                                <dx:GridViewDataTextColumn FieldName="CreateDate" Width="100">
                                                    <PropertiesTextEdit DisplayFormatString="dd/MM/yyyy"></PropertiesTextEdit>
                                                    <EditFormSettings Visible="False" />
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn FieldName="CreateBy" Width="100">
                                                    <EditFormSettings Visible="False" />
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn FieldName="ModifyDate" Width="100">
                                                    <PropertiesTextEdit DisplayFormatString="dd/MM/yyyy"></PropertiesTextEdit>
                                                    <EditFormSettings Visible="False" />
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn FieldName="ModifyBy" Width="100">
                                                    <EditFormSettings Visible="False" />
                                                </dx:GridViewDataTextColumn>

                                            </Columns>
                                            <TotalSummary>

                                                <dx:ASPxSummaryItem FieldName="Suminsured" SummaryType="Sum" DisplayFormat="{0:N0}" />
                                                <dx:ASPxSummaryItem FieldName="Premium" SummaryType="Sum" DisplayFormat="{0:N2}" />
                                                <dx:ASPxSummaryItem FieldName="Stamp" SummaryType="Sum" DisplayFormat="{0:N2}" />
                                                <dx:ASPxSummaryItem FieldName="Vat" SummaryType="Sum" DisplayFormat="{0:N2}" />
                                                <dx:ASPxSummaryItem FieldName="GrossPremium" SummaryType="Sum" DisplayFormat="{0:N2}" />
                                                <dx:ASPxSummaryItem FieldName="BrokerageAmt" SummaryType="Sum" DisplayFormat="{0:N2}" />

                                            </TotalSummary>

                                            <GroupSummary>
                                                <dx:ASPxSummaryItem FieldName="Suminsured" SummaryType="Sum" DisplayFormat="{0:N0}" />
                                                <dx:ASPxSummaryItem FieldName="Premium" SummaryType="Sum" DisplayFormat="{0:N2}" />
                                                <dx:ASPxSummaryItem FieldName="Stamp" SummaryType="Sum" DisplayFormat="{0:N2}" />
                                                <dx:ASPxSummaryItem FieldName="Vat" SummaryType="Sum" DisplayFormat="{0:N2}" />
                                                <dx:ASPxSummaryItem FieldName="GrossPremium" SummaryType="Sum" DisplayFormat="{0:N2}" />
                                                <dx:ASPxSummaryItem FieldName="BrokerageAmt" SummaryType="Sum" DisplayFormat="{0:N2}" />
                                            </GroupSummary>

                                        </dx:ASPxGridView>

                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                        </Items>
                    </dx:LayoutGroup>
                </Items>
            </dx:ASPxFormLayout>

        </dx:PopupControlContentControl>
    </ContentCollection>
</dx:ASPxPopupControl>






<asp:SqlDataSource ID="SqlDataSource_BilingDetails" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
    SelectCommand="select * from v_BillingDetails where BillingID=@BillingID Order By ClientName"
    DeleteCommand="delete from tblBillingDetails where ID=@ID;">
    <DeleteParameters>
        <asp:Parameter Name="ID" />
    </DeleteParameters>
    <SelectParameters>
        <asp:SessionParameter Name="BillingID" SessionField="BillingID" />
    </SelectParameters>

</asp:SqlDataSource>





<%--<asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="false"></asp:ScriptManager>--%>

<dx:ASPxPopupControl ID="clientReportPreview" runat="server" ClientInstanceName="clientReportPreview"
    Modal="True" Maximized="true"
    PopupHorizontalAlign="WindowCenter"
    PopupVerticalAlign="WindowCenter"
    HeaderText="Reports"
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



    <ContentCollection>
        <dx:PopupControlContentControl ID="PopupControlContentControl2" runat="server">

            <%--<dx:ASPxSpreadsheet ID="Spreadsheet" Width="100%"  ReadOnly="true"
                runat="server"
                ActiveTabIndex="0" RibbonMode="None"
                ShowConfirmOnLosingChanges="false"
                ShowFormulaBar="false"
                ShowSheetTabs="false">
            </dx:ASPxSpreadsheet>


             <dx:BootstrapButton ID="btnExport" Text="Download" AutoPostBack="false" CssClasses-Icon="image fa fa-download"  runat="server">
                        <SettingsBootstrap RenderOption="Primary" />
                        <ClientSideEvents Click="function(s,e){

                                  e.processOnServer = true;

                            }" />
                    </dx:BootstrapButton>--%>


            <GleamTech:DocumentViewerControl ID="documentViewer" runat="server" AllowedPermissions="All" Height="100%">
            </GleamTech:DocumentViewerControl>

            <%--        <rsweb:ReportViewer ID="ReportViewer1" runat="server" AsyncRendering="false" ProcessingMode="Local" Visible="false">
                <LocalReport ReportPath="~/App_Data/reports/" >
                    
                </LocalReport>
            </rsweb:ReportViewer>--%>
        </dx:PopupControlContentControl>
    </ContentCollection>
</dx:ASPxPopupControl>


