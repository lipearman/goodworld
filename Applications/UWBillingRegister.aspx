<%@ Page Language="VB" AutoEventWireup="false" CodeFile="UWBillingRegister.aspx.vb" Inherits="Applications_UWBillingRegister" %>


<!DOCTYPE html>
<html id="Html1" xmlns="http://www.w3.org/1999/xhtml" runat="server">
<head id="Head1" runat="server">
  
    <meta name="viewport" content="width=device-width, user-scalable=no, maximum-scale=1.0, minimum-scale=1.0" />
    <link href="../Content/bootstrap.min.css" rel="stylesheet" />
    <link href="../Content/site.css" rel="stylesheet" />
    <link href="../Content/font-awesome.min.css" rel="stylesheet" />
    <script src="../Scripts/jquery-1.9.1.min.js" type="text/javascript"></script>
    <script src="../Scripts/bootstrap.min.js" type="text/javascript"></script>
    <script src="../Scripts/site.js" type="text/javascript"></script>


    <style type="text/css">
        .alink {
            color: white;
            cursor: pointer;
            text-decoration: none;
            background-color: transparent;
            -webkit-text-decoration-skip: objects;
        }

        .saveBt {
            margin-right: 10px;
        }

        .removeWrapping {
            white-space: nowrap;
        }

        body {
            background-color: #f5f5f5;
            margin-top: 0px;
            height: calc(100% - 60px);
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">
        <dx:ASPxLoadingPanel ID="LoadingPanel" runat="server" ClientInstanceName="LoadingPanel" Modal="True"></dx:ASPxLoadingPanel>
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
                        <dx:LayoutItem Caption="รหัส" FieldName="InsurerCode">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer1" runat="server">

                                    <dx:ASPxLabel ID="editInsurerCode" Wrap="False" AllowEllipsisInText="true" runat="server"></dx:ASPxLabel>

                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="บริษัทประกันภัย" FieldName="InsurerName">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer2" runat="server">

                                    <dx:ASPxLabel ID="editInsurerName" Wrap="False" AllowEllipsisInText="true" runat="server"></dx:ASPxLabel>

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
                                                                <%# Eval("Brokerage", "{0:N2}") %>
                                                            </CellTemplate>
                                                        </dx:ListBoxColumn>
                                                        <dx:ListBoxColumn FieldName="BrokerageAmt" Caption="ค่าคอม" Width="100">
                                                            <CellTemplate>
                                                                <%# Eval("BrokerageAmt", "{0:N2}") %>
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
                                    <div style="width: 900px; overflow: scroll">


                                        <dx:BootstrapGridView ID="taskGrid2" runat="server"
                                            ClientInstanceName="taskGrid2"
                                            AutoGenerateColumns="False" CssClasses-HeaderRow="removeWrapping" CssClasses-Row="removeWrapping"
                                            KeyFieldName="ID" SettingsBehavior-ConfirmDelete="true"
                                            SettingsBehavior-AllowDragDrop="true"
                                            SettingsPopup-EditForm-AllowResize="true" Settings-ShowFooter="true"
                                            DataSourceID="SqlDataSource_UWBillingPolicy"
                                            Width="600"
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

                                          

                                            <CssClasses Control="tasks-grid" PreviewRow="text-muted" />
                                            <ClientSideEvents ToolbarItemClick="function(s,e){
                                                    switch (e.item.name) {

                                                    case 'ExportToXLSX':
                                                    case 'ExportToXLS':
                                                        e.processOnServer = true;
                                                        e.usePostBack = true;
                                                        break;


                                                    case 'NewPolicy':
                                                        TaskNewPopup2.Show();
                                                        ASPxClientEdit.ClearEditorsInContainerById('newPolicyForm');
                                                        e.processOnServer = false;
                                                        break;
                                                }
                                            }" />




                                            <Columns>
                                                <dx:BootstrapGridViewDataColumn>
                                                    <DataItemTemplate>
                                                        <dx:BootstrapButton runat="server" ID="EditButton" Text=" " AutoPostBack="false" CssClasses-Icon="image fa fa-pencil" UseSubmitBehavior="False">
                                                            <ClientSideEvents Click="function(s,e){
                                                                 TaskEditPopup2.PerformCallback('edit|' + s.cpID);
                                                                 TaskEditPopup2.Show();
                                                            }" />
                                                            <SettingsBootstrap RenderOption="Link" />
                                                        </dx:BootstrapButton>
                                                    </DataItemTemplate>
                                                </dx:BootstrapGridViewDataColumn>
                                                <dx:BootstrapGridViewCommandColumn ShowDeleteButton="true"></dx:BootstrapGridViewCommandColumn>



                                                <dx:BootstrapGridViewTextColumn FieldName="RowNo" Width="50" Caption="No." Settings-AllowFilterBySearchPanel="True"></dx:BootstrapGridViewTextColumn>

                                                <dx:BootstrapGridViewTextColumn FieldName="ClientName" Width="300" Caption="ชื่อผู้เอาประกันภัย" Settings-AllowFilterBySearchPanel="True"></dx:BootstrapGridViewTextColumn>
                                                <dx:BootstrapGridViewTextColumn FieldName="CarLicensePlate" Width="100" Caption="ทะเบียนรถ" Settings-AllowFilterBySearchPanel="True"></dx:BootstrapGridViewTextColumn>
                                                <dx:BootstrapGridViewTextColumn FieldName="PolicyNo" Width="100" Caption="เลขกรมธรรม์" Settings-AllowFilterBySearchPanel="True"></dx:BootstrapGridViewTextColumn>
                                                <dx:BootstrapGridViewDateColumn FieldName="EffectiveDate" Caption="วันเริ่มคุ้มครอง" Width="100" PropertiesDateEdit-DisplayFormatString="dd/MM/yyyy" />

                                                <dx:BootstrapGridViewDateColumn FieldName="InsurerName" Caption="บริษัทประกันภัย" Width="100" />



                                                <dx:BootstrapGridViewSpinEditColumn FieldName="Premium" Width="100" AdaptivePriority="2" Caption="เบี้ยสุทธิ" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>



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



                                                <dx:BootstrapGridViewSpinEditColumn FieldName="TotalPremium" Width="100" AdaptivePriority="2" Caption="จ่ายสุทธิ" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>

                                            </Columns>
                                            <TotalSummary>
                                                <dx:ASPxSummaryItem FieldName="Premium" SummaryType="Sum" DisplayFormat="{0:N2}" />
                                                <dx:ASPxSummaryItem FieldName="GrossPremium" SummaryType="Sum" DisplayFormat="{0:N2}" />
                                                <dx:ASPxSummaryItem FieldName="BRCommAmt" SummaryType="Sum" DisplayFormat="{0:N2}" />
                                                <dx:ASPxSummaryItem FieldName="VAT7Amt" SummaryType="Sum" DisplayFormat="{0:N2}" />
                                                <dx:ASPxSummaryItem FieldName="TAX3Amt" SummaryType="Sum" DisplayFormat="{0:N2}" />
                                                <dx:ASPxSummaryItem FieldName="ServiceFreeAmt" SummaryType="Sum" DisplayFormat="{0:N2}" />
                                                <dx:ASPxSummaryItem FieldName="ServiceFreeVAT7Amt" SummaryType="Sum" DisplayFormat="{0:N2}" />
                                                <dx:ASPxSummaryItem FieldName="ServiceFreeTAX3Amt" SummaryType="Sum" DisplayFormat="{0:N2}" />
                                                <dx:ASPxSummaryItem FieldName="TotalPremium" SummaryType="Sum" DisplayFormat="{0:N2}" />
                                            </TotalSummary>


                                        </dx:BootstrapGridView>



                                    </div>


                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>

                        <dx:LayoutItem Caption="จำนวนเงิน" ColSpan="3">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer14" runat="server">

                                    <dx:ASPxGridView ID="grid_UWBillingPremium" runat="server" DataSourceID="SqlDataSource_UWBillingPremium"
                                        Settings-ShowFooter="true"
                                        KeyFieldName="ID" Width="80%" EnableRowsCache="False" SettingsBehavior-ConfirmDelete="true">
                                        <SettingsEditing EditFormColumnCount="1"></SettingsEditing>
                                        <SettingsCommandButton>
                                            <UpdateButton Text="Save"></UpdateButton>
                                        </SettingsCommandButton>
                                        <Columns>

                                            <dx:GridViewCommandColumn Width="50" ShowEditButton="true" ShowNewButtonInHeader="true" ShowDeleteButton="true"></dx:GridViewCommandColumn>

                                            <dx:GridViewDataTextColumn FieldName="UWBillingTitle" Width="80%" Caption="รายการ" CellStyle-Wrap="False">
                                                <PropertiesTextEdit ValidationSettings-RequiredField-IsRequired="true"></PropertiesTextEdit>
                                            </dx:GridViewDataTextColumn>

                                            <dx:GridViewDataSpinEditColumn FieldName="UWBillingPremium" Width="20%" Caption="จำนวนเงิน" CellStyle-Wrap="False">
                                                <PropertiesSpinEdit AllowMouseWheel="false"
                                                    SpinButtons-ClientVisible="false"
                                                    ValidationSettings-RequiredField-IsRequired="true"
                                                    DisplayFormatInEditMode="true" DisplayFormatString="N2">
                                                </PropertiesSpinEdit>
                                            </dx:GridViewDataSpinEditColumn>
                                        </Columns>
                                        <TotalSummary>
                                            <dx:ASPxSummaryItem FieldName="UWBillingPremium" SummaryType="Sum" DisplayFormat="n2" />
                                        </TotalSummary>
                                        <GroupSummary>
                                            <dx:ASPxSummaryItem FieldName="UWBillingPremium" SummaryType="Sum" DisplayFormat="n2" />
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
                                        <ClientSideEvents Click="function(s, e) {   
                                            window.top.clientView.Hide();    
                                             
                                            }" />
                                    </dx:ASPxButton>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>


                    </Items>
                </dx:LayoutGroup>
            </Items>
        </dx:ASPxFormLayout>


        <asp:SqlDataSource ID="SqlDataSource_UWBillingPolicy" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
            SelectCommand="select ROW_NUMBER() OVER(ORDER BY CreateDate desc) AS RowNo,* from v_UWBillingPolicy where UWBillingID=@UWBillingID "
            DeleteCommand="delete from tblUWBillingPolicy where ID=@ID">
            <SelectParameters >
                <asp:SessionParameter Name="UWBillingID" SessionField="UWBillingID" />
            </SelectParameters>
            <DeleteParameters>
                <asp:Parameter Name="ID" />
            </DeleteParameters>
        </asp:SqlDataSource>


        <asp:SqlDataSource ID="SqlDataSource_UWBillingPremium" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
            SelectCommand="select * from tblUWBillingPremium  where UWBillingID=@UWBillingID"
            InsertCommand="insert into tblUWBillingPremium(UWBillingID,UWBillingTitle,UWBillingPremium) values(@UWBillingID,@UWBillingTitle,@UWBillingPremium)"
            DeleteCommand="delete from tblUWBillingPremium where ID=@ID"
            UpdateCommand="update tblUWBillingPremium set UWBillingTitle=@UWBillingTitle,UWBillingPremium=@UWBillingPremium where ID=@ID">
            <SelectParameters>
                <asp:SessionParameter Name="UWBillingID" SessionField="UWBillingID" />
            </SelectParameters>
            <InsertParameters>
                <asp:SessionParameter Name="UWBillingID" SessionField="UWBillingID" />
                <asp:Parameter Name="UWBillingTitle" />
                <asp:Parameter Name="UWBillingPremium" />
            </InsertParameters>
            <DeleteParameters>
                <asp:Parameter Name="ID" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:Parameter Name="ID" />
                <asp:Parameter Name="UWBillingTitle" />
                <asp:Parameter Name="UWBillingPremium" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"></asp:SqlDataSource>







        <dx:BootstrapPopupControl ID="TaskNewPopup2" ClientInstanceName="TaskNewPopup2" runat="server"
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
                        TaskNewPopup2.Hide();
                        taskGrid2.Refresh();
                    }
                    else
                    {
                        //alert(s.cpnewtask);
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
                                        TaskNewPopup2.PerformCallback('calpremium');
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
                                        TaskNewPopup2.PerformCallback('calpremium');
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
                                        <dx:BootstrapTextBox runat="server" ID="newPaymentBy" NullText="..." ValidationSettings-ValidationGroup="newPolicyForm"></dx:BootstrapTextBox>
                                    </dx:ContentControl>
                                </ContentCollection>
                            </dx:BootstrapLayoutItem>
                            <dx:BootstrapLayoutItem Caption="เลขที่" ColSpanMd="4">
                                <ContentCollection>
                                    <dx:ContentControl>
                                        <dx:BootstrapTextBox runat="server" ID="newPaymentNo" NullText="..." ValidationSettings-ValidationGroup="newPolicyForm"></dx:BootstrapTextBox>
                                    </dx:ContentControl>
                                </ContentCollection>
                            </dx:BootstrapLayoutItem>
                            <dx:BootstrapLayoutItem Caption="ลงวันที่" ColSpanMd="4">
                                <ContentCollection>
                                    <dx:ContentControl>
                                        <dx:BootstrapDateEdit ID="newPaymentDate" ValidationSettings-ValidationGroup="newPolicyForm" runat="server" NullText="เลือกวันที่..." EditFormatString="dd/MM/yyyy">
                                        </dx:BootstrapDateEdit>
                                    </dx:ContentControl>
                                </ContentCollection>
                            </dx:BootstrapLayoutItem>



                            <dx:BootstrapLayoutItem ShowCaption="False" ColSpanMd="12" HorizontalAlign="Left">
                                <ContentCollection>
                                    <dx:ContentControl ID="ContentControl11" runat="server">
                                        <dx:BootstrapButton ID="TaskSaveButton" runat="server" ValidationGroup="newPolicyForm" AutoPostBack="false" Text="Save" Width="100px">
                                            <ClientSideEvents Click="function(s,e){

                                         if(ASPxClientEdit.ValidateEditorsInContainer(TaskNewPopup2.GetMainElement()))
                                         {
                                          TaskNewPopup2.PerformCallback('savenew');
                                         }


                                        }" />
                                            <SettingsBootstrap RenderOption="Primary" />
                                        </dx:BootstrapButton>
                                        <dx:BootstrapButton ID="TaskCancelButton" runat="server" AutoPostBack="False" CausesValidation="false" UseSubmitBehavior="False" Text="Cancel" Width="100px">
                                            <ClientSideEvents Click="function(s,e){
                                          TaskNewPopup2.Hide();
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





        <dx:BootstrapPopupControl ID="TaskEditPopup2" ClientInstanceName="TaskEditPopup2" runat="server"
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
     
                TaskEditPopup2.Hide();
                taskGrid2.Refresh();
            }
            else if(s.cpedittask=='edit' )
            {
               
                ASPxClientEdit.ValidateEditorsInContainer(TaskEditPopup2.GetMainElement());
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
                                        TaskEditPopup2.PerformCallback('calpremium');
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
                                        TaskEditPopup2.PerformCallback('calpremium');
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
                                        <dx:BootstrapTextBox runat="server" ID="editPaymentBy" NullText="..." ValidationSettings-ValidationGroup="editPolicyForm"></dx:BootstrapTextBox>
                                    </dx:ContentControl>
                                </ContentCollection>
                            </dx:BootstrapLayoutItem>
                            <dx:BootstrapLayoutItem Caption="เลขที่" FieldName="PaymentNo" ColSpanMd="4">
                                <ContentCollection>
                                    <dx:ContentControl>
                                        <dx:BootstrapTextBox runat="server" ID="editPaymentNo" NullText="..." ValidationSettings-ValidationGroup="editPolicyForm"></dx:BootstrapTextBox>
                                    </dx:ContentControl>
                                </ContentCollection>
                            </dx:BootstrapLayoutItem>
                            <dx:BootstrapLayoutItem Caption="ลงวันที่" FieldName="PaymentDate" ColSpanMd="4">
                                <ContentCollection>
                                    <dx:ContentControl>
                                        <dx:BootstrapDateEdit ID="editPaymentDate" ValidationSettings-ValidationGroup="editPolicyForm" runat="server" NullText="เลือกวันที่..." EditFormatString="dd/MM/yyyy">
                                        </dx:BootstrapDateEdit>
                                    </dx:ContentControl>
                                </ContentCollection>
                            </dx:BootstrapLayoutItem>



                            <dx:BootstrapLayoutItem ShowCaption="False" ColSpanMd="12" HorizontalAlign="Left">
                                <ContentCollection>
                                    <dx:ContentControl ID="ContentControl2" runat="server">
                                        <dx:BootstrapButton ID="BootstrapButton1" runat="server" ValidationGroup="editPolicyForm" AutoPostBack="false" Text="Save" Width="100px">
                                            <ClientSideEvents Click="function(s,e){

                                         if(ASPxClientEdit.ValidateEditorsInContainer(TaskEditPopup2.GetMainElement()))
                                         {
                                          TaskEditPopup2.PerformCallback('saveedit');
                                         }


                                        }" />
                                            <SettingsBootstrap RenderOption="Primary" />
                                        </dx:BootstrapButton>
                                        <dx:BootstrapButton ID="BootstrapButton2" runat="server" AutoPostBack="False" CausesValidation="false" UseSubmitBehavior="False" Text="Cancel" Width="100px">
                                            <ClientSideEvents Click="function(s,e){
                                          TaskEditPopup2.Hide();
                                              
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


    </form>
</body>
</html>
