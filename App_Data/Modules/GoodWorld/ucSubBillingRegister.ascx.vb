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

Partial Class Modules_ucSubBillingRegister
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
    Protected Sub TaskGrid_ToolbarItemClick(ByVal sender As Object, ByVal e As BootstrapGridViewToolbarItemClickEventArgs) Handles TaskGrid.ToolbarItemClick

        Select Case e.Item.Name
            Case "ExportToXLS"
                TaskGrid.ExportXlsToResponse(New XlsExportOptionsEx With {.ExportType = ExportType.WYSIWYG})
            Case "ExportToXLSX"
                TaskGrid.ExportXlsxToResponse(New XlsxExportOptionsEx With {.ExportType = ExportType.WYSIWYG})
        End Select
    End Sub




    Protected Sub TaskGrid_HtmlRowCreated(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridViewTableRowEventArgs) Handles TaskGrid.HtmlRowPrepared
        If e.RowType <> DevExpress.Web.GridViewRowType.Data Then
            Return
        End If
        Dim EditButton As BootstrapButton = TaskGrid.FindRowCellTemplateControl(e.VisibleIndex, Nothing, "EditButton")
        EditButton.JSProperties.Add("cpID", e.KeyValue().ToString())
    End Sub

    Protected Sub AddSubBilling_Click(sender As Object, e As EventArgs) Handles AddSubBilling.Click
        Dim _AgentCode = SubAgentFilter.Value
        Dim _BillingDate = SubBillingDate.Value

        Using dc As New DataClasses_GoodWorldExt()


            Dim _newData As New tblSubBillingRegister
            With _newData

                .AgentCode = _AgentCode
                .BillingDate = _BillingDate
                .CreateDate = Now
                .CreateBy = HttpContext.Current.User.Identity.Name

            End With

            dc.tblSubBillingRegisters.InsertOnSubmit(_newData)
            dc.SubmitChanges()

        End Using

        SubAgentFilter.Text = ""
        SubBillingDate.Value = Nothing

        TaskGrid.DataBind()
    End Sub






    Protected Sub TaskEditPopup_Callback(ByVal sender As Object, ByVal e As CallbackEventArgsBase) Handles TaskEditPopup.WindowCallback
        Dim args = e.Parameter.ToString()

        If args.ToLower().StartsWith("edit") Then
            Dim params = args.Split("|")
            Dim _ID = params(1)
            TaskEditPopup.JSProperties("cpedittask") = params(0)
            hdID.Set("ID", _ID)
            Session("SubBillingID") = _ID
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

    Private Sub edit(ByVal _ID As String)
        Using dc As New DataClasses_GoodWorldExt()
            Dim data = (From c In dc.v_SubBillingRegisters Where c.ID.Equals(_ID)).FirstOrDefault()


            formPreview.DataSource = data
            formPreview.DataBind()

            grid_SubBillingDetails.DataBind()
            grid_SubBillingPremium.DataBind()
        End Using
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

                TaskEditPopup.JSProperties("cpedittask") = "saveedit"



            End Using
        Catch ex As Exception
            TaskEditPopup.JSProperties("cpedittask") = "error - " & ex.Message
        End Try

    End Sub

    Protected Sub btnPreview_Click(sender As Object, e As EventArgs)
        Dim _SubBillingID = CInt(hdID("ID"))

        edit(_SubBillingID)



        Dim sb As New StringBuilder()
        sb.Append(" SELECT * ")
        sb.Append(" FROM v_SubBillingDetails ")
        sb.AppendFormat(" where SubBillingID='{0}' ", _SubBillingID)
        Dim ds1 = SqlHelper.ExecuteDataset(ConfigurationManager.ConnectionStrings("PortalConnectionString").ConnectionString, System.Data.CommandType.Text, sb.ToString())

        sb = New StringBuilder()
        sb.Append(" SELECT * ")
        sb.Append(" FROM tblSubBillingPremium ")
        sb.AppendFormat(" where SubBillingID='{0}' ", _SubBillingID)
        Dim ds2 = SqlHelper.ExecuteDataset(ConfigurationManager.ConnectionStrings("PortalConnectionString").ConnectionString, System.Data.CommandType.Text, sb.ToString())


        Dim ReportViewer1 As New ReportViewer()
        Dim ReportFile As String = "rptSubBilling.rdl"
        ReportViewer1.Reset()
        ReportViewer1.LocalReport.Dispose()
        ReportViewer1.LocalReport.DataSources.Clear()
        ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/App_Data/reports/" & ReportFile)
        ReportViewer1.LocalReport.DataSources.Add(New ReportDataSource("DataSet1", ds1.Tables(0)))
        ReportViewer1.LocalReport.DataSources.Add(New ReportDataSource("DataSet2", ds2.Tables(0)))



        ReportViewer1.LocalReport.Refresh()


        Dim warnings As Warning()
        Dim streamids As String()
        Dim mimeType As String
        Dim encoding As String
        Dim extension As String
        Dim bytes As Byte() = ReportViewer1.LocalReport.Render("Excel", Nothing, mimeType, encoding, extension, streamids, warnings)

        Dim _GUID = System.Guid.NewGuid().ToString()
        Session("GUID") = _GUID

        Dim FileName = Server.MapPath(String.Format("~/App_Data/UploadTemp/{0}.xls", _GUID))

        Using fs As FileStream = New FileStream(FileName, FileMode.Create)
            fs.Write(bytes, 0, bytes.Length)
            fs.Close()
        End Using

        clientReportPreview.ShowOnPageLoad() = True

        'documentViewer.Document = String.Format("~/App_Data/UploadTemp/{0}.xls", _GUID)

        clientReportPreview.ShowOnPageLoad() = True

        Spreadsheet.Open(FileName)


    End Sub
    Protected Sub btnExport_Click(sender As Object, e As EventArgs) Handles btnExport.Click
        Dim FileName = Server.MapPath(String.Format("~/App_Data/UploadTemp/{0}.xls", Session("GUID").ToString()))

        Page.Response.Clear()
        Page.Response.Buffer = False
        Page.Response.AppendHeader("Content-Type", "application/vnd.ms-excel")
        Page.Response.AppendHeader("content-disposition", "attachment; filename=myfile.xls")
        Page.Response.BinaryWrite(StreamFile(FileName))
        Page.Response.End()
    End Sub
    Private Function StreamFile(ByVal filename As String) As Byte()
        Dim ImageData As Byte() = New Byte(-1) {}
        Dim fs As FileStream = New FileStream(filename, FileMode.Open, FileAccess.Read)
        Try
            ImageData = New Byte(fs.Length - 1) {}
            fs.Read(ImageData, 0, System.Convert.ToInt32(fs.Length))
        Catch ex As Exception
            Throw ex
        Finally
            If fs IsNot Nothing Then
                fs.Close()
            End If
        End Try

        Return ImageData
    End Function



    Protected Sub PolicyNo_ItemRequestedByValue(source As Object, e As ListEditItemRequestedByValueEventArgs) Handles PolicyNoFilter.ItemRequestedByValue
        Dim value As Long = 0
        If e.Value Is Nothing Then
            Return
        End If
        Dim comboBox As ASPxComboBox = CType(source, ASPxComboBox)
        SqlDataSource1.SelectCommand = "select ClientName from v_Report1 where v_Report1.ID not in (select PolicyID from tblSubBillingPolicy) and PolicyNo <> '' and  PolicyNo like @PolicyNo and isnull(PolicyNo,'') <> ''"

        SqlDataSource1.SelectParameters.Clear()
        SqlDataSource1.SelectParameters.Add("PolicyNo", TypeCode.String, e.Value.ToString())
        comboBox.DataSource = SqlDataSource1
        comboBox.DataBind()
    End Sub
    Protected Sub PolicyNo_ItemsRequestedByFilterCondition(source As Object, e As ListEditItemsRequestedByFilterConditionEventArgs) Handles PolicyNoFilter.ItemsRequestedByFilterCondition
        Dim comboBox As ASPxComboBox = CType(source, ASPxComboBox)

        Dim sb As New StringBuilder()
        sb.Append(" SELECT st.* ")
        sb.Append(" FROM (")
        sb.Append(" select v_Report1.* ")
        sb.Append(" , row_number()over(order by v_Report1.PolicyNo) as [rn] ")
        sb.Append(" from v_Report1 ")
        sb.Append(" where v_Report1.ID not in (select PolicyID from tblSubBillingPolicy) and PolicyNo <> '' and PolicyNo LIKE @filter and isnull(PolicyNo,'') <> '' ")
        sb.Append(" ) as st ")
        sb.Append(" where st.[rn] between @startIndex and @endIndex")

        SqlDataSource1.SelectCommand = sb.ToString()

        SqlDataSource1.SelectParameters.Clear()
        SqlDataSource1.SelectParameters.Add("filter", TypeCode.String, String.Format("%{0}%", e.Filter))
        SqlDataSource1.SelectParameters.Add("startIndex", TypeCode.Int64, (e.BeginIndex + 1).ToString())
        SqlDataSource1.SelectParameters.Add("endIndex", TypeCode.Int64, (e.EndIndex + 1).ToString())
        comboBox.DataSource = SqlDataSource1
        comboBox.DataBind()
    End Sub




    Protected Sub AddPolicyNo_Click(sender As Object, e As EventArgs) Handles AddPolicyNo.Click
        Dim _PolicyID = PolicyNoFilter.Value
        Dim _Commission = newCommission.Value

        Using dc As New DataClasses_GoodWorldExt()
            Dim data = (From c In dc.v_Report1s Where c.ID.Equals(_PolicyID)).FirstOrDefault()

            Dim _Premium = data.Premium
            Dim _TotalPremium = data.GrossPremium


            Dim _CommissionAmount = _Premium * (_Commission / 100)
            Dim _BillingAmount = _TotalPremium - _CommissionAmount


            Dim _newData As New tblSubBillingPolicy
            With _newData
                .SubBillingID = CInt(Session("SubBillingID"))
                .PolicyID = data.ID
                .Commission = _Commission
                .Premium = _Premium
                .TotalPremium = _TotalPremium
                .CommissionAmount = _CommissionAmount
                .BillingAmount = _BillingAmount
            End With

            dc.tblSubBillingPolicies.InsertOnSubmit(_newData)
            dc.SubmitChanges()

        End Using

        PolicyNoFilter.Text = ""
        newCommission.Value = Nothing

        grid_SubBillingDetails.DataBind()
    End Sub
    Protected Sub grid_SubBillingDetails_RowUpdating(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataUpdatingEventArgs) Handles grid_SubBillingDetails.RowUpdating

        Dim _ID = e.Keys(0)
        Using dc As New DataClasses_GoodWorldExt()
            Dim data = (From c In dc.tblSubBillingPolicies Where c.ID.Equals(_ID)).FirstOrDefault()
            Dim _Premium = data.Premium
            Dim _TotalPremium = data.TotalPremium

            Dim _Commission = e.NewValues("Commission")
            Dim _CommissionAmount = _Premium * (_Commission / 100)
            Dim _BillingAmount = _TotalPremium - _CommissionAmount

            data.Commission = _Commission
            data.CommissionAmount = _CommissionAmount
            data.BillingAmount = _BillingAmount

            dc.SubmitChanges()
        End Using



        grid_SubBillingDetails.CancelEdit()
        e.Cancel = True
    End Sub
End Class
