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


Partial Class Modules_ucClientPaymentRegister
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
    Protected Sub TaskNewPopup_Callback(ByVal sender As Object, ByVal e As CallbackEventArgsBase) Handles TaskNewPopup.Callback

        'If Not MyUtils.chkIDCard(newIdentityNo.Value) Then
        '    Throw New Exception("หมายเลขบัตรประชาชนไม่ถูกต้อง")
        'End If


        Dim args = e.Parameter.ToString()
        TaskNewPopup.JSProperties("cpnewtask") = args.ToLower()


        Select Case args.ToLower()
            Case "calbrokerage"
                'calbrokerage()
            Case "savenew"
                'savenew()
        End Select



    End Sub







    Protected Sub TaskEditPopup_Callback(ByVal sender As Object, ByVal e As CallbackEventArgsBase) Handles TaskEditPopup.Callback
        Dim args = e.Parameter.ToString()

        If args.ToLower().StartsWith("edit") Then
            Dim params = args.Split("|")
            Dim _ID = params(1)
            TaskEditPopup.JSProperties("cpedittask") = params(0)
            hdID.Set("ID", _ID)
            edit(_ID)
            TaskEditPopup.ShowOnPageLoad = True
        Else

            Select Case args.ToLower()
                Case "calbrokerage"
                    'calbrokerage2()
                Case "saveedit"
                    'update(hdID("ID"))
                    TaskEditPopup.JSProperties("cpedittask") = "saveedit"
            End Select


        End If





    End Sub

    Private Sub edit(ByVal _ID As String)
        Using dc As New DataClasses_GoodWorldExt()
            Dim data = (From c In dc.tblPolicyRegisters Where c.ID.Equals(_ID)).FirstOrDefault()


            BootstrapFormLayout8.DataSource = data
            BootstrapFormLayout8.DataBind()

        End Using
    End Sub




    Protected Sub TaskGrid_HtmlRowCreated(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridViewTableRowEventArgs) Handles TaskGrid.HtmlRowPrepared


        If e.RowType <> DevExpress.Web.GridViewRowType.Data Then
            Return
        End If

        Dim EditButton As BootstrapButton = TaskGrid.FindRowCellTemplateControl(e.VisibleIndex, Nothing, "EditButton")
        EditButton.JSProperties.Add("cpID", e.KeyValue().ToString())



    End Sub
End Class
