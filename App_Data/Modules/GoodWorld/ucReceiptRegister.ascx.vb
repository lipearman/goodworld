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

Partial Class Modules_ucReceiptRegister
    Inherits PortalModuleControl
    Protected PageName As String
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim portalSettings As PortalSettings = CType(HttpContext.Current.Items(webconfig._PortalContextName), PortalSettings)
        If Not PortalSecurity.IsInRoles(portalSettings.ActiveTab.AuthorizedRoles, portalSettings.ActiveTab.TabId) = True Then
            Response.Redirect("~/Admin/AccessDenied.aspx")
        End If
        PageName = portalSettings.ActiveTab.TabName
        Session("PortalId") = webconfig._PortalID


        SqlDataSource_ReceiptRegister.UpdateParameters("UserName").DefaultValue = HttpContext.Current.User.Identity.Name
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
        Select Case args.ToLower()
            Case "savenew"
                savenew()
        End Select
    End Sub

    Private Sub savenew()
        Try
            Using dc As New DataClasses_GoodWorldExt()

                Dim chkDup = (From c In dc.tblReceiptRegisters Where c.ReceiptNo.Equals(newReceiptNo.Value)).FirstOrDefault()
                If chkDup IsNot Nothing Then
                    Throw New Exception(String.Format("หมายเลขใบกำกับภาษี {0} นี้มีในระบบแล้ว", newReceiptNo.Value))
                End If

                Dim _newReceiptRegister As New tblReceiptRegister
                With _newReceiptRegister
                    .ReceiptNo = newReceiptNo.Value
                    .InsurerCode = newInsurerCode.Value
                    .ReceiveDate = newReceiveDate.Value
                    .TaxNo = newTaxNo.Value
                    .ReceiveType = newReceiveType.Value
                    .Brach = newBranch.Value

                    .Address1 = newAddress1.Value
                    .Address2 = newAddress2.Value
                    .Address3 = newAddress3.Value

                    .ChequeNo = newChequeNo.Value
                    .ChequeBranch = newChequeBranch.Value


                    .CreateBy = HttpContext.Current.User.Identity.Name
                    .CreateDate = Now
                End With

                dc.tblReceiptRegisters.InsertOnSubmit(_newReceiptRegister)
                dc.SubmitChanges()

                TaskNewPopup.JSProperties("cpnewtask") = "savenew"
            End Using
        Catch ex As Exception
            TaskNewPopup.JSProperties("cpnewtask") = "error - " & ex.Message
        End Try

    End Sub

    Protected Sub TaskGrid_HtmlRowCreated(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridViewTableRowEventArgs) Handles TaskGrid.HtmlRowPrepared
        If e.RowType <> DevExpress.Web.GridViewRowType.Data Then
            Return
        End If
        Dim EditButton As BootstrapButton = TaskGrid.FindRowCellTemplateControl(e.VisibleIndex, Nothing, "EditButton")
        EditButton.JSProperties.Add("cpID", e.KeyValue().ToString())
    End Sub
    Protected Sub AddReceipt_Click(sender As Object, e As EventArgs) Handles AddReceipt.Click
        Dim _Code = InsurerFilter.Value
        InsurerFilter.Text = ""
        newReceiptData(_Code)
        TaskNewPopup.ShowOnPageLoad = True
    End Sub
    Private Sub newReceiptData(ByVal _Code As String)
        Using dc As New DataClasses_GoodWorldExt()
            Dim data = (From c In dc.tblInsurers Where c.InsurerCode.Equals(_Code)).FirstOrDefault()

            newInsurerCode.Value = data.InsurerCode
            newInsurerName.Value = data.InsurerName
            newTaxNo.Value = data.CertificateNo
            newAddress1.Value = data.Address1
            newAddress2.Value = data.Address2
            newAddress3.Value = data.Address3
            newBranch.Value = data.BranchCode

        End Using
    End Sub



    Protected Sub TaskEditPopup_Callback(ByVal sender As Object, ByVal e As CallbackEventArgsBase) Handles TaskEditPopup.WindowCallback
        Dim args = e.Parameter.ToString()

        If args.ToLower().StartsWith("edit") Then
            Dim params = args.Split("|")
            Dim _ID = params(1)
            TaskEditPopup.JSProperties("cpedittask") = params(0)
            hdID.Set("ID", _ID)
            Session("ReceiptID") = _ID
            edit(_ID)
            TaskEditPopup.ShowOnPageLoad = True
        Else

            Select Case args.ToLower()
                Case "calpremium"

                Case "saveedit"
                    update(hdID("ID"))
                    TaskEditPopup.JSProperties("cpedittask") = "saveedit"
            End Select


        End If





    End Sub

    Private Sub update(ByVal _ID As String)
        Try
            Using dc As New DataClasses_GoodWorldExt()

                Dim data = (From c In dc.tblPaymentRegisters Where c.ID.Equals(_ID)).FirstOrDefault()


                With data

                    '.PaymentBy = editPaymentBy.Value
                    '.PaymentDate = editPaymentDate.Value
                    '.PaymentNo = editPaymentNo.Value

                    '.BRCommP = editBrokerage.Value
                    '.BRCommAmt = editBrokerageAmt.Value

                    '.VAT7Amt = editVAT7Amt.Value
                    '.TAX3Amt = editTAX3Amt.Value

                    '.ServiceFreeP = editServiceFreeP.Value
                    '.ServiceFreeAmt = editServiceFreeAmt.Value
                    '.ServiceFreeTAX3Amt = editServiceFreeTAX3Amt.Value
                    '.ServiceFreeVAT7Amt = editServiceFreeVAT7Amt.Value
                    '.TotalPremium = editTotalPremium.Value

                    .ModifyDate = DateTime.Now
                    .ModifyBy = HttpContext.Current.User.Identity.Name


                End With

                dc.SubmitChanges()

                TaskNewPopup.JSProperties("cpedittask") = "saveedit"



            End Using
        Catch ex As Exception
            TaskNewPopup.JSProperties("cpedittask") = "error - " & ex.Message
        End Try

    End Sub




    Private Sub edit(ByVal _ID As String)
        Using dc As New DataClasses_GoodWorldExt()
            Dim data = (From c In dc.v_ReceiptRegisters Where c.ID.Equals(_ID)).FirstOrDefault()


            'formPreview.DataSource = data
            'formPreview.DataBind()

            With data
                editReceiptNo.Value = .ReceiptNo
                editInsurerCode.Value = .InsurerCode
                editInsurerName.Value = .ReceiveDate.Value.ToString("dd/MM/yyyy")
                editTaxNo.Value = .TaxNo
                editReceiveType.Value = .ReceiveType
                editBranchName.Value = .BrachName
                editAddress1.Value = .Address1
                editAddress2.Value = .Address2
                editAddress3.Value = .Address3
                editChequeNo.Value = .ChequeNo
                editChequeBranch.Value = .ChequeBranch



            End With


            grid_ReceiptDetails.DataBind()
            grid_ReceiptPremium.DataBind()
        End Using
    End Sub



    Protected Sub btnPreview_Click(sender As Object, e As EventArgs)
        Dim _ReceiptID = CInt(hdID("ID"))

        edit(_ReceiptID)

        Using dc As New DataClasses_GoodWorldExt()

            Dim _ReceiptRegisters = (From c In dc.v_ReceiptRegisters Where c.ID.Equals(_ReceiptID)).FirstOrDefault()


            Dim sb As New StringBuilder()
            sb.Append(" SELECT * ")
            sb.Append(" FROM tblReceiptDetails ")
            sb.AppendFormat(" where ReceiptID='{0}' ", _ReceiptRegisters.ID)
            Dim ds1 = SqlHelper.ExecuteDataset(ConfigurationManager.ConnectionStrings("PortalConnectionString").ConnectionString, System.Data.CommandType.Text, sb.ToString())

            sb = New StringBuilder()
            sb.Append(" SELECT * ")
            sb.Append(" FROM tblReceiptPremium ")
            sb.AppendFormat(" where ReceiptID='{0}' ", _ReceiptRegisters.ID)
            Dim ds2 = SqlHelper.ExecuteDataset(ConfigurationManager.ConnectionStrings("PortalConnectionString").ConnectionString, System.Data.CommandType.Text, sb.ToString())


            Dim ReportViewer1 As New ReportViewer()
            Dim ReportFile As String = "rptReceipt1.rdl"
            ReportViewer1.Reset()
            ReportViewer1.LocalReport.Dispose()
            ReportViewer1.LocalReport.DataSources.Clear()
            ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/App_Data/reports/" & ReportFile)
            ReportViewer1.LocalReport.DataSources.Add(New ReportDataSource("DataSet1", ds1.Tables(0)))
            ReportViewer1.LocalReport.DataSources.Add(New ReportDataSource("DataSet2", ds2.Tables(0)))


            'CustomerName
            ReportViewer1.LocalReport.SetParameters(New ReportParameter("CustomerName", _ReceiptRegisters.InsurerName))
            'Address
            ReportViewer1.LocalReport.SetParameters(New ReportParameter("Address", String.Format("{0} {1} {2}", _ReceiptRegisters.Address1, _ReceiptRegisters.Address2, _ReceiptRegisters.Address3)))

            'ReceiptNo
            ReportViewer1.LocalReport.SetParameters(New ReportParameter("ReceiptNo", _ReceiptRegisters.ReceiptNo))
            'TaxNo
            ReportViewer1.LocalReport.SetParameters(New ReportParameter("TaxNo", _ReceiptRegisters.TaxNo))
            'BranchText
            If _ReceiptRegisters.BrachCode.Equals("HO") Then
                ReportViewer1.LocalReport.SetParameters(New ReportParameter("BranchText", "[X] สำนักงานใหญ่      [_] สาขา"))
            Else
                ReportViewer1.LocalReport.SetParameters(New ReportParameter("BranchText", "[_] สำนักงานใหญ่      [X] สาขา"))
            End If

            'TotalAmountText
            Dim _TotalPremium = (From c In dc.tblReceiptPremiums Where c.ReceiptID.Equals(_ReceiptID) Select c.ReceiptPremium).Sum()
            ReportViewer1.LocalReport.SetParameters(New ReportParameter("TotalAmountText", MyUtils.NumberToThaiWord(_TotalPremium + (_TotalPremium * 0.07))))

            'DatePrint
            ReportViewer1.LocalReport.SetParameters(New ReportParameter("DatePrint", MyUtils.GenThaiDate(Now(), 2)))

            'ChequeText
            If _ReceiptRegisters.ReceiveCode.Equals("CH") Then
                ReportViewer1.LocalReport.SetParameters(New ReportParameter("ChequeText", String.Format("[X] {0}    เลขที่ {1}             สาขา {2}", _ReceiptRegisters.ReceiveType, _ReceiptRegisters.ChequeNo, _ReceiptRegisters.ChequeBranch)))
            Else
                ReportViewer1.LocalReport.SetParameters(New ReportParameter("ChequeText", String.Format("[X] {0}", _ReceiptRegisters.ReceiveType)))
            End If


            ReportViewer1.LocalReport.Refresh()


            Dim warnings As Warning()
            Dim streamids As String()
            Dim mimeType As String
            Dim encoding As String
            Dim extension As String
            Dim bytes As Byte() = ReportViewer1.LocalReport.Render("PDF", Nothing, mimeType, encoding, extension, streamids, warnings)

            Dim _GUID = System.Guid.NewGuid().ToString()
            Session("GUID") = _GUID

            Dim FileName = Server.MapPath(String.Format("~/App_Data/UploadTemp/{0}.pdf", _GUID))

            Using fs As FileStream = New FileStream(FileName, FileMode.Create)
                fs.Write(bytes, 0, bytes.Length)
                fs.Close()
            End Using

            clientReportPreview.ShowOnPageLoad() = True

            'Spreadsheet.Open(FileName)



            documentViewer.Document = String.Format("~/App_Data/UploadTemp/{0}.pdf", _GUID)
        End Using
    End Sub

End Class
