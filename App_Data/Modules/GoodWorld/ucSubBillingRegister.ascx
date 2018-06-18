<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ucSubBillingRegister.ascx.vb" Inherits="Modules_ucSubBillingRegister" %>
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

            <asp:SqlDataSource ID="SqlDataSource_SubAgent" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                SelectCommand="SELECT distinct AgentCode,AgentName FROM v_Report1 where AgentCode is not null"></asp:SqlDataSource>

            <dx:ASPxComboBox ID="SubAgentFilter" ClientInstanceName="SubAgentFilter"
                runat="server" Caption="รหัสตัวแทน"
                DataSourceID="SqlDataSource_SubAgent"
                ValueType="System.String"
                ValueField="AgentCode"
                TextFormatString="{0}"
                Width="250px"
                DropDownStyle="DropDownList">

                <Columns>
                    <dx:ListBoxColumn FieldName="AgentCode" Caption="รหัส" Width="100" />
                    <dx:ListBoxColumn FieldName="AgentName" Caption="SubAgentName" Width="250" />
                </Columns>

            </dx:ASPxComboBox>
        </td>
        <td>&nbsp;
        </td>
        <td>
            <dx:BootstrapDateEdit runat="server" ID="SubBillingDate" Caption="วันที่วางบิลSub" ClientInstanceName="SubBillingDate"></dx:BootstrapDateEdit>


        </td>
        <td>&nbsp;
        </td>
        <td>

            <dx:ASPxButton ID="AddSubBilling" AutoPostBack="false"
                runat="server" Border-BorderWidth="0" CausesValidation="false"
                Image-IconID="actions_download_16x16office2013"
                Text="Add">
                <ClientSideEvents Click="function(s,e){
                                                    var code = SubAgentFilter.GetValue();
                                                    var billingdate = SubBillingDate.GetValue();
                                                    if(code==null || billingdate==null)
                                                    {
                                                        alert('กรุณาเลือก รหัสตัวแทน และวันที่วางบิล');
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



<dx:BootstrapGridView ID="TaskGrid" runat="server"
    ClientInstanceName="taskGrid"
    AutoGenerateColumns="False" CssClasses-HeaderRow="removeWrapping" CssClasses-Row="removeWrapping"
    KeyFieldName="ID" SettingsBehavior-ConfirmDelete="true"
    SettingsBehavior-AllowDragDrop="true"
    SettingsPopup-EditForm-AllowResize="true"
    DataSourceID="SqlDataSource_SubBillingRegister"
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
        <dx:BootstrapGridViewDataColumn Width="50">
            <DataItemTemplate>
                <dx:BootstrapButton runat="server" ID="EditButton" Text="เพิ่มรายการ" Width="50" AutoPostBack="false" CssClasses-Icon="image fa fa-plus-square-o" UseSubmitBehavior="False">
                    <ClientSideEvents Click="function(s,e){
                                TaskEditPopup.PerformCallback('edit|' + s.cpID);
                                 TaskEditPopup.Show();
                            }" />
                    <SettingsBootstrap RenderOption="Link" />
                </dx:BootstrapButton>
            </DataItemTemplate>
        </dx:BootstrapGridViewDataColumn>
        <dx:BootstrapGridViewTextColumn FieldName="AgentCode" Caption="รหัสตัวแทน" Width="50" ReadOnly="true" />
        <dx:BootstrapGridViewTextColumn FieldName="AgentName" Caption="ชื่อตัวแทน" Width="200" ReadOnly="true" />
        <dx:BootstrapGridViewTextColumn FieldName="CommissionAmount" Caption="ค่าคอม" Width="50" ReadOnly="true" PropertiesTextEdit-DisplayFormatString="{0:N2}" />
        <dx:BootstrapGridViewDateColumn FieldName="BillingDate" Caption="วันที่วางบิล" Width="100" PropertiesDateEdit-ValidationSettings-RequiredField-IsRequired="true" PropertiesDateEdit-DisplayFormatString="dd/MM/yyyy" />




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

<asp:SqlDataSource ID="SqlDataSource_SubBillingRegister" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
    SelectCommand="select * from v_SubBillingRegister Order By CreateDate desc"
    DeleteCommand="delete from tblSubBillingRegister where ID=@ID;
    delete from tblSubBillingPremium where SubBillingID=@ID;
    delete from tblSubBillingPolicy where SubBillingID=@ID;">

    <DeleteParameters>
        <asp:Parameter Name="ID" />
    </DeleteParameters>


</asp:SqlDataSource>



<asp:SqlDataSource ID="SqlDataSource_SubBillingDetails" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
    SelectCommand="select * from v_SubBillingDetails where SubBillingID=@SubBillingID"
    DeleteCommand="delete from tblSubBillingPolicy where ID=@ID">

    <SelectParameters>
        <asp:SessionParameter Name="SubBillingID" SessionField="SubBillingID" />
    </SelectParameters>

    <DeleteParameters>
        <asp:Parameter Name="ID" />
    </DeleteParameters>

</asp:SqlDataSource>

<asp:SqlDataSource ID="SqlDataSource_SubBillingPremium" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
    SelectCommand="select * from tblSubBillingPremium  where SubBillingID=@SubBillingID"
    InsertCommand="insert into tblSubBillingPremium(SubBillingID,SubBillingTitle,SubBillingPremium) values(@SubBillingID,@SubBillingTitle,@SubBillingPremium)"
    DeleteCommand="delete from tblSubBillingPremium where ID=@ID"
    UpdateCommand="update tblSubBillingPremium set SubBillingTitle=@SubBillingTitle,SubBillingPremium=@SubBillingPremium where ID=@ID">
    <SelectParameters>
        <asp:SessionParameter Name="SubBillingID" SessionField="SubBillingID" />
    </SelectParameters>
    <InsertParameters>
        <asp:SessionParameter Name="SubBillingID" SessionField="SubBillingID" />
        <asp:Parameter Name="SubBillingTitle" />
        <asp:Parameter Name="SubBillingPremium" />
    </InsertParameters>
    <DeleteParameters>
        <asp:Parameter Name="ID" />
    </DeleteParameters>
    <UpdateParameters>
        <asp:Parameter Name="ID" />
        <asp:Parameter Name="SubBillingTitle" />
        <asp:Parameter Name="SubBillingPremium" />
    </UpdateParameters>
</asp:SqlDataSource>








<dx:ASPxPopupControl ID="TaskEditPopup" ClientInstanceName="TaskEditPopup" runat="server" ScrollBars="Auto"
    ShowHeader="true" CloseOnEscape="false" CloseAction="CloseButton" HeaderText="ใบเสร็จรับเงิน"
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
                //MyGridDetails.Refresh();
                ASPxClientEdit.ValidateEditorsInContainer(TaskEditPopup.GetMainElement());
            }
            else if(s.cpedittask=='cpaddtask' )
            {
                //MyGridDetails.Refresh();
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
                    <dx:LayoutGroup GroupBoxDecoration="Box" ShowCaption="False" ColCount="3">
                        <Items>
                            <dx:LayoutItem Caption="รหัสตัวแทน" FieldName="AgentCode">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer1" runat="server">

                                        <dx:ASPxLabel ID="editAgentCode" Wrap="False" AllowEllipsisInText="true" runat="server"></dx:ASPxLabel>

                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption="ชื่อตัวแทน" FieldName="AgentName">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer2" runat="server">

                                        <dx:ASPxLabel ID="editAgentName" Wrap="False" AllowEllipsisInText="true" runat="server"></dx:ASPxLabel>

                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption="วันที่วางบิล" FieldName="BillingDate">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer12" runat="server">

                                        <dx:ASPxLabel ID="editBillingDate" Wrap="False" AllowEllipsisInText="true" runat="server"></dx:ASPxLabel>

                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>





                            <dx:LayoutItem Caption="รายละเอียด" VerticalAlign="Top" ColSpan="3">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer7" runat="server">

                                        <table>
                                            <tr>
                                                <td>

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

                                                </td>
                                                <td>&nbsp;
                                                </td>
                                                <td>

                                                    <dx:ASPxSpinEdit runat="server" ID="newCommission" ClientInstanceName="newCommission"
                                                        DisplayFormatString="N2" AllowMouseWheel="false" NullText="0.00"
                                                        SpinButtons-Enabled="false" SpinButtons-ClientVisible="false">
                                                    </dx:ASPxSpinEdit>

                                                </td>
                                                <td>&nbsp;
                                                </td>
                                                <td>
                                                    <dx:ASPxButton ID="AddPolicyNo" AutoPostBack="false"
                                                        runat="server" Border-BorderWidth="0" 
                                                        Image-IconID="actions_download_16x16office2013"
                                                        Text="Add">
                                                    <ClientSideEvents Click="function(s,e){
                                                            var policyno = PolicyNoFilter.GetValue();
                                                            var commission = newCommission.GetValue();
                                                            if(policyno==null || commission==null)
                                                            {
                                                                alert('กรุณาระบุ กรมธรรม์และค่าคอม');
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





                                        <dx:ASPxGridView ID="grid_SubBillingDetails" runat="server" DataSourceID="SqlDataSource_SubBillingDetails"  
                                            KeyFieldName="ID" Width="50%" EnableRowsCache="False" SettingsBehavior-ConfirmDelete="true">
                                            <SettingsEditing EditFormColumnCount="1"></SettingsEditing>

                                            <Columns>
                                                <dx:GridViewCommandColumn Width="50" ShowEditButton="true" ShowDeleteButton="true"></dx:GridViewCommandColumn>
                                            
                                                <dx:GridViewDataTextColumn FieldName="ClientName" Caption="ชื่อผู้เอาประกัน" EditFormSettings-Visible="False" CellStyle-Wrap="False" ></dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn FieldName="CarLicensePlate" Caption="เลขทะเบียน" EditFormSettings-Visible="False" CellStyle-Wrap="False"></dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn FieldName="PolicyNo" Caption="เบอร์กรมธรรม์" EditFormSettings-Visible="False" CellStyle-Wrap="False"></dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn FieldName="EffectiveDate" Caption="วันเริ่มคุ้มครอง" PropertiesTextEdit-DisplayFormatString="{0:dd/MM/yyyy}" EditFormSettings-Visible="False" CellStyle-Wrap="False"></dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn FieldName="Premium" Caption="เบี้ยสุทธิ" PropertiesTextEdit-DisplayFormatString="{0:N2}" EditFormSettings-Visible="False" CellStyle-Wrap="False"></dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn FieldName="GrossPremium" Caption="เบี้ยรวม"  PropertiesTextEdit-DisplayFormatString="{0:N2}" EditFormSettings-Visible="False" CellStyle-Wrap="False"></dx:GridViewDataTextColumn>
                                                <dx:GridViewDataSpinEditColumn FieldName="Commission" Caption="% Com" PropertiesSpinEdit-Width="100" PropertiesSpinEdit-ValidationSettings-RequiredField-IsRequired="true" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}" PropertiesSpinEdit-DisplayFormatInEditMode="true"></dx:GridViewDataSpinEditColumn>
                                                <dx:GridViewDataTextColumn FieldName="CommissionAmount" Caption="ค่าคอม" PropertiesTextEdit-DisplayFormatString="{0:N2}" EditFormSettings-Visible="False" CellStyle-Wrap="False"></dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn FieldName="BillingAmount" Caption="จ่ายเบี้ยสุทธิ" PropertiesTextEdit-DisplayFormatString="{0:N2}" EditFormSettings-Visible="False" CellStyle-Wrap="False"></dx:GridViewDataTextColumn>

                                               

                                            </Columns>

                                        </dx:ASPxGridView>



                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>

                            <dx:LayoutItem Caption="จำนวนเงิน" ColSpan="3">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer14" runat="server">

                                        <dx:ASPxGridView ID="grid_SubBillingPremium" runat="server" DataSourceID="SqlDataSource_SubBillingPremium" 
                                            Settings-ShowFooter="true"
                                            KeyFieldName="ID" Width="80%" EnableRowsCache="False" SettingsBehavior-ConfirmDelete="true">
                                            <SettingsEditing EditFormColumnCount="1"></SettingsEditing>
                                            <Columns>

                                                <dx:GridViewCommandColumn Width="50" ShowEditButton="true" ShowNewButtonInHeader="true" ShowDeleteButton="true"></dx:GridViewCommandColumn>

                                                <dx:GridViewDataTextColumn FieldName="SubBillingTitle" Width="80%" Caption="รายการ" CellStyle-Wrap="False">
                                                    <PropertiesTextEdit ValidationSettings-RequiredField-IsRequired="true"></PropertiesTextEdit>
                                                </dx:GridViewDataTextColumn>

                                                <dx:GridViewDataSpinEditColumn FieldName="SubBillingPremium" Width="20%" Caption="จำนวนเงิน" CellStyle-Wrap="False">
                                                    <PropertiesSpinEdit AllowMouseWheel="false"
                                                        SpinButtons-ClientVisible="false"
                                                        ValidationSettings-RequiredField-IsRequired="true"
                                                        DisplayFormatInEditMode="true" DisplayFormatString="N2">
                                                    </PropertiesSpinEdit>
                                                </dx:GridViewDataSpinEditColumn>
                                            </Columns>
                                            <TotalSummary>
                                                <dx:ASPxSummaryItem FieldName="SubBillingPremium" SummaryType="Sum" DisplayFormat="n2" />
                                            </TotalSummary>
                                            <GroupSummary>
                                                <dx:ASPxSummaryItem FieldName="SubBillingPremium" SummaryType="Sum" DisplayFormat="n2" />
                                            </GroupSummary>
                                        </dx:ASPxGridView>


                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>


                            <dx:LayoutItem Caption=" " ColSpan="3">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer15" runat="server">

                                        <dx:ASPxButton ID="btnPreview" runat="server" RenderMode="Button" OnClick="btnPreview_Click"
                                            Width="90px" Text="Preview" CausesValidation="false">
                                            <Image IconID="print_preview_16x16office2013"></Image>

                                        </dx:ASPxButton>
                                        <dx:ASPxButton ID="btnClose" runat="server" RenderMode="Button"
                                            Width="90px" Text="Close" AutoPostBack="false" CausesValidation="false">
                                            <Image IconID="actions_close_16x16office2013"></Image>
                                            <ClientSideEvents Click="function(s, e) {   TaskEditPopup.Hide();    }" />
                                        </dx:ASPxButton>
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


<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"></asp:SqlDataSource>



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
            <dx:ASPxSpreadsheet ID="Spreadsheet" Width="100%"  ReadOnly="true"
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
                    </dx:BootstrapButton>

 

       <%--     <GleamTech:DocumentViewerControl ID="documentViewer" runat="server" AllowedPermissions="All" Height="100%">
            </GleamTech:DocumentViewerControl>--%>

            <%--        <rsweb:ReportViewer ID="ReportViewer1" runat="server" AsyncRendering="false" ProcessingMode="Local" Visible="false">
                <LocalReport ReportPath="~/App_Data/reports/" >
                    
                </LocalReport>
            </rsweb:ReportViewer>--%>
        </dx:PopupControlContentControl>
    </ContentCollection>
</dx:ASPxPopupControl>



