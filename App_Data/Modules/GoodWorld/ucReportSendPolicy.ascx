<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ucReportSendPolicy.ascx.vb" Inherits="Modules_ucReportSendPolicy" %>

<fieldset>
    <legend class="text-primary"><%=PageName %></legend>
</fieldset>
<dx:BootstrapFormLayout ID="BootstrapFormLayout1" runat="server" ClientInstanceName="frmEnquiry" LayoutType="Vertical">
    <Items>
        <dx:BootstrapLayoutItem Caption="จากวันที่" ColSpanLg="4" ColSpanSm="6">
            <ContentCollection>
                <dx:ContentControl>
                    <dx:BootstrapDateEdit runat="server" ID="datefrom" DisplayFormatString="{0:dd/MM/yyyy}" ValidationSettings-RequiredField-IsRequired="true">
                    </dx:BootstrapDateEdit>
                </dx:ContentControl>
            </ContentCollection>
        </dx:BootstrapLayoutItem>
        <dx:BootstrapLayoutItem Caption="ถึงวันที่" ColSpanLg="4" ColSpanSm="6">
            <ContentCollection>
                <dx:ContentControl>
                    <dx:BootstrapDateEdit runat="server" ID="dateto" DisplayFormatString="{0:dd/MM/yyyy}" ValidationSettings-RequiredField-IsRequired="true">
                        
                    </dx:BootstrapDateEdit>
                </dx:ContentControl>
            </ContentCollection>
        </dx:BootstrapLayoutItem>
        <dx:BootstrapLayoutItem ShowCaption="False">
            <ContentCollection>
                <dx:ContentControl>
                    <dx:BootstrapButton ID="btnSearch" Text="Search"   AutoPostBack="false" runat="server">
                        <SettingsBootstrap RenderOption="Primary" />
                        <ClientSideEvents Click="function(s,e){

                                if(ASPxClientEdit.AreEditorsValid())
                                {
                                     //cbSend.PerformCallback();
                                    LoadingPanel.Show();
                                    e.processOnServer = true;
                                }

                            }" />
                    </dx:BootstrapButton>
                </dx:ContentControl>
            </ContentCollection>
        </dx:BootstrapLayoutItem>
    </Items>
</dx:BootstrapFormLayout>


<%--<dx:ASPxCallback ID="cbSend" runat="server" ClientInstanceName="cbSend">
    <ClientSideEvents 
         BeginCallback="function(s,e){
            LoadingPanel.Show();
        }"
        CallbackError="function(s, e) { 
            LoadingPanel.Hide(); 
        }"
        CallbackComplete="function(s, e) { 
                   LoadingPanel.Hide();
        ReportPopup.Show();
        }" />
</dx:ASPxCallback>



<dx:BootstrapPopupControl ID="ReportPopup" ClientInstanceName="ReportPopup" runat="server" 
    ShowHeader="true" CloseOnEscape="false" CloseAction="CloseButton" HeaderText="รายงาน"
    PopupAnimationType="Fade">
    <SettingsAdaptivity Mode="Always" FixedHeader="true" VerticalAlign="WindowTop" />
    <SettingsBootstrap Sizing="Large" />
     


    <ContentCollection>
        <dx:ContentControl ID="ContentControl5" runat="server">
            
            <img src="images/ReportPolicyRegister.jpg" width="850" />
        </dx:ContentControl>
    </ContentCollection>
</dx:BootstrapPopupControl>--%>


<dx:ASPxCallback ID="cbExport" runat="server" ClientInstanceName="cbExport">

</dx:ASPxCallback>

<dx:BootstrapGridView ID="TaskGrid" runat="server"
    ClientInstanceName="taskGrid" Visible="false"
    AutoGenerateColumns="False" 
    KeyFieldName="InsurerCode" 
    Width="100%" CssClasses-HeaderRow="removeWrapping" CssClasses-Row="removeWrapping"
    PopupAnimationType="Fade" CloseOnEscape="true" CloseAction="None">
    <CssClasses Control="tasks-grid" PreviewRow="text-muted" />

    <Columns>

<dx:BootstrapGridViewDataColumn>
    <DataItemTemplate>


        <dx:BootstrapButton runat="server" ID="exportButton" OnClick="exportButton_Click" CommandArgument='<%# Eval("InsurerCode") %>' CssClasses-Icon="image fa fa-download" UseSubmitBehavior="False">

        </dx:BootstrapButton>


    </DataItemTemplate>

</dx:BootstrapGridViewDataColumn>


<dx:BootstrapGridViewTextColumn FieldName="RowNo" Caption="ลำดับที่"></dx:BootstrapGridViewTextColumn>
<dx:BootstrapGridViewTextColumn FieldName="InsurerName" Caption="บริษัทประกันภัย"></dx:BootstrapGridViewTextColumn>
<dx:BootstrapGridViewSpinEditColumn FieldName="PolicyCount" Caption="จำนวนกรมธรรม์" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N0}"></dx:BootstrapGridViewSpinEditColumn>
<dx:BootstrapGridViewSpinEditColumn FieldName="TotalPremium" Caption="เบี้ยประกันภัย" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>
<dx:BootstrapGridViewSpinEditColumn FieldName="Brokerage" Caption="ค่าคอม(ตามกฎหมาย)" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>

    </Columns>

    <SettingsPager Mode="ShowAllRecords" >
 
    </SettingsPager>
    <SettingsAdaptivity AdaptivityMode="HideDataCells" AllowOnlyOneAdaptiveDetailExpanded="true" />

</dx:BootstrapGridView>

<asp:SqlDataSource ID="SqlDataSource_gridData" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"></asp:SqlDataSource>




<dx:BootstrapGridView ID="ExportGrid" runat="server"
    ClientInstanceName="ExportGrid" Visible="false"
    AutoGenerateColumns="False"
    >
    <Columns>
        <dx:BootstrapGridViewTextColumn FieldName="InsurerName" Caption="บริษัทประกันภัย"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="ClientName" Caption="ผู้เอาประกัน"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="PolicyNo" Caption="หมายเลขกรมธรรม์"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewDateColumn FieldName="EffectiveDate" PropertiesDateEdit-DisplayFormatString="dd/MM/yyyy" />
        <dx:BootstrapGridViewDateColumn FieldName="ExpiredDate" PropertiesDateEdit-DisplayFormatString="dd/MM/yyyy" />
        <dx:BootstrapGridViewTextColumn FieldName="Name" Caption="ผู้เอาประกันภัย"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="CarLicensePlate" Caption="ทะเบียน"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="Chassis" Caption="เลขถัง"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewSpinEditColumn FieldName="Suminsured" Caption="จำนวนเงินเอาประกันภัย" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N0}"></dx:BootstrapGridViewSpinEditColumn>
        <dx:BootstrapGridViewSpinEditColumn FieldName="Premium" Caption="เบี้ยประกันภัย" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>
        <dx:BootstrapGridViewSpinEditColumn FieldName="Vat" Caption="ภาษี" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>
        <dx:BootstrapGridViewSpinEditColumn FieldName="Stamp" Caption="อากร" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>
        <dx:BootstrapGridViewSpinEditColumn FieldName="GrossPremium" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>
        <dx:BootstrapGridViewTextColumn FieldName="NewRenew" Caption="ใหม่/ต่อายุ"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="AgentCode" Caption="รหัสตัวแทน"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="AgentName" Caption="ตัวแทน"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewSpinEditColumn FieldName="Brokerage" Caption="ค่าคอม(%)" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>
        <dx:BootstrapGridViewTextColumn FieldName="BrokerageAmt" Caption="ค่าคอม(บาท)"></dx:BootstrapGridViewTextColumn>

    </Columns>
 
    <SettingsPager Mode="ShowAllRecords">
      
    </SettingsPager>
 
</dx:BootstrapGridView>


<asp:SqlDataSource ID="SqlDataSource_Export" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"></asp:SqlDataSource>
