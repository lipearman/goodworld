Imports System.Data
Imports System.Web.Security
Imports Portal.Components
Imports LWT.Website


Imports Microsoft.VisualBasic
Imports System
Imports System.Collections
Imports System.Collections.Generic
Imports System.IO
Imports System.Web.UI
Imports DevExpress.Web
Imports DevExpress.Web.ASPxTreeList
Imports DevExpress.Web.Data
Imports DevExpress.Spreadsheet

Partial Class Modules_ucBrokeragePaymentImport
    Inherits PortalModuleControl
    Protected PageName As String
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim portalSettings As PortalSettings = CType(HttpContext.Current.Items(webconfig._PortalContextName), PortalSettings)
        If Not PortalSecurity.IsInRoles(portalSettings.ActiveTab.AuthorizedRoles, portalSettings.ActiveTab.TabId) = True Then
            Response.Redirect("~/Admin/AccessDenied.aspx")
        End If
        PageName = portalSettings.ActiveTab.TabName

    End Sub


    Protected Sub UploadControl_FileUploadComplete(ByVal sender As Object, ByVal e As FileUploadCompleteEventArgs) Handles UploadControl.FileUploadComplete
        If (Not String.IsNullOrEmpty(e.UploadedFile.FileName)) AndAlso e.IsValid Then
            ASPxSpreadsheet1.WorkDirectory = Server.MapPath("~/App_Data/UploadTemp")
            ASPxSpreadsheet1.SettingsDocumentSelector.UploadSettings.Enabled = True
            'Dim _NoticeID = Session("NoticeID")
            Session("GUID") = System.Guid.NewGuid().ToString()
            Dim filePath = Path.Combine(ASPxSpreadsheet1.WorkDirectory, String.Format("{0}.xlsx", Session("GUID")))

            e.UploadedFile.SaveAs(filePath)
            e.CallbackData = "success"
        End If
    End Sub
    Protected Sub Spreadsheet_Callback(ByVal source As Object, ByVal e As CallbackEventArgsBase) Handles ASPxSpreadsheet1.Callback
        LoadFile()
    End Sub

    Private Sub LoadFile()
        Dim documentID = Session("GUID").ToString()
        ASPxSpreadsheet1.WorkDirectory = Server.MapPath("~/App_Data/UploadTemp")
        Dim filePath = Path.Combine(ASPxSpreadsheet1.WorkDirectory, String.Format("{0}.xlsx", Session("GUID")))
        If File.Exists(filePath) Then
            ASPxSpreadsheet1.Open(documentID, DevExpress.Spreadsheet.DocumentFormat.Xlsx, Function() System.IO.File.ReadAllBytes(filePath))
        End If
    End Sub



    'Protected Sub PopupImportData_WindowCallback(ByVal source As Object, ByVal e As PopupWindowCallbackArgs) Handles PopupImportData.WindowCallback

    '    ASPxSpreadsheet1.WorkDirectory = Server.MapPath("~/App_Data/UploadTemp")
    '    Dim filePath = Path.Combine(ASPxSpreadsheet1.WorkDirectory, "blank.xlsx")
    '    If File.Exists(filePath) Then
    '        Dim documentID = System.Guid.NewGuid().ToString()
    '        ASPxSpreadsheet1.Open(documentID, DevExpress.Spreadsheet.DocumentFormat.Xlsx, Function() System.IO.File.ReadAllBytes(filePath))
    '    End If

    'End Sub


    Protected Sub btnDownloadFormat_click(ByVal sender As Object, ByVal e As EventArgs)
        Dim filePath = String.Format("{0}\{1}", Server.MapPath("~/App_Data/Template"), "ImportBrokerage.xlsx")
        Response.ClearContent()
        Response.AddHeader("content-disposition", "attachment; filename=ImportBrokerage.xlsx")
        Response.ContentType = "application/octet-stream"
        Response.WriteFile(filePath)
        Response.End()
    End Sub



    Protected Sub cbUploadData_Callback(ByVal sender As Object, ByVal e As CallbackEventArgs) Handles cbUploadData.Callback

        Dim worksheet_Summary As Worksheet = ASPxSpreadsheet1.Document.Worksheets(0)
        Dim range_Summary As Range = worksheet_Summary.GetUsedRange()
        Using dc As New DataClasses_GoodWorldExt()


            ''=============================== Summary ================================================
            Dim BrokeragePaymentRegisters As New List(Of tblBrokeragePaymentRegister)
            Dim _InsureType = (From c In dc.tblInsureTypes).ToList()

            For r As Integer = 1 To range_Summary.RowCount - 1
                'Dim _InsureTypeID As Integer = 0

                'If Not String.IsNullOrEmpty(range_Summary(r, 6).Value.TextValue) Then
                '    Dim _InsureCode = range_Summary(r, 6).Value.TextValue
                '    Dim _InsureTypeData = _InsureType.Single(Function(c) c.Code.Equals(_InsureCode))
                '    If _InsureCode IsNot Nothing Then
                '        _InsureTypeID = _InsureTypeData.ID
                '    End If
                'End If



                BrokeragePaymentRegisters.Add(New tblBrokeragePaymentRegister With {.Branchid = range_Summary(r, 0).Value.NumericValue _
                                                                , .Accountcode = range_Summary(r, 1).Value.TextValue _
                                                                , .AgentName = range_Summary(r, 2).Value.TextValue _
                                                                , .AGENT = range_Summary(r, 3).Value.TextValue _
                                                                , .MainClass = range_Summary(r, 4).Value.TextValue _
                                                                , .SubClass = range_Summary(r, 5).Value.TextValue _
                                                                , .PolicyNo = range_Summary(r, 6).Value.TextValue _
                                                                , .Dftxno = range_Summary(r, 7).Value.TextValue _
                                                                , .InsureName = range_Summary(r, 8).Value.TextValue _
                                                                , .EffectiveDate = range_Summary(r, 9).Value.DateTimeValue _
                                                                , .ExpireDate = range_Summary(r, 10).Value.DateTimeValue _
                                                                , .ApproveDate = range_Summary(r, 11).Value.DateTimeValue _
                                                                , .ReceivePremium = range_Summary(r, 12).Value.NumericValue _
                                                                , .BrokerCommAmt = range_Summary(r, 13).Value.NumericValue _
                                                                , .WageCommAmt = range_Summary(r, 14).Value.NumericValue _
                                                                , .WageOVAmt = range_Summary(r, 15).Value.NumericValue _
                                                                , .AgentCommAmt = range_Summary(r, 16).Value.NumericValue _
                                                                , .NetPayment = range_Summary(r, 17).Value.NumericValue _
                                                                , .RVDate = range_Summary(r, 18).Value.DateTimeValue _
                                                                , .BrokerSurveyAmt = range_Summary(r, 19).Value.NumericValue _
                                                                , .AA = range_Summary(r, 20).Value.NumericValue _
                                                                , .BB = range_Summary(r, 21).Value.NumericValue _
                                                                , .CreateBy = HttpContext.Current.User.Identity.Name _
                                                                , .CreateDate = Now
                                    })
            Next

            Dim sb As New StringBuilder()

            If BrokeragePaymentRegisters.Count = 0 Then
                sb.Append("No Summary or Data")
            Else

                dc.tblBrokeragePaymentRegisters.InsertAllOnSubmit(BrokeragePaymentRegisters)
                dc.SubmitChanges()


                sb.Append("success")
            End If


            e.Result = sb.ToString()
        End Using


    End Sub


    Protected Sub ASPxButton1_Click(sender As Object, e As EventArgs)
        Dim filePath = String.Format("{0}\{1}", Server.MapPath("~/App_Data/Template"), "ImportBrokerage_Example.xlsx")
        Response.ClearContent()
        Response.AddHeader("content-disposition", "attachment; filename=ImportBrokerage_Example.xlsx")
        Response.ContentType = "application/octet-stream"
        Response.WriteFile(filePath)
        Response.End()
    End Sub
End Class
