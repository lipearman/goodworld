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

Partial Class Modules_ucUWBillingRegister
    Inherits PortalModuleControl
    Protected PageName As String
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim portalSettings As PortalSettings = CType(HttpContext.Current.Items(webconfig._PortalContextName), PortalSettings)
        If Not PortalSecurity.IsInRoles(portalSettings.ActiveTab.AuthorizedRoles, portalSettings.ActiveTab.TabId) = True Then
            Response.Redirect("~/Admin/AccessDenied.aspx")
        End If
        PageName = portalSettings.ActiveTab.TabName

        Session("PortalId") = webconfig._PortalID


    End Sub

    Protected Sub TaskGrid_ToolbarItemClick(ByVal sender As Object, ByVal e As BootstrapGridViewToolbarItemClickEventArgs) Handles taskGrid.ToolbarItemClick

        Select Case e.Item.Name
            Case "ExportToXLS"
                taskGrid.ExportXlsToResponse(New XlsExportOptionsEx With {.ExportType = ExportType.WYSIWYG})
            Case "ExportToXLSX"
                taskGrid.ExportXlsxToResponse(New XlsxExportOptionsEx With {.ExportType = ExportType.WYSIWYG})
        End Select
    End Sub
    Protected Sub TaskGrid_HtmlRowCreated(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridViewTableRowEventArgs) Handles taskGrid.HtmlRowPrepared
        If e.RowType <> DevExpress.Web.GridViewRowType.Data Then
            Return
        End If
        Dim EditButton As BootstrapButton = taskGrid.FindRowCellTemplateControl(e.VisibleIndex, Nothing, "EditButton")
        EditButton.JSProperties.Add("cpID", e.KeyValue().ToString())
    End Sub
    Protected Sub AddUWBilling_Click(sender As Object, e As EventArgs) Handles AddUWBilling.Click
        Dim _Code = InsurerFilter.Value
        Dim _BillingDate = UWBillingDate.Value

        Using dc As New DataClasses_GoodWorldExt()


            Dim _newData As New tblUWBillingRegister
            With _newData

                .InsurerCode = _Code
                .BillingDate = _BillingDate
                .CreateDate = Now
                .CreateBy = HttpContext.Current.User.Identity.Name

            End With

            dc.tblUWBillingRegisters.InsertOnSubmit(_newData)
            dc.SubmitChanges()

        End Using

        InsurerFilter.Text = ""
        UWBillingDate.Value = Nothing

        TaskGrid.DataBind()
    End Sub

End Class
