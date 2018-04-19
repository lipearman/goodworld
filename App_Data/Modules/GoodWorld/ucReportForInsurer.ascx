<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ucReportForInsurer.ascx.vb" Inherits="Modules_ucReportForInsurer" %>
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
                    <dx:BootstrapButton ID="btnSearch" Text="Search" AutoPostBack="false" runat="server">
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



<dx:ASPxCallback ID="cbExport" runat="server" ClientInstanceName="cbExport">
</dx:ASPxCallback>

<dx:BootstrapGridView ID="TaskGrid" runat="server"
    ClientInstanceName="taskGrid" Visible="false"
    AutoGenerateColumns="False"
    KeyFieldName="AgentCode"
    Width="100%" CssClasses-HeaderRow="removeWrapping" CssClasses-Row="removeWrapping"
    PopupAnimationType="Fade" CloseOnEscape="true" CloseAction="None">
    <CssClasses Control="tasks-grid" PreviewRow="text-muted" />

    <Columns>

        <dx:BootstrapGridViewDataColumn HorizontalAlign="Center">
            <DataItemTemplate>


                <dx:BootstrapButton runat="server" ID="exportButton" OnClick="exportButton_Click" CommandArgument='<%# Eval("AgentCode") %>' CssClasses-Icon="image fa fa-print" UseSubmitBehavior="False">
                </dx:BootstrapButton>


            </DataItemTemplate>

        </dx:BootstrapGridViewDataColumn>


        <dx:BootstrapGridViewTextColumn FieldName="RowNo" HorizontalAlign="Center" Caption="ลำดับที่"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="AgentCode" Caption="รหัสตัวแทน"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="AgentName" Caption="ตัวแทน"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewSpinEditColumn FieldName="PolicyCount" Caption="จำนวนกรมธรรม์" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N0}"></dx:BootstrapGridViewSpinEditColumn>

        <dx:BootstrapGridViewSpinEditColumn FieldName="Premium" Caption="เบี้ยสุทธิ" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>

        <dx:BootstrapGridViewSpinEditColumn FieldName="Stamp" Caption="อากร" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>

        <dx:BootstrapGridViewSpinEditColumn FieldName="Vat" Caption="ภาษี" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>
        <dx:BootstrapGridViewSpinEditColumn FieldName="GrossPremium" Caption="เบี้ยรวม" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>




    </Columns>
      <TotalSummary>

        <dx:ASPxSummaryItem FieldName="PolicyCount" SummaryType="Sum" DisplayFormat="{0:N0}" />
        <dx:ASPxSummaryItem FieldName="Premium" SummaryType="Sum" DisplayFormat="{0:N2}" />
        <dx:ASPxSummaryItem FieldName="Stamp" SummaryType="Sum" DisplayFormat="{0:N2}" />
          <dx:ASPxSummaryItem FieldName="Vat" SummaryType="Sum" DisplayFormat="{0:N2}" />
          <dx:ASPxSummaryItem FieldName="GrossPremium" SummaryType="Sum" DisplayFormat="{0:N2}" />
    </TotalSummary>
    <SettingsPager Mode="ShowAllRecords">
    </SettingsPager>
    <SettingsAdaptivity AdaptivityMode="HideDataCells" AllowOnlyOneAdaptiveDetailExpanded="true" />
     <Settings ShowFooter="True" />
</dx:BootstrapGridView>

<asp:SqlDataSource ID="SqlDataSource_gridData" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"></asp:SqlDataSource>


















<dx:BootstrapGridView ID="ExportGrid" runat="server"
    ClientInstanceName="ExportGrid" Visible="false"
    AutoGenerateColumns="False">
    <Columns>
        <dx:BootstrapGridViewTextColumn FieldName="InsurerName" Caption="บริษัทประกันภัย"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="ClientName" Caption="ผู้เอาประกัน"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="PolicyNo" Caption="หมายเลขกรมธรรม์"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewDateColumn FieldName="EffectiveDate" PropertiesDateEdit-DisplayFormatString="dd/MM/yyyy" />
        <dx:BootstrapGridViewDateColumn FieldName="ExpiredDate" PropertiesDateEdit-DisplayFormatString="dd/MM/yyyy" />
        <dx:BootstrapGridViewTextColumn FieldName="InsureType" Caption="ประเภทประกันภัย"></dx:BootstrapGridViewTextColumn>
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


<asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="false"></asp:ScriptManager>

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

    <ClientSideEvents Shown="function(s,e){ 
                    //LoadingPanel.Show();
                }"
        CloseButtonClick="function(s,e){
            //grid.Refresh();
        }" />

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

        </dx:PopupControlContentControl>
    </ContentCollection>
</dx:ASPxPopupControl>

  