<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ucReceiptRegister.ascx.vb" Inherits="Modules_ucReceiptRegister" %>

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
                    <dx:ListBoxColumn FieldName="BranchName" Caption="สาขา" Width="100" />
                    <dx:ListBoxColumn FieldName="Address1" Caption="ที่อยู่" Width="100" />
                    <dx:ListBoxColumn FieldName="Address2" Caption="ที่อยู่" Width="100" />
                    <dx:ListBoxColumn FieldName="Address3" Caption="ที่อยู่" Width="100" />
                    <dx:ListBoxColumn FieldName="CertificateNo" Caption="เลขประจำตัวผู้เสียภาษี" Width="200" />
                </Columns>

            </dx:ASPxComboBox>
        </td>
        <td>&nbsp;
        </td>
        <td>

            <dx:ASPxButton ID="AddReceipt" AutoPostBack="false"
                runat="server" Border-BorderWidth="0" CausesValidation="false"
                Image-IconID="actions_download_16x16office2013"
                Text="Add">
                <ClientSideEvents Click="function(s,e){
                                                    var code = InsurerFilter.GetValue();
                                                    if(code==null)
                                                    {
                                                        alert('กรุณาเลือกบริษัทประกันภัย');
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
    DataSourceID="SqlDataSource_ReceiptRegister"
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
                <dx:BootstrapGridViewToolbarItem Command="Edit" BeginGroup="true" />
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
                <dx:BootstrapButton runat="server" ID="EditButton" Text="เพิ่มรายการ" AutoPostBack="false" CssClasses-Icon="image fa fa-plus-square-o" UseSubmitBehavior="False">
                    <ClientSideEvents Click="function(s,e){
                                TaskEditPopup.PerformCallback('edit|' + s.cpID);
                                 TaskEditPopup.Show();
                            }" />
                    <SettingsBootstrap RenderOption="Link" />
                </dx:BootstrapButton>
            </DataItemTemplate>
        </dx:BootstrapGridViewDataColumn>

        <dx:BootstrapGridViewTextColumn FieldName="ReceiptNo" Width="150" Caption="เลขที่ใบเสร็จ" PropertiesTextEdit-ValidationSettings-RequiredField-IsRequired="true" Settings-AllowFilterBySearchPanel="True"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewDateColumn FieldName="ReceiveDate" Caption="วันที่รับเงิน" Width="100" PropertiesDateEdit-ValidationSettings-RequiredField-IsRequired="true" PropertiesDateEdit-DisplayFormatString="dd/MM/yyyy" />

        <dx:BootstrapGridViewTextColumn FieldName="InsurerName" Caption="บริษัทประกันภัย" Width="100" ReadOnly="true" />
        <dx:BootstrapGridViewTextColumn FieldName="Address1" Caption="ที่อยู่ 1" Width="100" />
        <dx:BootstrapGridViewTextColumn FieldName="Address2" Caption="ที่อยู่ 2" Width="100" />
        <dx:BootstrapGridViewTextColumn FieldName="Address3" Caption="ที่อยู่ 3" Width="100" />

        <dx:BootstrapGridViewTextColumn FieldName="TaxNo" Caption="เลขประจำตัวผู้เสียภาษีอากร" Width="100" PropertiesTextEdit-ValidationSettings-RequiredField-IsRequired="true" />


        <dx:BootstrapGridViewComboBoxColumn FieldName="ReceiveType" Caption="ชำระโดย" PropertiesComboBox-ValidationSettings-RequiredField-IsRequired="true">
            <PropertiesComboBox>
                <Items>
                    <dx:BootstrapListEditItem Text="เงินสด" Value="CA"></dx:BootstrapListEditItem>
                    <dx:BootstrapListEditItem Text="เงินโอน" Value="TR"></dx:BootstrapListEditItem>
                    <dx:BootstrapListEditItem Text="เช็ค" Value="CH"></dx:BootstrapListEditItem>
                </Items>
            </PropertiesComboBox>

        </dx:BootstrapGridViewComboBoxColumn>



        <dx:BootstrapGridViewTextColumn FieldName="ChequeNo" Width="100" Caption="เลขเช็ค" Settings-AllowFilterBySearchPanel="True"></dx:BootstrapGridViewTextColumn>

        <dx:BootstrapGridViewTextColumn FieldName="ChequeBranch" Width="100" Caption="สาขา" Settings-AllowFilterBySearchPanel="True"></dx:BootstrapGridViewTextColumn>







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

<asp:SqlDataSource ID="SqlDataSource_ReceiptRegister" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
    SelectCommand="select * from v_ReceiptRegister 
    Order By CreateDate desc"
    
     UpdateCommand="
    UPDATE tblReceiptRegister
   SET ReceiptNo = @ReceiptNo
      ,TaxNo =  @TaxNo
      ,ReceiveType =  @ReceiveType
      ,ReceiveDate =  @ReceiveDate
      ,ChequeNo =  @ChequeNo
      ,ChequeBranch =  @ChequeBranch
      ,Address1 =  @Address1
      ,Address2 = @Address2
      ,Address3 =  @Address3

      ,ModifyDate = getdate()
      ,ModifyBy =  @UserName

     WHERE ID=@ID"
    >

    <UpdateParameters>
        <asp:Parameter Name="ReceiptNo" />
         <asp:Parameter Name="ReceiveDate" />
         <asp:Parameter Name="Address1" />
         <asp:Parameter Name="Address2" />
         <asp:Parameter Name="Address3" />
         <asp:Parameter Name="TaxNo" />
         <asp:Parameter Name="ReceiveType" />
        <asp:Parameter Name="ChequeNo" />
        <asp:Parameter Name="ChequeBranch" />

         <asp:Parameter Name="ID" />
         <asp:Parameter Name="UserName" />
    </UpdateParameters>


</asp:SqlDataSource>



<asp:SqlDataSource ID="SqlDataSource_ReceiptDetails" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
    SelectCommand="select * from tblReceiptDetails where ReceiptID=@ReceiptID"
    InsertCommand="insert into tblReceiptDetails(ReceiptID,ReceiptDetails) values(@ReceiptID,@ReceiptDetails)"
    DeleteCommand="delete from tblReceiptDetails where ID=@ID"
    UpdateCommand="update tblReceiptDetails set ReceiptDetails=@ReceiptDetails where ID=@ID">
    <SelectParameters>
        <asp:SessionParameter Name="ReceiptID" SessionField="ReceiptID" />
    </SelectParameters>
    <InsertParameters>
        <asp:SessionParameter Name="ReceiptID" SessionField="ReceiptID" />
        <asp:Parameter Name="ReceiptDetails" />
    </InsertParameters>
    <DeleteParameters>
        <asp:Parameter Name="ID" />
    </DeleteParameters>
    <UpdateParameters>
        <asp:Parameter Name="ID" />
        <asp:Parameter Name="ReceiptDetails" />
    </UpdateParameters>
</asp:SqlDataSource>

<asp:SqlDataSource ID="SqlDataSource_ReceiptPremium" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
    SelectCommand="select * from tblReceiptPremium  where ReceiptID=@ReceiptID"
    InsertCommand="insert into tblReceiptPremium(ReceiptID,ReceiptTitle,ReceiptPremium) values(@ReceiptID,@ReceiptTitle,@ReceiptPremium)"
    DeleteCommand="delete from tblReceiptPremium where ID=@ID"
    UpdateCommand="update tblReceiptPremium set ReceiptTitle=@ReceiptTitle,ReceiptPremium=@ReceiptPremium where ID=@ID">
    <SelectParameters>
        <asp:SessionParameter Name="ReceiptID" SessionField="ReceiptID" />
    </SelectParameters>
    <InsertParameters>
        <asp:SessionParameter Name="ReceiptID" SessionField="ReceiptID" />
        <asp:Parameter Name="ReceiptTitle" />
        <asp:Parameter Name="ReceiptPremium" />
    </InsertParameters>
    <DeleteParameters>
        <asp:Parameter Name="ID" />
    </DeleteParameters>
    <UpdateParameters>
        <asp:Parameter Name="ID" />
        <asp:Parameter Name="ReceiptTitle" />
        <asp:Parameter Name="ReceiptPremium" />
    </UpdateParameters>
</asp:SqlDataSource>









<dx:BootstrapPopupControl ID="TaskNewPopup" ClientInstanceName="TaskNewPopup" runat="server"
    ShowHeader="false" CloseOnEscape="false" CloseAction="CloseButton" HeaderText="ใบเสร็จรับเงิน"
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
                <legend class="text-primary">ใบเสร็จรับเงิน</legend>
            </fieldset>
            <dx:BootstrapFormLayout ID="newReceipt" ClientInstanceName="newReceipt" runat="server" LayoutType="Horizontal">
                <CssClasses Control="overview-fl" />
                <Items>
                    <dx:BootstrapLayoutItem Caption="เลขที่ใบเสร็จ" ColSpanMd="6">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="newReceiptNo" ValidationSettings-RequiredField-IsRequired="true"></dx:BootstrapTextBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="รหัส" ColSpanMd="6">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="newInsurerCode" ReadOnly="true"></dx:BootstrapTextBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="บริษัทประกันภัย" ColSpanMd="6">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="newInsurerName" ReadOnly="true"></dx:BootstrapTextBox>

                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="ที่อยู่ 1" ColSpanMd="6">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="newAddress1"></dx:BootstrapTextBox>

                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="ที่อยู่ 2" ColSpanMd="6">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="newAddress2"></dx:BootstrapTextBox>

                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="ที่อยู่ 3" ColSpanMd="6">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="newAddress3"></dx:BootstrapTextBox>

                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="เลขประจำตัวผู้เสียภาษี" ColSpanMd="6">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="newTaxNo" ValidationSettings-RequiredField-IsRequired="true"></dx:BootstrapTextBox>

                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="สาขา" ColSpanMd="6">
                        <ContentCollection>
                            <dx:ContentControl>

                                <dx:BootstrapComboBox runat="server" ID="newBranch" ValidationSettings-RequiredField-IsRequired="true">
                                    <ValidationSettings></ValidationSettings>
                                    <Items>
                                        <dx:BootstrapListEditItem Text="สำนักงานใหญ่" Value="HO"></dx:BootstrapListEditItem>
                                        <dx:BootstrapListEditItem Text="สาขา" Value="BR"></dx:BootstrapListEditItem>
                                    </Items>
                                </dx:BootstrapComboBox>


                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="ชำระโดย" ColSpanMd="6">
                        <ContentCollection>
                            <dx:ContentControl>

                                <dx:BootstrapComboBox runat="server" ID="newReceiveType" ValidationSettings-RequiredField-IsRequired="true">
                                    <ValidationSettings></ValidationSettings>
                                    <Items>
                                        <dx:BootstrapListEditItem Text="เงินสด" Value="CA"></dx:BootstrapListEditItem>
                                        <dx:BootstrapListEditItem Text="เงินโอน" Value="TR"></dx:BootstrapListEditItem>
                                        <dx:BootstrapListEditItem Text="เช็ค" Value="CH"></dx:BootstrapListEditItem>
                                    </Items>
                                </dx:BootstrapComboBox>


                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="เช็คเลขที่" ColSpanMd="6">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="newChequeNo"></dx:BootstrapTextBox>

                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="วันที่" ColSpanMd="6">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapDateEdit ID="newReceiveDate"
                                    ValidationSettings-RequiredField-IsRequired="true"
                                    ValidationSettings-ValidationGroup="newReceipt"
                                    runat="server"
                                    NullText="เลือกวันที่..." EditFormatString="dd/MM/yyyy">
                                </dx:BootstrapDateEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="เช็คสาขา" ColSpanMd="6">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="newChequeBranch"></dx:BootstrapTextBox>

                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>













                    <dx:BootstrapLayoutItem ShowCaption="False" ColSpanMd="12" HorizontalAlign="Left">
                        <ContentCollection>
                            <dx:ContentControl ID="ContentControl11" runat="server">
                                <dx:BootstrapButton ID="TaskSaveButton" runat="server" ValidationGroup="newReceipt" AutoPostBack="false" Text="Save" Width="100px">
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



<dx:ASPxPopupControl ID="TaskEditPopup" ClientInstanceName="TaskEditPopup" runat="server"
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
                            <dx:LayoutItem Caption="เลขที่ใบเสร็จ" FieldName="ReceiptNo">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer1" runat="server">

                                        <dx:ASPxLabel ID="editReceiptNo" Wrap="False" AllowEllipsisInText="true" runat="server"></dx:ASPxLabel>

                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>

                            <dx:LayoutItem Caption="รหัส" FieldName="InsurerCode">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer2" runat="server">

                                        <dx:ASPxLabel ID="editInsurerCode" Wrap="False" AllowEllipsisInText="true" runat="server"></dx:ASPxLabel>

                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption="บริษัทประกันภัย" FieldName="InsurerName">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer3" runat="server">

                                        <dx:ASPxLabel ID="editInsurerName" Wrap="False" AllowEllipsisInText="true" runat="server"></dx:ASPxLabel>

                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption="ที่อยู่ 1" FieldName="Address1">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer4" runat="server">

                                        <dx:ASPxLabel ID="editAddress1" Wrap="False" AllowEllipsisInText="true" runat="server"></dx:ASPxLabel>

                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption="ที่อยู่ 2" FieldName="Address2">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer5" runat="server">

                                        <dx:ASPxLabel ID="editAddress2" Wrap="False" AllowEllipsisInText="true" runat="server"></dx:ASPxLabel>

                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption="ที่อยู่ 3" FieldName="Address3">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer6" runat="server">

                                        <dx:ASPxLabel ID="editAddress3" Wrap="False" AllowEllipsisInText="true" runat="server"></dx:ASPxLabel>

                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption="เลขประจำตัวผู้เสียภาษี" FieldName="TaxNo">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer8" runat="server">

                                        <dx:ASPxLabel ID="editTaxNo" Wrap="False" AllowEllipsisInText="true" runat="server"></dx:ASPxLabel>

                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption="สาขา" FieldName="BranchName">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer9" runat="server">

                                        <dx:ASPxLabel ID="editBranchName" Wrap="False" AllowEllipsisInText="true" runat="server"></dx:ASPxLabel>

                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption="ชำระโดย" FieldName="ReceiveType">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer10" runat="server">

                                        <dx:ASPxLabel ID="editReceiveType" Wrap="False" AllowEllipsisInText="true" runat="server"></dx:ASPxLabel>

                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption="เช็คเลขที่" FieldName="ChequeNo">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer11" runat="server">

                                        <dx:ASPxLabel ID="editChequeNo" Wrap="False" AllowEllipsisInText="true" runat="server"></dx:ASPxLabel>

                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>

                            <dx:LayoutItem Caption="วันที่" FieldName="ReceiveDate">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer12" runat="server">

                                        <dx:ASPxLabel ID="editReceiveDate" Wrap="False" AllowEllipsisInText="true" runat="server"></dx:ASPxLabel>

                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption="เช็คสาขา" FieldName="ChequeBranch">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer13" runat="server">

                                        <dx:ASPxLabel ID="editChequeBranch" Wrap="False" AllowEllipsisInText="true" runat="server"></dx:ASPxLabel>

                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>




                            <dx:LayoutItem Caption="รายละเอียด" VerticalAlign="Top" ColSpan="2">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer7" runat="server">

                                        <dx:ASPxGridView ID="grid_ReceiptDetails" runat="server" DataSourceID="SqlDataSource_ReceiptDetails"
                                            KeyFieldName="ID" Width="50%" EnableRowsCache="False" SettingsBehavior-ConfirmDelete="true">
                                            <SettingsEditing EditFormColumnCount="1"></SettingsEditing>
                                            <Columns>
                                                <dx:GridViewCommandColumn Width="50" ShowEditButton="true" ShowNewButtonInHeader="true" ShowDeleteButton="true"></dx:GridViewCommandColumn>
                                                <dx:GridViewDataTextColumn FieldName="ReceiptDetails" Caption="รายการ">
                                                    <PropertiesTextEdit ValidationSettings-RequiredField-IsRequired="true"></PropertiesTextEdit>
                                                </dx:GridViewDataTextColumn>
                                            </Columns>
                                           
                                        </dx:ASPxGridView>



                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>

                            <dx:LayoutItem Caption="จำนวนเงิน" ColSpan="2">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer14" runat="server">

                                        <dx:ASPxGridView ID="grid_ReceiptPremium" runat="server" DataSourceID="SqlDataSource_ReceiptPremium"
                                            Settings-ShowFooter="true" 
                                            KeyFieldName="ID" Width="50%" EnableRowsCache="False" SettingsBehavior-ConfirmDelete="true">
                                            <SettingsEditing EditFormColumnCount="1"></SettingsEditing>
                                            <Columns>
                                                <dx:GridViewCommandColumn Width="50" ShowEditButton="true" ShowNewButtonInHeader="true" ShowDeleteButton="true"></dx:GridViewCommandColumn>
                                                <dx:GridViewDataTextColumn FieldName="ReceiptTitle" Caption="รายการ">
                                                    <PropertiesTextEdit ValidationSettings-RequiredField-IsRequired="true"></PropertiesTextEdit>
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataSpinEditColumn FieldName="ReceiptPremium" Caption="จำนวนเงิน">
                                                    <PropertiesSpinEdit AllowMouseWheel="false"
                                                        SpinButtons-ClientVisible="false"
                                                        ValidationSettings-RequiredField-IsRequired="true"
                                                        DisplayFormatInEditMode="true" DisplayFormatString="N2">
                                                    </PropertiesSpinEdit>
                                                </dx:GridViewDataSpinEditColumn>
                                            </Columns>
                                            <TotalSummary>
                                                 <dx:ASPxSummaryItem FieldName="ReceiptPremium" SummaryType="Sum" DisplayFormat="n2" />
                                            </TotalSummary>
                                             <GroupSummary>
                                                <dx:ASPxSummaryItem FieldName="ReceiptPremium" SummaryType="Sum" DisplayFormat="n2" />
                                            </GroupSummary>
                                        </dx:ASPxGridView>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>


                            <dx:LayoutItem Caption=" " ColSpan="2">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer15" runat="server">

                                        <dx:ASPxButton ID="btnPreview" runat="server" RenderMode="Button"   OnClick="btnPreview_Click"
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
