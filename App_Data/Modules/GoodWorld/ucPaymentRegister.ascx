<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ucPaymentRegister.ascx.vb" Inherits="Modules_ucPaymentRegister" %>
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

            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"></asp:SqlDataSource>

            <dx:ASPxComboBox ID="PolicyNoFilter" ClientInstanceName="PolicyNoFilter"
                runat="server" Caption="ค้นหาเลขกรมธรรม์"
                EnableCallbackMode="true"
                CallbackPageSize="10"
                ValueType="System.String"
                ValueField="PolicyID"
                TextFormatString="{0}"
                Width="250px"
                DropDownStyle="DropDown">

                <Columns>
                    <dx:ListBoxColumn FieldName="PolicyNo" Caption="เลขกรมธรรม์" Width="200" />
                    <dx:ListBoxColumn FieldName="ClientName" Caption="ชื่อผู้เอาประกันภัย" Width="250" />
                    <dx:ListBoxColumn FieldName="CarLicensePlate" Caption="ทะเบียนรถ" Width="100" />

                    <dx:ListBoxColumn FieldName="EffectiveDate" Caption="วันเริ่มคุ้มครอง" Width="100">
                        <CellTemplate>
                            <%# Eval("EffectiveDate", "{0:dd/MM/yyyy}") %>
                        </CellTemplate>
                    </dx:ListBoxColumn>
                    <dx:ListBoxColumn FieldName="Premium" Caption="เบี้ยสุทธิ" Width="100">
                        <CellTemplate>
                            <%# Eval("Suminsured", "{0:N2}") %>
                        </CellTemplate>
                    </dx:ListBoxColumn>
                    <dx:ListBoxColumn FieldName="Stamp" Caption="อากร" Width="100">
                        <CellTemplate>
                            <%# Eval("Suminsured", "{0:N2}") %>
                        </CellTemplate>
                    </dx:ListBoxColumn>
                    <dx:ListBoxColumn FieldName="Vat" Caption="ภาษี" Width="100">
                        <CellTemplate>
                            <%# Eval("Suminsured", "{0:N2}") %>
                        </CellTemplate>
                    </dx:ListBoxColumn>
                    <dx:ListBoxColumn FieldName="GrossPremium" Caption="เบี้ยรวม" Width="100">
                        <CellTemplate>
                            <%# Eval("GrossPremium", "{0:N2}") %>
                        </CellTemplate>
                    </dx:ListBoxColumn>
                    <dx:ListBoxColumn FieldName="Brokerage" Caption="%" Width="100">
                        <CellTemplate>
                            <%# Eval("Suminsured", "{0:N2}") %>
                        </CellTemplate>
                    </dx:ListBoxColumn>
                    <dx:ListBoxColumn FieldName="BrokerageAmt" Caption="ค่าคอม" Width="100">
                        <CellTemplate>
                            <%# Eval("Suminsured", "{0:N2}") %>
                        </CellTemplate>
                    </dx:ListBoxColumn>

                </Columns>

            </dx:ASPxComboBox>
        </td>
        <td>&nbsp;
        </td>
        <td>

            <dx:ASPxButton ID="AddPolicyNo" AutoPostBack="false"
                runat="server" Border-BorderWidth="0"
                Image-IconID="actions_download_16x16office2013"
                Text="Add">
                <ClientSideEvents Click="function(s,e){
                                                    var polid = PolicyNoFilter.GetText();
                                                    if(polid=='')
                                                    {
                                                        alert('กรุณาระบุกรมธรรม์');
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
    DataSourceID="SqlDataSource_PaymentRegister"
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

                <%--     <dx:BootstrapGridViewToolbarItem Command="Custom" Name="NewPolicy" Text="New" IconCssClass="image fa fa-plus">
                </dx:BootstrapGridViewToolbarItem>--%>

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


        <dx:BootstrapGridViewTextColumn FieldName="ClientName" Width="300" Caption="ชื่อผู้เอาประกันภัย" Settings-AllowFilterBySearchPanel="True"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="CarLicensePlate" Width="100" Caption="ทะเบียนรถ" Settings-AllowFilterBySearchPanel="True"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="PolicyNo" Width="100" Caption="เลขกรมธรรม์" Settings-AllowFilterBySearchPanel="True"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewDateColumn FieldName="EffectiveDate" Caption="วันเริ่มคุ้มครอง" Width="100" PropertiesDateEdit-DisplayFormatString="dd/MM/yyyy" />

        <dx:BootstrapGridViewDateColumn FieldName="InsurerName" Caption="บริษัทประกันภัย" Width="100" PropertiesDateEdit-DisplayFormatString="dd/MM/yyyy" />



        <dx:BootstrapGridViewSpinEditColumn FieldName="Premium" Width="100" AdaptivePriority="2" Caption="เบี้ยสุทธิ" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>

        <dx:BootstrapGridViewSpinEditColumn FieldName="TotalPremium" Width="100" AdaptivePriority="2" Caption="จ่ายสุทธิ" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>


        <dx:BootstrapGridViewSpinEditColumn FieldName="GrossPremium" Width="100" AdaptivePriority="2" Caption="เบี้ยรวมภาษี" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>
        <dx:BootstrapGridViewSpinEditColumn FieldName="BRCommP" Width="100" AdaptivePriority="2" Caption="%" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>
        <dx:BootstrapGridViewSpinEditColumn FieldName="BRCommAmt" Width="100" AdaptivePriority="2" Caption="ค่าคอม" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>
        <dx:BootstrapGridViewSpinEditColumn FieldName="VAT7Amt" Width="100" AdaptivePriority="2" Caption="Vat(7%)" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>
        <dx:BootstrapGridViewSpinEditColumn FieldName="TAX3Amt" Width="100" AdaptivePriority="2" Caption="Tax(3%)" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>
        <dx:BootstrapGridViewSpinEditColumn FieldName="ServiceFreeP" Width="100" AdaptivePriority="2" Caption="%" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>
        <dx:BootstrapGridViewSpinEditColumn FieldName="ServiceFreeAmt" Width="100" AdaptivePriority="2" Caption="ค่าจัดการ" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>
        <dx:BootstrapGridViewSpinEditColumn FieldName="ServiceFreeVAT7Amt" Width="100" AdaptivePriority="2" Caption="Vat 7%" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>
        <dx:BootstrapGridViewSpinEditColumn FieldName="ServiceFreeTAX3Amt" Width="100" AdaptivePriority="2" Caption="Tax 3%" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>


        <dx:BootstrapGridViewDateColumn FieldName="PaymentBy" Caption="ชำระโดย" Width="100" PropertiesDateEdit-DisplayFormatString="dd/MM/yyyy" />
        <dx:BootstrapGridViewDateColumn FieldName="PaymentNo" Caption="บัญชีเลขที่" Width="100" PropertiesDateEdit-DisplayFormatString="dd/MM/yyyy" />
        <dx:BootstrapGridViewDateColumn FieldName="PaymentDate" Caption="วันที่่บันทึก" PropertiesDateEdit-DisplayFormatString="dd/MM/yyyy" SettingsEditForm-Visible="False" />


        <dx:BootstrapGridViewDateColumn FieldName="CreateDate" Caption="วันที่่บันทึก"
            Visible="false"
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

<asp:SqlDataSource ID="SqlDataSource_PaymentRegister" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
    SelectCommand="select * from v_PaymentRegister Order By CreateDate desc"
    DeleteCommand="delete from tblPaymentRegister where ID=@ID">
    <DeleteParameters>
        <asp:Parameter Name="ID" />
    </DeleteParameters>
</asp:SqlDataSource>













<dx:BootstrapPopupControl ID="TaskNewPopup" ClientInstanceName="TaskNewPopup" runat="server"
    ShowHeader="false" CloseOnEscape="false" CloseAction="CloseButton" HeaderText="เก็บค่าเบี้ยประกัน"
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
                <legend class="text-primary">การเงินเก็บค่าเบี้ยประกัน</legend>
            </fieldset>
            <dx:BootstrapFormLayout ID="newPolicyForm" ClientInstanceName="newPolicyForm" runat="server" LayoutType="Horizontal">
                <CssClasses Control="overview-fl" />
                <Items>

                    <dx:BootstrapLayoutItem Caption="เลขกรมธรรม์" FieldName="PolicyNo" ColSpanMd="6">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ReadOnly="true"></dx:BootstrapTextBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="บริษัทประกันภัย" FieldName="InsurerName" ColSpanMd="6">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ReadOnly="true"></dx:BootstrapTextBox>

                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>


                    <dx:BootstrapLayoutItem Caption="ชื่อผู้เอาประกันภัย" FieldName="ClientName" ColSpanMd="6">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ReadOnly="true"></dx:BootstrapTextBox>

                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="ทะเบียนรถ" FieldName="CarLicensePlate" ColSpanMd="6">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ReadOnly="true"></dx:BootstrapTextBox>

                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>


                    <dx:BootstrapLayoutItem Caption="วันเริ่มคุ้มครอง" FieldName="EffectiveDate" ColSpanMd="6">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ReadOnly="true" MaskSettings-Mask="dd/MM/yyyy"></dx:BootstrapTextBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="วันสิ้นสุด" FieldName="ExpiredDate" ColSpanMd="6">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ReadOnly="true" MaskSettings-Mask="dd/MM/yyyy"></dx:BootstrapTextBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>


                    <dx:BootstrapLayoutItem Caption="เบี้ยสุทธิ" FieldName="Premium" ColSpanMd="4" BeginRow="true">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapSpinEdit ID="newPremium" ClientEnabled="false" runat="server" DisplayFormatString="N2" AllowMouseWheel="false" NullText="0.00"
                                    SpinButtons-Enabled="false" SpinButtons-ClientVisible="false">
                                </dx:BootstrapSpinEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="อากร" FieldName="Stamp" ColSpanMd="4">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ReadOnly="true" MaskSettings-Mask="<0..99999g>.<00..99>"></dx:BootstrapTextBox>

                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="ภาษี" FieldName="Vat" ColSpanMd="4">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ReadOnly="true" MaskSettings-Mask="<0..99999g>.<00..99>"></dx:BootstrapTextBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>


                    <dx:BootstrapLayoutItem Caption="เบี้ยรวม" FieldName="GrossPremium" ColSpanMd="4">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="newGrossPremium" ReadOnly="true" MaskSettings-Mask="<0..99999g>.<00..99>"></dx:BootstrapTextBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="%" FieldName="Brokerage" ColSpanMd="4">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapSpinEdit ID="newBrokerage" runat="server" DisplayFormatString="N2" ValidationSettings-ValidationGroup="newPolicyForm" AllowMouseWheel="false" NullText="0.00"
                                    SpinButtons-Enabled="false" SpinButtons-ClientVisible="false" ValidationSettings-RequiredField-IsRequired="true">

                                    <ClientSideEvents ValueChanged="function(s,e){
                                        TaskNewPopup.PerformCallback('calpremium');
                                        }" />
                                </dx:BootstrapSpinEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="ค่าคอม" FieldName="BrokerageAmt" ColSpanMd="4">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapSpinEdit ID="newBrokerageAmt" ClientEnabled="false" runat="server" DisplayFormatString="N2" AllowMouseWheel="false" NullText="0.00"
                                    SpinButtons-Enabled="false" SpinButtons-ClientVisible="false">
                                </dx:BootstrapSpinEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>


                    <dx:BootstrapLayoutItem Caption="VAT(7%)" ColSpanMd="4">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapSpinEdit ID="newVAT7Amt" ClientEnabled="false" runat="server" DisplayFormatString="N2" AllowMouseWheel="false" NullText="0.00"
                                    SpinButtons-Enabled="false" SpinButtons-ClientVisible="false">
                                </dx:BootstrapSpinEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="TAX 3%" ColSpanMd="4">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapSpinEdit ID="newTAX3Amt" ClientEnabled="false" runat="server" DisplayFormatString="N2" AllowMouseWheel="false" NullText="0.00"
                                    SpinButtons-Enabled="false" SpinButtons-ClientVisible="false">
                                </dx:BootstrapSpinEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="%" ColSpanMd="4">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapSpinEdit ID="newServiceFreeP" runat="server" DisplayFormatString="N2" AllowMouseWheel="false" NullText="0.00" ValidationSettings-ValidationGroup="newPolicyForm"
                                    SpinButtons-Enabled="false" SpinButtons-ClientVisible="false" ValidationSettings-RequiredField-IsRequired="true">

                                    <ClientSideEvents ValueChanged="function(s,e){
                                        TaskNewPopup.PerformCallback('calpremium');
                                        }" />
                                </dx:BootstrapSpinEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>


                    <dx:BootstrapLayoutItem Caption="ค่าบริหารจัดการ" ColSpanMd="4">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapSpinEdit ID="newServiceFreeAmt" ClientEnabled="false" runat="server" DisplayFormatString="N2" AllowMouseWheel="false" NullText="0.00"
                                    SpinButtons-Enabled="false" SpinButtons-ClientVisible="false">
                                </dx:BootstrapSpinEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="Vat 7%" ColSpanMd="4">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapSpinEdit ID="newServiceFreeVAT7Amt" ClientEnabled="false" runat="server" DisplayFormatString="N2" AllowMouseWheel="false" NullText="0.00"
                                    SpinButtons-Enabled="false" SpinButtons-ClientVisible="false">
                                </dx:BootstrapSpinEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="Tax 3 %" ColSpanMd="4">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapSpinEdit ID="newServiceFreeTAX3Amt" ClientEnabled="false" runat="server" DisplayFormatString="N2" AllowMouseWheel="false" NullText="0.00"
                                    SpinButtons-Enabled="false" SpinButtons-ClientVisible="false">
                                </dx:BootstrapSpinEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>



                    <dx:BootstrapLayoutItem Caption="จ่ายสุทธิ" ColSpanMd="4">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapSpinEdit ID="newTotalPremium" ClientEnabled="false" runat="server" DisplayFormatString="N2" AllowMouseWheel="false" NullText="0.00"
                                    SpinButtons-Enabled="false" SpinButtons-ClientVisible="false">
                                </dx:BootstrapSpinEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>


                    <dx:BootstrapLayoutItem Caption="ชำระโดย" ColSpanMd="8">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="newPaymentBy" NullText="..." ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="newPolicyForm"></dx:BootstrapTextBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="เลขที่" ColSpanMd="4">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="newPaymentNo" NullText="..." ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="newPolicyForm"></dx:BootstrapTextBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="ลงวันที่" ColSpanMd="4">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapDateEdit ID="newPaymentDate" ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="newPolicyForm" runat="server" NullText="เลือกวันที่..." EditFormatString="dd/MM/yyyy">
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
    ShowHeader="false" CloseOnEscape="false" CloseAction="CloseButton" HeaderText="เก็บค่าเบี้ยประกัน"
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
                <legend class="text-primary">เก็บค่าเบี้ยประกัน</legend>
            </fieldset>
            <dx:BootstrapFormLayout ID="editPolicyForm" ClientInstanceName="editPolicyForm" runat="server" LayoutType="Horizontal">
                <CssClasses Control="overview-fl" />
                <Items>

                    <dx:BootstrapLayoutItem Caption="เลขกรมธรรม์" FieldName="PolicyNo" ColSpanMd="6">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ReadOnly="true"></dx:BootstrapTextBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="บริษัทประกันภัย" FieldName="InsurerName" ColSpanMd="6">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ReadOnly="true"></dx:BootstrapTextBox>

                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>


                    <dx:BootstrapLayoutItem Caption="ชื่อผู้เอาประกันภัย" FieldName="ClientName" ColSpanMd="6">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ReadOnly="true"></dx:BootstrapTextBox>

                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="ทะเบียนรถ" FieldName="CarLicensePlate" ColSpanMd="6">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ReadOnly="true"></dx:BootstrapTextBox>

                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>


                    <dx:BootstrapLayoutItem Caption="วันเริ่มคุ้มครอง" FieldName="EffectiveDate" ColSpanMd="6">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ReadOnly="true" MaskSettings-Mask="dd/MM/yyyy"></dx:BootstrapTextBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="วันสิ้นสุด" FieldName="ExpiredDate" ColSpanMd="6">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ReadOnly="true" MaskSettings-Mask="dd/MM/yyyy"></dx:BootstrapTextBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>


                    <dx:BootstrapLayoutItem Caption="เบี้ยสุทธิ" FieldName="Premium" ColSpanMd="4" BeginRow="true">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapSpinEdit ID="editPremium" ClientEnabled="false" runat="server" DisplayFormatString="N2" AllowMouseWheel="false" NullText="0.00"
                                    SpinButtons-Enabled="false" SpinButtons-ClientVisible="false">
                                </dx:BootstrapSpinEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="อากร" FieldName="Stamp" ColSpanMd="4">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ReadOnly="true" MaskSettings-Mask="<0..99999g>.<00..99>"></dx:BootstrapTextBox>

                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="ภาษี" FieldName="Vat" ColSpanMd="4">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ReadOnly="true" MaskSettings-Mask="<0..99999g>.<00..99>"></dx:BootstrapTextBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>


                    <dx:BootstrapLayoutItem Caption="เบี้ยรวม" FieldName="GrossPremium" ColSpanMd="4">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="editGrossPremium" ReadOnly="true" MaskSettings-Mask="<0..99999g>.<00..99>"></dx:BootstrapTextBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="%" FieldName="Brokerage" ColSpanMd="4">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapSpinEdit ID="editBrokerage" runat="server" DisplayFormatString="N2" ValidationSettings-ValidationGroup="editPolicyForm" AllowMouseWheel="false" NullText="0.00"
                                    SpinButtons-Enabled="false" SpinButtons-ClientVisible="false" ValidationSettings-RequiredField-IsRequired="true">

                                    <ClientSideEvents ValueChanged="function(s,e){
                                        TaskEditPopup.PerformCallback('calpremium');
                                        }" />
                                </dx:BootstrapSpinEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="ค่าคอม" FieldName="BrokerageAmt" ColSpanMd="4">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapSpinEdit ID="editBrokerageAmt" ClientEnabled="false" runat="server" DisplayFormatString="N2" AllowMouseWheel="false" NullText="0.00"
                                    SpinButtons-Enabled="false" SpinButtons-ClientVisible="false">
                                </dx:BootstrapSpinEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>


                    <dx:BootstrapLayoutItem Caption="VAT(7%)" FieldName="VAT7Amt" ColSpanMd="4">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapSpinEdit ID="editVAT7Amt" ClientEnabled="false" runat="server" DisplayFormatString="N2" AllowMouseWheel="false" NullText="0.00"
                                    SpinButtons-Enabled="false" SpinButtons-ClientVisible="false">
                                </dx:BootstrapSpinEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="TAX 3%" FieldName="TAX3Amt" ColSpanMd="4">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapSpinEdit ID="editTAX3Amt" ClientEnabled="false" runat="server" DisplayFormatString="N2" AllowMouseWheel="false" NullText="0.00"
                                    SpinButtons-Enabled="false" SpinButtons-ClientVisible="false">
                                </dx:BootstrapSpinEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="%" FieldName="ServiceFreeP" ColSpanMd="4">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapSpinEdit ID="editServiceFreeP" runat="server" DisplayFormatString="N2" AllowMouseWheel="false" NullText="0.00" ValidationSettings-ValidationGroup="editPolicyForm"
                                    SpinButtons-Enabled="false" SpinButtons-ClientVisible="false" ValidationSettings-RequiredField-IsRequired="true">

                                    <ClientSideEvents ValueChanged="function(s,e){
                                        TaskEditPopup.PerformCallback('calpremium');
                                        }" />
                                </dx:BootstrapSpinEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>


                    <dx:BootstrapLayoutItem Caption="ค่าบริหารจัดการ" FieldName="ServiceFreeAmt" ColSpanMd="4">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapSpinEdit ID="editServiceFreeAmt" ClientEnabled="false" runat="server" DisplayFormatString="N2" AllowMouseWheel="false" NullText="0.00"
                                    SpinButtons-Enabled="false" SpinButtons-ClientVisible="false">
                                </dx:BootstrapSpinEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="Vat 7%" FieldName="ServiceFreeVAT7Amt" ColSpanMd="4">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapSpinEdit ID="editServiceFreeVAT7Amt" ClientEnabled="false" runat="server" DisplayFormatString="N2" AllowMouseWheel="false" NullText="0.00"
                                    SpinButtons-Enabled="false" SpinButtons-ClientVisible="false">
                                </dx:BootstrapSpinEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="Tax 3 %" FieldName="ServiceFreeTAX3Amt" ColSpanMd="4">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapSpinEdit ID="editServiceFreeTAX3Amt" ClientEnabled="false" runat="server" DisplayFormatString="N2" AllowMouseWheel="false" NullText="0.00"
                                    SpinButtons-Enabled="false" SpinButtons-ClientVisible="false">
                                </dx:BootstrapSpinEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>



                    <dx:BootstrapLayoutItem Caption="จ่ายสุทธิ" FieldName="TotalPremium" ColSpanMd="4">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapSpinEdit ID="editTotalPremium" ClientEnabled="false" runat="server" DisplayFormatString="N2" AllowMouseWheel="false" NullText="0.00"
                                    SpinButtons-Enabled="false" SpinButtons-ClientVisible="false">
                                </dx:BootstrapSpinEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>


                    <dx:BootstrapLayoutItem Caption="ชำระโดย" FieldName="PaymentBy" ColSpanMd="8">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="editPaymentBy" NullText="..." ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="editPolicyForm"></dx:BootstrapTextBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="เลขที่" FieldName="PaymentNo" ColSpanMd="4">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapTextBox runat="server" ID="editPaymentNo" NullText="..." ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="editPolicyForm"></dx:BootstrapTextBox>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>
                    <dx:BootstrapLayoutItem Caption="ลงวันที่" FieldName="PaymentDate" ColSpanMd="4">
                        <ContentCollection>
                            <dx:ContentControl>
                                <dx:BootstrapDateEdit ID="editPaymentDate" ValidationSettings-RequiredField-IsRequired="true" ValidationSettings-ValidationGroup="editPolicyForm" runat="server" NullText="เลือกวันที่..." EditFormatString="dd/MM/yyyy">
                                </dx:BootstrapDateEdit>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>



                    <dx:BootstrapLayoutItem ShowCaption="False" ColSpanMd="12" HorizontalAlign="Left">
                        <ContentCollection>
                            <dx:ContentControl ID="ContentControl2" runat="server">
                                <dx:BootstrapButton ID="BootstrapButton1" runat="server" ValidationGroup="editPolicyForm" AutoPostBack="false" Text="Save" Width="100px">
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




