<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ucReportForInsurer2.ascx.vb" Inherits="Modules_ucReportForInsurer2" %>

<fieldset>
    <legend class="text-primary"><%=PageName %></legend>
</fieldset>

<%-- <asp:SqlDataSource ID="SqlDataSource_Insurer" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
    SelectCommand="select InsurerCode,  convert(nvarchar(255),InsurerName + ' (' + InsurerCode + ')') as InsurerName  from tblInsurer ">
</asp:SqlDataSource>--%>

<dx:BootstrapFormLayout ID="BootstrapFormLayout1" runat="server" ClientInstanceName="frmEnquiry" LayoutType="Horizontal">
    <Items>
        <dx:BootstrapLayoutItem Caption="จากวันที่" ColSpanLg="4" ColSpanSm="4">
            <ContentCollection>
                <dx:ContentControl>
                    <dx:BootstrapDateEdit runat="server" ID="datefrom" DisplayFormatString="{0:dd/MM/yyyy}" ValidationSettings-RequiredField-IsRequired="true">
                    </dx:BootstrapDateEdit>
                </dx:ContentControl>
            </ContentCollection>
        </dx:BootstrapLayoutItem>
        <dx:BootstrapLayoutItem Caption="ถึงวันที่" ColSpanLg="4" ColSpanSm="4">
            <ContentCollection>
                <dx:ContentControl>
                    <dx:BootstrapDateEdit runat="server" ID="dateto" DisplayFormatString="{0:dd/MM/yyyy}" ValidationSettings-RequiredField-IsRequired="true">
                    </dx:BootstrapDateEdit>
                </dx:ContentControl>
            </ContentCollection>
        </dx:BootstrapLayoutItem>
<%--         <dx:BootstrapLayoutItem Caption="บริษัทประกันภัย" ColSpanLg="4" ColSpanSm="4">
            <ContentCollection>
                <dx:ContentControl>
                    <dx:BootstrapComboBox runat="server" ID="insurer"
                        DataSourceID="SqlDataSource_Insurer" ValueField="InsurerCode" TextField="InsurerName"
                        ValidationSettings-RequiredField-IsRequired="true" 
                        DropDownStyle="DropDown"
                        ></dx:BootstrapComboBox>
                </dx:ContentControl>
            </ContentCollection>
        </dx:BootstrapLayoutItem>--%>


        <dx:BootstrapLayoutItem  ShowCaption="False" ColSpanLg="4" ColSpanSm="4">
            <ContentCollection>
                <dx:ContentControl>
                    <dx:BootstrapButton ID="btnPrintDetail" Text="Preview Details" AutoPostBack="false" runat="server">
                        <SettingsBootstrap RenderOption="Primary" />
                        <ClientSideEvents Click="function(s,e){

                                if(ASPxClientEdit.AreEditorsValid())
                                {
                                    LoadingPanel.Show();
                                    e.processOnServer = true;
                                }

                            }" />
                    </dx:BootstrapButton>

                     <dx:BootstrapButton ID="btnPrintSummary" Text="Preview Summary" AutoPostBack="false" runat="server">
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


         <dx:BootstrapLayoutItem  ShowCaption="False" ColSpanLg="4" ColSpanSm="4">
            <ContentCollection>
                <dx:ContentControl>
                   
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

    <ContentCollection>
        <dx:PopupControlContentControl ID="PopupControlContentControl2" runat="server">

            <dx:ASPxSpreadsheet ID="Spreadsheet" Width="100%" ReadOnly="true"
                runat="server"
                ActiveTabIndex="0" RibbonMode="None"
                ShowConfirmOnLosingChanges="false"
                ShowFormulaBar="false"
                ShowSheetTabs="true">
            </dx:ASPxSpreadsheet>


            <dx:BootstrapButton ID="btnExport" Text="Download" AutoPostBack="false" CssClasses-Icon="image fa fa-download" runat="server">
                <SettingsBootstrap RenderOption="Primary" />
                <ClientSideEvents Click="function(s,e){

                                  e.processOnServer = true;

                            }" />
            </dx:BootstrapButton>

        </dx:PopupControlContentControl>
    </ContentCollection>
</dx:ASPxPopupControl>

