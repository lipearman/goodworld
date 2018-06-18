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

Partial Class Modules_ucPolicyImport
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
        Dim filePath = String.Format("{0}\{1}", Server.MapPath("~/App_Data/Template"), "ImportPolicy.xlsx")
        Response.ClearContent()
        Response.AddHeader("content-disposition", "attachment; filename=ImportPolicy.xlsx")
        Response.ContentType = "application/octet-stream"
        Response.WriteFile(filePath)
        Response.End()
    End Sub



    Protected Sub cbUploadData_Callback(ByVal sender As Object, ByVal e As CallbackEventArgs) Handles cbUploadData.Callback

        Dim worksheet_Summary As Worksheet = ASPxSpreadsheet1.Document.Worksheets(0)
        Dim range_Summary As Range = worksheet_Summary.GetUsedRange()
        Using dc As New DataClasses_GoodWorldExt()


            ''=============================== Summary ================================================
            Dim PolicyRegisters As New List(Of tblPolicyRegister)
            Dim _InsureType = (From c In dc.tblInsureTypes).ToList()

            For r As Integer = 1 To range_Summary.RowCount - 1
                'Insurer Code
                'Agent ID.
                'เลขที่กรมธรรม์
                'ชื่อผู้เอาประกันภัย
                'วันเริ่มคุ้มครอง
                'วันสิ้นสุด
                'ประเภทประกันภัย
                'ทะเบียนรถ
                'เลขตัวถัง
                'จำนวนเงินเอาประกัน
                'เบี้ยสุทธิ
                'อากร
                'ภาษี
                'เบี้ยรวม

                Dim _InsureTypeID As Integer = 0

                If Not String.IsNullOrEmpty(range_Summary(r, 6).Value.TextValue) Then
                    Dim _InsureCode = range_Summary(r, 6).Value.TextValue
                    Dim _InsureTypeData = _InsureType.Single(Function(c) c.Code.Equals(_InsureCode))
                    If _InsureCode IsNot Nothing Then
                        _InsureTypeID = _InsureTypeData.ID
                    End If
                End If



                PolicyRegisters.Add(New tblPolicyRegister With {.InsurerCode = range_Summary(r, 0).Value.TextValue _
                                                                , .AgentCode = range_Summary(r, 1).Value.TextValue _
                                                                , .PolicyNo = range_Summary(r, 2).Value.TextValue _
                                                                , .ClientName = range_Summary(r, 3).Value.TextValue _
                                                                , .EffectiveDate = range_Summary(r, 4).Value.DateTimeValue _
                                                                , .ExpiredDate = range_Summary(r, 5).Value.DateTimeValue _
                                                                , .InsureType = _InsureTypeID _
                                                                , .CarLicensePlate = range_Summary(r, 7).Value.TextValue _
                                                                , .Chassis = range_Summary(r, 8).Value.TextValue _
                                                                , .Suminsured = range_Summary(r, 9).Value.NumericValue _
                                                                , .Premium = range_Summary(r, 10).Value.NumericValue _
                                                                , .Stamp = range_Summary(r, 11).Value.NumericValue _
                                                                , .Vat = range_Summary(r, 12).Value.NumericValue _
                                                                , .GrossPremium = range_Summary(r, 13).Value.NumericValue _
                                                                , .Status = 1 _
                                                                , .CreateBy = HttpContext.Current.User.Identity.Name _
                                                                , .CreateDate = Now
                                    })
            Next

            Dim sb As New StringBuilder()

            If PolicyRegisters.Count = 0 Then
                sb.Append("No Summary or Data")
            Else

                dc.tblPolicyRegisters.InsertAllOnSubmit(PolicyRegisters)
                dc.SubmitChanges()


                sb.Append("success")
            End If


            e.Result = sb.ToString()
        End Using


    End Sub


    Protected Sub ASPxButton1_Click(sender As Object, e As EventArgs)
        Dim filePath = String.Format("{0}\{1}", Server.MapPath("~/App_Data/Template"), "ImportPolicy_Example.xlsx")
        Response.ClearContent()
        Response.AddHeader("content-disposition", "attachment; filename=ImportPolicy_Example.xlsx")
        Response.ContentType = "application/octet-stream"
        Response.WriteFile(filePath)
        Response.End()
    End Sub
End Class
