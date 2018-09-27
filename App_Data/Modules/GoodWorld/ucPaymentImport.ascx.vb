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

Partial Class Modules_ucPaymentImport
    Inherits PortalModuleControl
    Protected PageName As String

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        If Page.IsPostBack = False Then
            Session("GUID") = Nothing
        End If
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim portalSettings As PortalSettings = CType(HttpContext.Current.Items(webconfig._PortalContextName), PortalSettings)
        If Not PortalSecurity.IsInRoles(portalSettings.ActiveTab.AuthorizedRoles, portalSettings.ActiveTab.TabId) = True Then
            Response.Redirect("~/Admin/AccessDenied.aspx")
        End If
        PageName = portalSettings.ActiveTab.TabName

    End Sub


    'Protected Sub Spreadsheet_Callback(ByVal source As Object, ByVal e As CallbackEventArgsBase) Handles ASPxSpreadsheet1.Callback
    '    LoadFile()
    'End Sub

    'Private Sub LoadFile()
    '    Dim documentID = Session("GUID").ToString()
    '    ASPxSpreadsheet1.WorkDirectory = Server.MapPath("~/App_Data/UploadTemp")
    '    Dim filePath = Path.Combine(ASPxSpreadsheet1.WorkDirectory, String.Format("{0}.xlsx", Session("GUID")))
    '    If File.Exists(filePath) Then
    '        ASPxSpreadsheet1.Open(documentID, DevExpress.Spreadsheet.DocumentFormat.Xlsx, Function() System.IO.File.ReadAllBytes(filePath))
    '    End If
    'End Sub



    'Protected Sub PopupImportData_WindowCallback(ByVal source As Object, ByVal e As PopupWindowCallbackArgs) Handles PopupImportData.WindowCallback

    '    ASPxSpreadsheet1.WorkDirectory = Server.MapPath("~/App_Data/UploadTemp")
    '    Dim filePath = Path.Combine(ASPxSpreadsheet1.WorkDirectory, "blank.xlsx")
    '    If File.Exists(filePath) Then
    '        Dim documentID = System.Guid.NewGuid().ToString()
    '        ASPxSpreadsheet1.Open(documentID, DevExpress.Spreadsheet.DocumentFormat.Xlsx, Function() System.IO.File.ReadAllBytes(filePath))
    '    End If

    'End Sub


    Protected Sub btnDownloadFormat_click(ByVal sender As Object, ByVal e As EventArgs)
        Dim filePath = String.Format("{0}\{1}", Server.MapPath("~/App_Data/Template"), "ImportPayment.xlsx")
        Response.ClearContent()
        Response.AddHeader("content-disposition", "attachment; filename=ImportPayment.xlsx")
        Response.ContentType = "application/octet-stream"
        Response.WriteFile(filePath)
        Response.End()
    End Sub

    Protected Sub ASPxButton1_Click(sender As Object, e As EventArgs)
        Dim filePath = String.Format("{0}\{1}", Server.MapPath("~/App_Data/Template"), "ImportPayment_Example.xlsx")
        Response.ClearContent()
        Response.AddHeader("content-disposition", "attachment; filename=ImportPayment_Example.xlsx")
        Response.ContentType = "application/octet-stream"
        Response.WriteFile(filePath)
        Response.End()
    End Sub


    Protected Sub UploadControl_FileUploadComplete(ByVal sender As Object, ByVal e As FileUploadCompleteEventArgs) Handles UploadControl.FileUploadComplete
        If (Not String.IsNullOrEmpty(e.UploadedFile.FileName)) AndAlso e.IsValid Then
            Session("GUID") = System.Guid.NewGuid().ToString()
            Dim filePath = Path.Combine(Server.MapPath("~/App_Data/UploadTemp"), String.Format("{0}.xlsx", Session("GUID")))

            e.UploadedFile.SaveAs(filePath)
            e.CallbackData = "success"
        End If
    End Sub
    Protected Sub cbUploadData_Callback(ByVal sender As Object, ByVal e As CallbackEventArgs) Handles cbUploadData.Callback
        Dim ASPxSpreadsheet1 As New ASPxSpreadsheet.ASPxSpreadsheet()
        Dim _GUID = Session("GUID")
        Dim filePath = Path.Combine(Server.MapPath("~/App_Data/UploadTemp"), String.Format("{0}.xlsx", _GUID))
        ASPxSpreadsheet1.Open(filePath)
        Dim worksheet_Summary As Worksheet = ASPxSpreadsheet1.Document.Worksheets(0)
        Dim range_Summary As Range = worksheet_Summary.GetUsedRange()
        Using dc As New DataClasses_GoodWorldExt()


            ''=============================== Summary ================================================
            Dim PaymentDates As New List(Of tmpPaymentDate)

            For r As Integer = 1 To range_Summary.RowCount - 1
                '0 เบอร์กรมธรรม์   
                '1 ชื่อผู้เอาประกันภัย	
                '2 บริษัทประกันภัย	
                '3 วันที่จ่าย

                If range_Summary(r, 0) IsNot Nothing Then
                    PaymentDates.Add(New tmpPaymentDate With {.PolicyNo = range_Summary(r, 0).Value.TextValue _
                                                               , .PaymentDate = range_Summary(r, 3).Value.DateTimeValue _
                                                               , .GUID = _GUID
                                    })
                End If

            Next

            Dim sb As New StringBuilder()

            If PaymentDates.Count = 0 Then
                sb.Append("No Policy")
            Else
                dc.tmpPaymentDates.InsertAllOnSubmit(PaymentDates)
                dc.SubmitChanges()

                Dim chk = (From c In dc.v_ImportPayments Where c.GUID.Equals(_GUID) And c.IsValid.Equals(0)).ToList()
                If chk.Count = 0 Then
                    'Todo
                    'Update
                    dc.ExecuteCommand("update tblPolicyRegister set tblPolicyRegister.PaymentDate=tmpPaymentDate.PaymentDate FROM tmpPaymentDate inner join tblPolicyRegister on tblPolicyRegister.PolicyNo = tmpPaymentDate.PolicyNo where tmpPaymentDate.GUID={0}", _GUID)
                    'Clear
                    dc.ExecuteCommand("delete from tmpPaymentDate where GUID={0}", _GUID)
                    sb.Append("success")
                Else
                    sb.Append("Invalid Policy")
                End If
            End If


            e.Result = sb.ToString()
        End Using


    End Sub


End Class
