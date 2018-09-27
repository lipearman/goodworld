<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ucReportBilling2.ascx.vb" Inherits="Modules_ucReportBilling2" %>
<fieldset>
    <legend class="text-primary"><%=PageName %></legend>
</fieldset>
<asp:SqlDataSource ID="SqlDataSource_Year" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
    SelectCommand="SELECT distinct  EffectiveYear  FROM  v_Report_AgentBilling_Summary order by EffectiveYear desc"></asp:SqlDataSource>


<dx:BootstrapFormLayout ID="BootstrapFormLayout1" runat="server" ClientInstanceName="frmEnquiry" LayoutType="Horizontal">
    <Items>
        <dx:BootstrapLayoutItem Caption="ประจำปี" ColSpanLg="4" ColSpanSm="4">
            <ContentCollection>
                <dx:ContentControl>
                    <dx:BootstrapComboBox runat="server" ID="EffectiveYear"
                        DataSourceID="SqlDataSource_Year" TextField="EffectiveYear" ValueField="EffectiveYear"
                        ValidationSettings-RequiredField-IsRequired="true"
                        DropDownStyle="DropDown">
                    </dx:BootstrapComboBox>
                </dx:ContentControl>
            </ContentCollection>
        </dx:BootstrapLayoutItem>

        <dx:BootstrapLayoutItem ShowCaption="False" ColSpanLg="4" ColSpanSm="4">
            <ContentCollection>
                <dx:ContentControl>
                    <dx:BootstrapButton ID="btnSearch" Text="Preview" AutoPostBack="false" runat="server">
                        <SettingsBootstrap RenderOption="Primary" />
                        <ClientSideEvents Click="function(s,e){

                                if(ASPxClientEdit.AreEditorsValid())
                                {
                                    LoadingPanel.Show();
                                    e.processOnServer = true;
                                }

                            }" />
                    </dx:BootstrapButton>
                </dx:ContentControl>
            </ContentCollection>
        </dx:BootstrapLayoutItem>

        <dx:BootstrapLayoutItem Caption=" " ColSpanLg="4" ColSpanSm="4">
            <ContentCollection>
                <dx:ContentControl>
                </dx:ContentControl>
            </ContentCollection>
        </dx:BootstrapLayoutItem>
    </Items>
</dx:BootstrapFormLayout>



<dx:ASPxCallback ID="cbExport" runat="server" ClientInstanceName="cbExport">
</dx:ASPxCallback>

<dx:BootstrapGridView ID="TaskGrid" runat="server"
    ClientInstanceName="taskGrid" Visible="false"
    AutoGenerateColumns="False" DataSourceID="SqlDataSource_gridData"
    KeyFieldName="AgentCode" SettingsBehavior-AllowDragDrop="false"
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

         
            } 
        }" />
     <Toolbars>
        <dx:BootstrapGridViewToolbar>
            <Items>

                <dx:BootstrapGridViewToolbarItem Command="Refresh" BeginGroup="true" /> 
                <dx:BootstrapGridViewToolbarItem Command="ClearSorting" BeginGroup="true" />
 
                <dx:BootstrapGridViewToolbarItem Command="Custom" Text="Export To" BeginGroup="true">
                    <Items>
                        <dx:BootstrapGridViewToolbarMenuItem Name="ExportToXLSX" Text="XLSX" />
                        <dx:BootstrapGridViewToolbarMenuItem Name="ExportToXLS" Text="XLS" />
                    </Items>
                </dx:BootstrapGridViewToolbarItem>

            

            </Items>
        </dx:BootstrapGridViewToolbar>
    </Toolbars>
    <Columns>
       <dx:BootstrapGridViewDataColumn Width="50">
            <DataItemTemplate>
                <dx:BootstrapButton runat="server" ID="SelectButton" Text="เลือก" AutoPostBack="false" CssClasses-Icon="image fa fa-plus-square-o" UseSubmitBehavior="False">
                    <ClientSideEvents Click="function(s,e){
                                 TaskEditPopup.PerformCallback(s.cpID);
                                 TaskEditPopup.Show();
                            }" />
                    <SettingsBootstrap RenderOption="Link" />
                </dx:BootstrapButton>
            </DataItemTemplate>
        </dx:BootstrapGridViewDataColumn>

        <dx:BootstrapGridViewTextColumn FieldName="AgentName" Caption="Sub-Broker"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewSpinEditColumn FieldName="January" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>
        <dx:BootstrapGridViewSpinEditColumn FieldName="February" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>
        <dx:BootstrapGridViewSpinEditColumn FieldName="March" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>
        <dx:BootstrapGridViewSpinEditColumn FieldName="April" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>
        <dx:BootstrapGridViewSpinEditColumn FieldName="May" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>
        <dx:BootstrapGridViewSpinEditColumn FieldName="June" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>
        <dx:BootstrapGridViewSpinEditColumn FieldName="July" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>
        <dx:BootstrapGridViewSpinEditColumn FieldName="August" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>
        <dx:BootstrapGridViewSpinEditColumn FieldName="September" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>
        <dx:BootstrapGridViewSpinEditColumn FieldName="October" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>
        <dx:BootstrapGridViewSpinEditColumn FieldName="November" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>
        <dx:BootstrapGridViewSpinEditColumn FieldName="December" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>



    </Columns>
    <TotalSummary>

        <dx:ASPxSummaryItem FieldName="January" SummaryType="Sum" DisplayFormat="{0:N2}" />
        <dx:ASPxSummaryItem FieldName="February" SummaryType="Sum" DisplayFormat="{0:N2}" />
        <dx:ASPxSummaryItem FieldName="March" SummaryType="Sum" DisplayFormat="{0:N2}" />
        <dx:ASPxSummaryItem FieldName="April" SummaryType="Sum" DisplayFormat="{0:N2}" />
        <dx:ASPxSummaryItem FieldName="May" SummaryType="Sum" DisplayFormat="{0:N2}" />
        <dx:ASPxSummaryItem FieldName="June" SummaryType="Sum" DisplayFormat="{0:N2}" />
        <dx:ASPxSummaryItem FieldName="July" SummaryType="Sum" DisplayFormat="{0:N2}" />
        <dx:ASPxSummaryItem FieldName="August" SummaryType="Sum" DisplayFormat="{0:N2}" />
        <dx:ASPxSummaryItem FieldName="September" SummaryType="Sum" DisplayFormat="{0:N2}" />
        <dx:ASPxSummaryItem FieldName="October" SummaryType="Sum" DisplayFormat="{0:N2}" />
        <dx:ASPxSummaryItem FieldName="November" SummaryType="Sum" DisplayFormat="{0:N2}" />
        <dx:ASPxSummaryItem FieldName="December" SummaryType="Sum" DisplayFormat="{0:N2}" />


    </TotalSummary>
    <SettingsPager Mode="ShowAllRecords">
    </SettingsPager> 
    <Settings ShowFooter="True" />
</dx:BootstrapGridView>

<asp:SqlDataSource ID="SqlDataSource_gridData" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
     SelectCommand="select * from v_Report_AgentBilling_Summary where EffectiveYear=@EffectiveYear"
    >
    <SelectParameters >
        <asp:SessionParameter Name="EffectiveYear" SessionField="EffectiveYear" />
    </SelectParameters>


</asp:SqlDataSource>




<dx:ASPxPopupControl ID="TaskEditPopup" ClientInstanceName="TaskEditPopup" runat="server"
    ShowHeader="true" CloseOnEscape="false" CloseAction="CloseButton" HeaderText="รายละเอียดเบี้ยประกันภัยค้างรับ"
    Modal="true" Maximized="true"
    PopupAnimationType="Fade">


    <ClientSideEvents
        BeginCallback="function(s,e){
            LoadingPanel.Show();
        }"
        CallbackError="function(s,e){
            LoadingPanel.Hide(); 
        }"
        EndCallback="function(s,e){
           taskGridDetails.Refresh();
            LoadingPanel.Hide();
        }" />


    <ContentCollection>
        <dx:PopupControlContentControl ID="PopupControlContentControl5" runat="server">
            <dx:ASPxHiddenField runat="server" ID="hdID"></dx:ASPxHiddenField>
             


<dx:BootstrapGridView ID="taskGridDetails" runat="server"
    ClientInstanceName="taskGridDetails" 
    AutoGenerateColumns="False"  DataSourceID="SqlDataSource_Details"
    KeyFieldName="ID" SettingsBehavior-AllowDragDrop="false"
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

         
            } 
        }" />
     <Toolbars>
        <dx:BootstrapGridViewToolbar>
            <Items>

                <dx:BootstrapGridViewToolbarItem Command="Refresh" BeginGroup="true" /> 
                <dx:BootstrapGridViewToolbarItem Command="ClearSorting" BeginGroup="true" />
 
                <dx:BootstrapGridViewToolbarItem Command="Custom" Text="Export To" BeginGroup="true">
                    <Items>
                        <dx:BootstrapGridViewToolbarMenuItem Name="ExportToXLSX" Text="XLSX" />
                        <dx:BootstrapGridViewToolbarMenuItem Name="ExportToXLS" Text="XLS" />
                    </Items>
                </dx:BootstrapGridViewToolbarItem>

            

            </Items>
        </dx:BootstrapGridViewToolbar>
    </Toolbars>
    <Columns>
 
<dx:BootstrapGridViewTextColumn FieldName="RowNo" HorizontalAlign="Center" Caption="ลำดับที่"></dx:BootstrapGridViewTextColumn>
        
<dx:BootstrapGridViewTextColumn FieldName="ClientName" Caption="ผู้เอาประกันภัย"></dx:BootstrapGridViewTextColumn>
<dx:BootstrapGridViewTextColumn FieldName="PolicyNo" Caption="เลขที่กรมธรรม์"></dx:BootstrapGridViewTextColumn>
<dx:BootstrapGridViewTextColumn FieldName="CarLicensePlate" Caption="ทะเบียนรถ"></dx:BootstrapGridViewTextColumn>
<dx:BootstrapGridViewTextColumn FieldName="EffectiveDate" Caption="วันที่เริ่มคุ้มครอง" PropertiesTextEdit-DisplayFormatString="{0:dd/MM/yyyy}"></dx:BootstrapGridViewTextColumn>
<dx:BootstrapGridViewTextColumn FieldName="InsurerName" Caption="บริษัทประกันภัย"></dx:BootstrapGridViewTextColumn>     
<dx:BootstrapGridViewSpinEditColumn FieldName="Premium" Caption="เบี้ยสุทธิ" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>
<dx:BootstrapGridViewSpinEditColumn FieldName="Stamp" Caption="อากร" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>
<dx:BootstrapGridViewSpinEditColumn FieldName="Vat" Caption="ภาษี" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>
<dx:BootstrapGridViewSpinEditColumn FieldName="GrossPremium" Caption="เบี้ยรวม" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>
 

    </Columns>
    <TotalSummary>

        <dx:ASPxSummaryItem FieldName="Premium" SummaryType="Sum" DisplayFormat="{0:N2}" />
        <dx:ASPxSummaryItem FieldName="Stamp" SummaryType="Sum" DisplayFormat="{0:N2}" />
        <dx:ASPxSummaryItem FieldName="Vat" SummaryType="Sum" DisplayFormat="{0:N2}" />
        <dx:ASPxSummaryItem FieldName="GrossPremium" SummaryType="Sum" DisplayFormat="{0:N2}" />


    </TotalSummary>
    <SettingsPager Mode="ShowPager">
    </SettingsPager> 
    <Settings ShowFooter="True" />
     <SettingsSearchPanel Visible="true" AllowTextInputTimer="false" ShowApplyButton="true" />
</dx:BootstrapGridView>





        </dx:PopupControlContentControl>
    </ContentCollection>
</dx:ASPxPopupControl>


<asp:SqlDataSource ID="SqlDataSource_Details" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
     SelectCommand="select ROW_NUMBER() OVER(ORDER BY ClientName) AS RowNo,* 
    from v_SubBillingDetails where ReceiveDate is null 
    and year(EffectiveDate)=@EffectiveYear
    and AgentCode=@AgentCode
    "
    >
    <SelectParameters >
        <asp:SessionParameter Name="EffectiveYear" SessionField="EffectiveYear" />
        <asp:SessionParameter Name="AgentCode" SessionField="AgentCode" />
    </SelectParameters>


</asp:SqlDataSource>