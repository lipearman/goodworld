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
Imports DevExpress.Data.Filtering
Imports Microsoft.Reporting.WebForms
Imports System.Threading
Imports System.Globalization

Partial Class Modules_ucBillingRegister
    Inherits PortalModuleControl
    Protected PageName As String
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim portalSettings As PortalSettings = CType(HttpContext.Current.Items(webconfig._PortalContextName), PortalSettings)
        If Not PortalSecurity.IsInRoles(portalSettings.ActiveTab.AuthorizedRoles, portalSettings.ActiveTab.TabId) = True Then
            Response.Redirect("~/Admin/AccessDenied.aspx")
        End If
        PageName = portalSettings.ActiveTab.TabName

        Session("PortalId") = webconfig._PortalID

        SqlDataSource_BillingRegister.InsertParameters("UserName").DefaultValue = HttpContext.Current.User.Identity.Name
        SqlDataSource_BillingRegister.UpdateParameters("UserName").DefaultValue = HttpContext.Current.User.Identity.Name



    End Sub





    Protected Sub TaskEditPopup_Callback(ByVal sender As Object, ByVal e As CallbackEventArgsBase) Handles TaskEditPopup.WindowCallback
        Dim args = e.Parameter.ToString()

        If args.ToLower().StartsWith("edit") Then
            Dim params = args.Split("|")
            Dim _ID = params(1)
            TaskEditPopup.JSProperties("cpedittask") = params(0)
            hdID.Set("ID", _ID)
            edit(_ID)

            Session("BillingID") = _ID

            TaskEditPopup.ShowOnPageLoad = True


        ElseIf args.ToLower().StartsWith("addpolicy") Then
            Dim params = args.Split("|")
            Dim _PolicyID = params(1)
            If String.IsNullOrEmpty(_PolicyID.Replace("null", "")) Then
                TaskEditPopup.JSProperties("cpedittask") = "No Data"
                Return
            End If

            Using dc As New DataClasses_GoodWorldExt()
                Dim data = (From c In dc.v_Report1s Where c.ID.Equals(_PolicyID)).FirstOrDefault()

                If data Is Nothing Then
                    TaskEditPopup.JSProperties("cpedittask") = "No Data"
                Else
                    Dim newData As New tblBillingDetail()

                    With newData
                        .BillingID = CInt(hdID("ID"))
                        .PolicyID = CInt(_PolicyID)

                        .CreateBy = HttpContext.Current.User.Identity.Name
                        .CreateDate = Now



                    End With


                    dc.tblBillingDetails.InsertOnSubmit(newData)
                    dc.SubmitChanges()

                    TaskEditPopup.JSProperties("cpedittask") = "cpaddtask"
                End If


            End Using
            TaskEditPopup.ShowOnPageLoad = True
            PolicyNoFilter.Value = ""

            edit(hdID("ID"))
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
            Dim data = (From c In dc.v_BillingRegisters Where c.ID.Equals(_ID)).FirstOrDefault()


            formPreview.DataSource = data
            formPreview.DataBind()

        End Using
    End Sub




    Protected Sub TaskGrid_HtmlRowCreated(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridViewTableRowEventArgs) Handles TaskGrid.HtmlRowPrepared


        If e.RowType <> DevExpress.Web.GridViewRowType.Data Then
            Return
        End If

        Dim EditButton As BootstrapButton = TaskGrid.FindRowCellTemplateControl(e.VisibleIndex, Nothing, "EditButton")
        EditButton.JSProperties.Add("cpID", e.KeyValue().ToString())



    End Sub



    Protected Sub MyGridDetails_RowInserting(ByVal sender As Object, ByVal e As ASPxDataInsertingEventArgs) Handles MyGridDetails.RowInserting
        Using dc As New DataClasses_GoodWorldExt()
            Dim _ID = e.NewValues("ID")
            Dim data = (From c In dc.v_BillingRegisters Where c.ID.Equals(_ID)).FirstOrDefault()



        End Using


        MyGridDetails.CancelEdit()
        e.Cancel = True
    End Sub


    Protected Sub PolicyNo_ItemRequestedByValue(source As Object, e As ListEditItemRequestedByValueEventArgs) Handles PolicyNoFilter.ItemRequestedByValue
        Dim value As Long = 0
        If e.Value Is Nothing Then
            Return
        End If
        Dim comboBox As ASPxComboBox = CType(source, ASPxComboBox)
        SqlDataSource1.SelectCommand = "select ClientName from v_Report1 where v_Report1.ID not in (select PolicyID from tblBillingDetails) and PolicyNo <> '' and  PolicyNo like @PolicyNo and isnull(PolicyNo,'') <> ''"

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
        sb.Append(" where v_Report1.ID not in (select PolicyID from tblBillingDetails) and PolicyNo <> '' and PolicyNo LIKE @filter and isnull(PolicyNo,'') <> '' ")
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


    Protected Sub btnPreview_Click(sender As Object, e As EventArgs)
        Dim _BillingID = CInt(hdID("ID"))

        edit(_BillingID)

        Using dc As New DataClasses_GoodWorldExt()

            Dim _BillingDetails = (From c In dc.tblBillingRegisters Where c.ID.Equals(_BillingID)).FirstOrDefault()


            Dim sb As New StringBuilder()
            sb.Append(" SELECT * ")
            sb.Append(" FROM v_BillingDetails ")
            sb.AppendFormat(" where BillingID='{0}' ", _BillingDetails.ID)


            Dim ReportViewer1 As New ReportViewer()
            Dim ds = SqlHelper.ExecuteDataset(ConfigurationManager.ConnectionStrings("PortalConnectionString").ConnectionString, System.Data.CommandType.Text, sb.ToString())

            Dim ReportFile As String = ""
            If _BillingDetails.BillingType = "C" Then
                ReportViewer1.Reset()
                ReportViewer1.LocalReport.Dispose()
                ReportViewer1.LocalReport.DataSources.Clear()
                ReportFile = "rptBilling1.rdl"
                ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/App_Data/reports/" & ReportFile)
                ReportViewer1.LocalReport.DataSources.Add(New ReportDataSource("DataSet1", ds.Tables(0)))

                If Not String.IsNullOrEmpty(_BillingDetails.TaxID) Then
                    ReportViewer1.LocalReport.SetParameters(New ReportParameter("TaxID", _BillingDetails.TaxID))
                Else
                    ReportViewer1.LocalReport.SetParameters(New ReportParameter("TaxID", ""))
                End If


                ReportViewer1.LocalReport.SetParameters(New ReportParameter("TaxP", _BillingDetails.TaxP / 100))
                ReportViewer1.LocalReport.SetParameters(New ReportParameter("DiscountP", _BillingDetails.DiscountP / 100))
                ReportViewer1.LocalReport.Refresh()
            Else
                ReportFile = "rptBilling2.rdl"
                ReportViewer1.Reset()
                ReportViewer1.LocalReport.Dispose()
                ReportViewer1.LocalReport.DataSources.Clear()
                ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/App_Data/reports/" & ReportFile)
                ReportViewer1.LocalReport.DataSources.Add(New ReportDataSource("DataSet1", ds.Tables(0)))
                ReportViewer1.LocalReport.SetParameters(New ReportParameter("DiscountP", _BillingDetails.DiscountP / 100))
                ReportViewer1.LocalReport.Refresh()
            End If

            Dim warnings As Warning()
            Dim streamids As String()
            Dim mimeType As String
            Dim encoding As String
            Dim extension As String
            Dim bytes As Byte() = ReportViewer1.LocalReport.Render("PDF", Nothing, mimeType, encoding, extension, streamids, warnings)

            Dim _GUID = System.Guid.NewGuid().ToString()
            Session("GUID") = _GUID

            'Dim FileName = Server.MapPath(String.Format("~/App_Data/UploadTemp/{0}.pdf", _GUID))
            Dim FileName = Server.MapPath(String.Format("~/UploadFiles/{0}.pdf", _GUID))

            Using fs As FileStream = New FileStream(FileName, FileMode.Create)
                fs.Write(bytes, 0, bytes.Length)
                fs.Close()
            End Using

            clientReportPreview.ShowOnPageLoad() = True

            'Spreadsheet.Open(FileName)



            'documentViewer.Document = String.Format("~/App_Data/UploadTemp/{0}.pdf", _GUID)


            'documentViewer.Text = String.Format("<script>PDFObject.embed(""UploadFiles/{0}.pdf"", ""#example1"");</script>", _GUID)
            documentViewer.Text = String.Format("<embed src=""UploadFiles/{0}.pdf"" type=""application/pdf"" width=""100%"" height=""100%"">", _GUID)

        End Using
    End Sub


    'Protected Sub btnExport_Click(sender As Object, e As EventArgs) Handles btnExport.Click
    '    Dim FileName = Server.MapPath(String.Format("~/App_Data/UploadTemp/{0}.xls", Session("GUID").ToString()))

    '    Page.Response.Clear()
    '    Page.Response.Buffer = False
    '    Page.Response.AppendHeader("Content-Type", "application/vnd.ms-excel")
    '    Page.Response.AppendHeader("content-disposition", "attachment; filename=myfile.xls")
    '    Page.Response.BinaryWrite(StreamFile(FileName))
    '    Page.Response.End()
    'End Sub

    'Private Function StreamFile(ByVal filename As String) As Byte()
    '    Dim ImageData As Byte() = New Byte(-1) {}
    '    Dim fs As FileStream = New FileStream(filename, FileMode.Open, FileAccess.Read)
    '    Try
    '        ImageData = New Byte(fs.Length - 1) {}
    '        fs.Read(ImageData, 0, System.Convert.ToInt32(fs.Length))
    '    Catch ex As Exception
    '        Throw ex
    '    Finally
    '        If fs IsNot Nothing Then
    '            fs.Close()
    '        End If
    '    End Try

    '    Return ImageData
    'End Function
    'Protected Sub ReportViewer1_PreRender(sender As Object, e As EventArgs)
    '    Dim ci As New CultureInfo("en-TH")
    '    Thread.CurrentThread.CurrentCulture = ci
    '    Thread.CurrentThread.CurrentUICulture = ci
    'End Sub
    Protected Sub TaskGrid_InitNewRow(sender As Object, e As ASPxDataInitNewRowEventArgs)
        e.NewValues("TaxP") = 0.00
        e.NewValues("DiscountP") = 0.00
    End Sub
End Class
