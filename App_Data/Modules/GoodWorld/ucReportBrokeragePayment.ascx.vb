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
Imports DevExpress.Web.Bootstrap
Imports DevExpress.XtraPrinting
Imports DevExpress.Export
Imports Microsoft.Reporting.WebForms


Imports DevExpress.Spreadsheet
Imports DevExpress.XtraRichEdit
Imports DevExpress.ClipboardSource.SpreadsheetML
Imports DevExpress.XtraPrintingLinks


Partial Class Modules_ucReportBrokeragePayment
    Inherits PortalModuleControl
    Protected PageName As String





    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim portalSettings As PortalSettings = CType(HttpContext.Current.Items(webconfig._PortalContextName), PortalSettings)
        If Not PortalSecurity.IsInRoles(portalSettings.ActiveTab.AuthorizedRoles, portalSettings.ActiveTab.TabId) = True Then
            Response.Redirect("~/Admin/AccessDenied.aspx")
        End If
        PageName = portalSettings.ActiveTab.TabName

    End Sub


    Protected Sub TaskGrid_ToolbarItemClick(ByVal sender As Object, ByVal e As BootstrapGridViewToolbarItemClickEventArgs) Handles TaskGrid.ToolbarItemClick

        Select Case e.Item.Name
            Case "ExportToXLS"
                TaskGrid.ExportXlsToResponse(New XlsExportOptionsEx With {.ExportType = ExportType.WYSIWYG})
            Case "ExportToXLSX"
                TaskGrid.ExportXlsxToResponse(New XlsxExportOptionsEx With {.ExportType = ExportType.WYSIWYG})
        End Select
    End Sub



    'Protected Sub ASPxGridView1_SummaryDisplayText(ByVal sender As Object, ByVal e As ASPxGridViewSummaryDisplayTextEventArgs) Handles TaskGrid.SummaryDisplayText
    '    If e.Item.FieldName = "CategoryID" Then
    '        e.Text = String.Format("Sum = {0}", Convert.ToDouble(e.Value) * Convert.ToDouble(ASPxSpinEdit1.Value))
    '    End If
    'End Sub

    Protected Sub TaskGrid_SummaryDisplayText(sender As Object, e As ASPxGridViewSummaryDisplayTextEventArgs) Handles TaskGrid.SummaryDisplayText
        If e.Item.FieldName = "AGENT" Then
            e.Text = "ผลรวมทั้งสิ้น"
        End If

    End Sub
    Protected Sub TaskGrid_HtmlFooterCellPrepared(sender As Object, e As BootstrapGridViewTableFooterCellEventArgs) Handles TaskGrid.HtmlFooterCellPrepared
        e.Cell.Font.Bold = True
    End Sub
End Class
