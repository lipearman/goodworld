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

Partial Class Modules_ucClaimRegister
    Inherits PortalModuleControl
    Protected PageName As String
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim portalSettings As PortalSettings = CType(HttpContext.Current.Items(webconfig._PortalContextName), PortalSettings)
        If Not PortalSecurity.IsInRoles(portalSettings.ActiveTab.AuthorizedRoles, portalSettings.ActiveTab.TabId) = True Then
            Response.Redirect("~/Admin/AccessDenied.aspx")
        End If
        PageName = portalSettings.ActiveTab.TabName

    End Sub

    Protected Sub TaskGrid_HtmlRowCreated(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridViewTableRowEventArgs) Handles TaskGrid.HtmlRowPrepared
        If e.RowType <> DevExpress.Web.GridViewRowType.Data Then
            Return
        End If
        Dim EditButton As BootstrapButton = TaskGrid.FindRowCellTemplateControl(e.VisibleIndex, Nothing, "EditButton")
        EditButton.JSProperties.Add("cpID", e.KeyValue().ToString())
    End Sub
    Protected Sub TaskGrid_ToolbarItemClick(ByVal sender As Object, ByVal e As BootstrapGridViewToolbarItemClickEventArgs) Handles TaskGrid.ToolbarItemClick
        Select Case e.Item.Name
            Case "ExportToXLS"
                TaskGrid.ExportXlsToResponse(New XlsExportOptionsEx With {.ExportType = ExportType.WYSIWYG})
            Case "ExportToXLSX"
                TaskGrid.ExportXlsxToResponse(New XlsxExportOptionsEx With {.ExportType = ExportType.WYSIWYG})
        End Select
    End Sub
    Protected Sub TaskNewPopup_Callback(ByVal sender As Object, ByVal e As CallbackEventArgsBase) Handles TaskNewPopup.Callback
        Dim args = e.Parameter.ToString()
        TaskNewPopup.JSProperties("cpnewtask") = args.ToLower()
        Select Case args.ToLower()
            Case "calbrokerage"

            Case "savenew"
                savenew()
        End Select
    End Sub

    Private Sub savenew()
        Try
            Using dc As New DataClasses_GoodWorldExt()

                Dim newData As New tblClaimRegister
                With newData

                    Dim data = dc.tblPolicyRegisters.SingleOrDefault(Function(c) c.ID.Equals(newPolicyId.Value))
                    If data IsNot Nothing Then
                        .PolicyId = data.ID
                        .FirstName = data.FirstName
                        .LastName = data.LastName
                        .CarLicensePlate = data.CarLicensePlate
                        .GrossPremium = data.GrossPremium
                        .EffectiveDate = data.EffectiveDate
                        .ExpiredDate = data.ExpiredDate
                        .PolicyNo = data.PolicyNo
                    End If

                    .ClaimNo = newClaimNo.Value
                    .ClaimAmount = newClaimAmount.Value
                    .AccidentDate = newAccidentDate.Value
                    .AccidentType = newAccidentType.Value
                    .AccisentPlace = newAccisentPlace.Value
                    .IsRight = newIsRight.Checked

                    .CreateDate = DateTime.Now
                    .CreateBy = HttpContext.Current.User.Identity.Name

                End With


                dc.tblClaimRegisters.InsertOnSubmit(newData)
                dc.SubmitChanges()



            End Using
        Catch ex As Exception
            TaskNewPopup.JSProperties("cpnewtask") = ex.Message
        End Try


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

                Case "saveedit"
                    update(hdID("ID"))
            End Select


        End If

    End Sub

    Private Sub edit(ByVal _ID As String)
        Using dc As New DataClasses_GoodWorldExt()
            Dim data = (From c In dc.tblClaimRegisters Where c.ID.Equals(_ID)).FirstOrDefault()

            BootstrapFormEdit1.DataSource = data
            BootstrapFormEdit1.DataBind()


            editCreateBy.Value = String.Format("{0} {1}", data.CreateBy, data.CreateDate)
            editModifyBy.Value = String.Format("{0} {1}", data.ModifyBy, data.ModifyDate)

        End Using
    End Sub
    Private Sub update(ByVal _ID As String)
        Try
            Using dc As New DataClasses_GoodWorldExt()

                Dim data = (From c In dc.tblClaimRegisters Where c.ID.Equals(_ID)).FirstOrDefault()

                With data
                    Dim data_Pol = dc.tblPolicyRegisters.SingleOrDefault(Function(c) c.ID.Equals(editPolicyId.Value))
                    If data_Pol IsNot Nothing Then
                        .PolicyId = data_Pol.ID
                        .FirstName = data_Pol.FirstName
                        .LastName = data_Pol.LastName
                        .CarLicensePlate = data_Pol.CarLicensePlate
                        .GrossPremium = data_Pol.GrossPremium
                        .EffectiveDate = data_Pol.EffectiveDate
                        .ExpiredDate = data_Pol.ExpiredDate
                        .PolicyNo = data_Pol.PolicyNo
                    End If

                    .ClaimNo = editClaimNo.Value
                    .ClaimAmount = editClaimAmount.Value
                    .AccidentDate = editAccidentDate.Value
                    .AccidentType = editAccidentType.Value
                    .AccisentPlace = editAccisentPlace.Value
                    .IsRight = editIsRight.Checked

                    .ModifyDate = DateTime.Now
                    .ModifyBy = HttpContext.Current.User.Identity.Name
                End With


                dc.SubmitChanges()


                TaskEditPopup.JSProperties("cpedittask") = "saveedit"
            End Using
        Catch ex As Exception
            TaskEditPopup.JSProperties("cpedittask") = ex.Message
        End Try

    End Sub


End Class
