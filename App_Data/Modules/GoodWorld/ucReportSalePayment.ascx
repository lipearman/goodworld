<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ucReportSalePayment.ascx.vb" Inherits="Modules_ucReportSalePayment" %>

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
                    <dx:BootstrapDateEdit runat="server" ID="CheckOutDateEdit" DisplayFormatString="{0:dd/MM/yyyy}" ValidationSettings-RequiredField-IsRequired="true">
                        <DateRangeSettings StartDateEditID="dateto" MinDayCount="1" CalendarColumnCount="1"  />
                    </dx:BootstrapDateEdit>
                </dx:ContentControl>
            </ContentCollection>
        </dx:BootstrapLayoutItem>
        <dx:BootstrapLayoutItem ShowCaption="False">
            <ContentCollection>
                <dx:ContentControl>
                    <dx:BootstrapButton ID="BootstrapButton1" Text="Submit" AutoPostBack="false"  runat="server">
                        <SettingsBootstrap RenderOption="Primary" />
                        <ClientSideEvents Click="function(s,e){

                                if(ASPxClientEdit.AreEditorsValid())
                                {
                                     cbSend.PerformCallback();
                                }
                            }" />
                    </dx:BootstrapButton>
                </dx:ContentControl>
            </ContentCollection>
        </dx:BootstrapLayoutItem>
    </Items>
</dx:BootstrapFormLayout>


<dx:ASPxCallback ID="cbSend" runat="server" ClientInstanceName="cbSend">
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
            
            <img src="images/ReportSalePayment.jpg" width="850" />
        </dx:ContentControl>
    </ContentCollection>
</dx:BootstrapPopupControl>