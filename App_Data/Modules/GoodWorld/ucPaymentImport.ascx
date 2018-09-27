<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ucPaymentImport.ascx.vb" Inherits="Modules_ucPaymentImport" %>

<script type="text/javascript">
    var fileNumber = 0;
    var fileName = "";
    var startDate = null;
    function UploadControl_OnFileUploadStart() {
        startDate = new Date();
        ClearProgressInfo();
        pcProgress.Show();
    }
    function UploadControl_OnFilesUploadComplete(e) {
        pcProgress.Hide();
        if (e.errorText)
            ShowMessage(e.errorText);
        else if (e.callbackData == "success") {
            //ShowMessage("File uploading has been successfully completed.");
            LoadingPanel.Show();
            cbUploadData.PerformCallback();

        }
    }
    function ShowMessage(message) {
        window.setTimeout(function () { window.alert(message); }, 0);
    }
    // Progress Dialog
    function UploadControl_OnUploadingProgressChanged(args) {
        if (!pcProgress.IsVisible())
            return;
        if (args.currentFileName != fileName) {
            fileName = args.currentFileName;
            fileNumber++;
        }
        SetCurrentFileUploadingProgress(args.currentFileName, args.currentFileUploadedContentLength, args.currentFileContentLength);
        progress1.SetPosition(args.currentFileProgress);
        SetTotalUploadingProgress(fileNumber, args.fileCount, args.uploadedContentLength, args.totalContentLength);
        progress2.SetPosition(args.progress);
        UpdateProgressStatus(args.uploadedContentLength, args.totalContentLength);
    }
    function SetCurrentFileUploadingProgress(fileName, uploadedLength, fileLength) {
        lblFileName.SetText("Current File Progress: " + fileName);
        lblFileName.GetMainElement().title = fileName;
        lblCurrentUploadedFileLength.SetText(GetContentLengthString(uploadedLength) + " / " + GetContentLengthString(fileLength));
    }
    function SetTotalUploadingProgress(number, count, uploadedLength, totalLength) {
        lblUploadedFiles.SetText("Total Progress: " + number + ' of ' + count + " file(s)");
        lblUploadedFileLength.SetText(GetContentLengthString(uploadedLength) + " / " + GetContentLengthString(totalLength));
    }
    function ClearProgressInfo() {
        SetCurrentFileUploadingProgress("", 0, 0);
        progress1.SetPosition(0);
        SetTotalUploadingProgress(0, 0, 0, 0);
        progress2.SetPosition(0);
        lblProgressStatus.SetText('Elapsed time: 00:00:00 &ensp; Estimated time: 00:00:00 &ensp; Speed: ' + GetContentLengthString(0) + '/s');
        fileNumber = 0;
        fileName = "";
    }
    function UpdateProgressStatus(uploadedLength, totalLength) {
        var currentDate = new Date();
        var elapsedDateMilliseconds = currentDate - startDate;
        var speed = uploadedLength / (elapsedDateMilliseconds / 1000);
        var elapsedDate = new Date(elapsedDateMilliseconds);
        var elapsedTime = GetTimeString(elapsedDate);
        var estimatedMilliseconds = Math.floor((totalLength - uploadedLength) / speed) * 1000;
        var estimatedDate = new Date(estimatedMilliseconds);
        var estimatedTime = GetTimeString(estimatedDate);
        var speed = uploadedLength / (elapsedDateMilliseconds / 1000);
        lblProgressStatus.SetText('Elapsed time: ' + elapsedTime + ' &ensp; Estimated time: ' + estimatedTime + ' &ensp; Speed: ' + GetContentLengthString(speed) + '/s');
    }
    function GetContentLengthString(contentLength) {
        var sizeDimensions = ['bytes', 'KB', 'MB', 'GB', 'TB'];
        var index = 0;
        var length = contentLength;
        var postfix = sizeDimensions[index];
        while (length > 1024) {
            length = length / 1024;
            postfix = sizeDimensions[++index];
        }
        var numberRegExpPattern = /[-+]?[0-9]*(?:\.|\,)[0-9]{0,2}|[0-9]{0,2}/;
        var results = numberRegExpPattern.exec(length);
        length = results ? results[0] : Math.floor(length);
        return length.toString() + ' ' + postfix;
    }
    function GetTimeString(date) {
        var timeRegExpPattern = /\d{1,2}:\d{1,2}:\d{1,2}/;
        var results = timeRegExpPattern.exec(date.toUTCString());
        return results ? results[0] : "00:00:00";
    }
</script>

<fieldset>
    <legend class="text-primary"><%=PageName %></legend>
</fieldset>


<table>
    <tr>

        <td style="vertical-align: top; width: 100px">
            <dx:ASPxButton ID="ASPxButton3" OnClick="btnDownloadFormat_click"
                runat="server"
                Image-IconID="actions_download_16x16office2013"
                Text="Download Format">
            </dx:ASPxButton>
        </td>
        <td>&nbsp; 
        </td>

        <td style="vertical-align: top; width: 100px">
            <dx:ASPxButton ID="ASPxButton1" OnClick="ASPxButton1_Click"
                runat="server"
                Image-IconID="actions_download_16x16office2013"
                Text="Example Data">
            </dx:ASPxButton>
        </td>
        <td>&nbsp; 
        </td>
        <td style="vertical-align: top">
            <dx:ASPxUploadControl ID="UploadControl" runat="server" ClientInstanceName="UploadControl" Width="330" Height="50"
                NullText="Click here to browse files..." UploadMode="Advanced" AutoStartUpload="True">
                <AdvancedModeSettings EnableMultiSelect="false" EnableDragAndDrop="false" />
                <ValidationSettings MaxFileSize="10000000" ShowErrors="false" AllowedFileExtensions=".xlsx"></ValidationSettings>
                <ClientSideEvents FilesUploadStart="function(s, e) { UploadControl_OnFileUploadStart(); }"
                    FileUploadComplete="function(s, e) { UploadControl_OnFilesUploadComplete(e); }"
                    UploadingProgressChanged="function(s, e) { UploadControl_OnUploadingProgressChanged(e); }" />
            </dx:ASPxUploadControl>
        </td>
        <td>&nbsp; 
        </td>
        <td style="vertical-align: top"></td>



    </tr>
    <tr>
        <td colspan="5">

            <b>Note</b>: The size of file selected for upload is limited to 10 MB.
        </td>


    </tr>
</table>

<dx:BootstrapGridView ID="TaskGrid" runat="server"
    ClientInstanceName="taskGrid" EnableRowsCache="false"
    AutoGenerateColumns="False"
    KeyFieldName="ID"
    DataSourceID="SqlDataSource_Payment"
    Width="500">

    <Columns>


        <dx:BootstrapGridViewTextColumn FieldName="PolicyNo"></dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewDateColumn FieldName="PaymentDate" PropertiesDateEdit-DisplayFormatString="dd/MM/yyyy"/>
   <dx:BootstrapGridViewTextColumn FieldName="IsValid"></dx:BootstrapGridViewTextColumn>
    </Columns>

</dx:BootstrapGridView>


<asp:SqlDataSource ID="SqlDataSource_Payment" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
    SelectCommand="select * from v_ImportPayment where GUID=@GUID and IsValid = 0">
    <SelectParameters>
        <asp:SessionParameter Name="GUID" SessionField="GUID" />
    </SelectParameters>

</asp:SqlDataSource>

<dx:ASPxPopupControl ID="pcProgress" runat="server" ClientInstanceName="pcProgress" Modal="True" HeaderText="Uploading"
    PopupAnimationType="None" CloseAction="None" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Width="460px"
    AllowDragging="true" ShowPageScrollbarWhenModal="True" ShowCloseButton="False" ShowFooter="True">
    <ContentCollection>
        <dx:PopupControlContentControl ID="PopupControlContentControl4" runat="server" SupportsDisabledAttribute="True">
            <table style="width: 100%;">
                <tr>
                    <td style="width: 100%;">
                        <div style="overflow: hidden; width: 280px;">
                            <dx:ASPxLabel ID="lblFileName" runat="server" ClientInstanceName="lblFileName" Text=""
                                Wrap="False">
                            </dx:ASPxLabel>
                        </div>
                    </td>
                    <td class="NoWrap" style="text-align: right">
                        <dx:ASPxLabel ID="lblCurrentUploadedFileLength" runat="server" ClientInstanceName="lblCurrentUploadedFileLength"
                            Text="" Wrap="False">
                        </dx:ASPxLabel>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" class="TopPadding">
                        <dx:ASPxProgressBar ID="ASPxProgressBar1" runat="server" Height="21px" Width="100%"
                            ClientInstanceName="progress1">
                        </dx:ASPxProgressBar>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <div class="Spacer" style="height: 12px;"></div>
                    </td>
                </tr>
                <tr>
                    <td style="width: 100%;">
                        <dx:ASPxLabel ID="lblUploadedFiles" runat="server" ClientInstanceName="lblUploadedFiles" Text=""
                            Wrap="False">
                        </dx:ASPxLabel>
                    </td>
                    <td class="NoWrap" style="text-align: right">
                        <dx:ASPxLabel ID="lblUploadedFileLength" runat="server" ClientInstanceName="lblUploadedFileLength"
                            Text="" Wrap="False">
                        </dx:ASPxLabel>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" class="TopPadding">
                        <dx:ASPxProgressBar ID="ASPxProgressBar2" runat="server" CssClass="BottomMargin" Height="21px" Width="100%"
                            ClientInstanceName="progress2">
                        </dx:ASPxProgressBar>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <div class="Spacer" style="height: 12px;"></div>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <dx:ASPxLabel ID="lblProgressStatus" runat="server" ClientInstanceName="lblProgressStatus" Text=""
                            Wrap="False">
                        </dx:ASPxLabel>
                    </td>
                </tr>
            </table>
        </dx:PopupControlContentControl>
    </ContentCollection>
    <FooterTemplate>
        <div style="overflow: hidden;">
            <dx:ASPxButton ID="btnCancel" runat="server" AutoPostBack="False" Text="Cancel" ClientInstanceName="btnCancel" Width="100px" Style="float: right">
                <ClientSideEvents Click="function(s, e) { UploadControl.Cancel(); }" />
            </dx:ASPxButton>
        </div>
    </FooterTemplate>
    <FooterStyle>
        <Paddings Padding="5px" PaddingRight="10px" />
    </FooterStyle>
</dx:ASPxPopupControl>

<dx:ASPxCallback ID="cbUploadData" runat="server" ClientInstanceName="cbUploadData">
    <ClientSideEvents
        CallbackComplete="function(s, e) { 
            taskGrid.Refresh();
            LoadingPanel.Hide();
            if(e.result !='success'){
                alert(e.result);
            }
            else{
                alert(e.result);
            }
        }" />
</dx:ASPxCallback>
