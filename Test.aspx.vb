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
Partial Class Test
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim _BillingID = CInt(Request("ID"))
        Using dc As New DataClasses_GoodWorldExt()
            Dim _BillingDetails = (From c In dc.tblBillingRegisters Where c.ID.Equals(_BillingID)).FirstOrDefault()


            Dim sb As New StringBuilder()
            sb.Append(" SELECT * ")
            sb.Append(" FROM v_BillingDetails ")
            sb.AppendFormat(" where BillingID='{0}' ", _BillingDetails.ID)

            Dim ReportFile As String = ""
            If _BillingDetails.BillingType = "C" Then
                ReportFile = "rptBilling1.rdl"
            Else
                ReportFile = "rptBilling2.rdl"
            End If

            Dim ds = SqlHelper.ExecuteDataset(ConfigurationManager.ConnectionStrings("PortalConnectionString").ConnectionString, System.Data.CommandType.Text, sb.ToString())

            'Session("Report1") = ds.Tables(0)
            Dim ReportViewer1 As New ReportViewer()
            ReportViewer1.Reset()
            ReportViewer1.LocalReport.Dispose()
            ReportViewer1.LocalReport.DataSources.Clear()
            ReportViewer1.AsyncRendering = False
            ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/App_Data/reports/" & ReportFile)
            ReportViewer1.LocalReport.DataSources.Add(New ReportDataSource("DataSet1", ds.Tables(0)))
            ReportViewer1.LocalReport.SetParameters(New ReportParameter("TaxP", _BillingDetails.TaxP / 100))
            ReportViewer1.LocalReport.SetParameters(New ReportParameter("DiscountP", _BillingDetails.DiscountP / 100))
            ReportViewer1.LocalReport.Refresh()

            Dim warnings As Warning()
            Dim streamids As String()
            Dim mimeType As String
            Dim encoding As String
            Dim extension As String
            Dim bytes As Byte() = ReportViewer1.LocalReport.Render("PDF", Nothing, mimeType, encoding, extension, streamids, warnings)

            Dim _GUID = System.Guid.NewGuid().ToString()
            Session("GUID") = _GUID

            Dim FileName = Server.MapPath(String.Format("~/UploadFiles/{0}.pdf", _GUID))

            Using fs As FileStream = New FileStream(FileName, FileMode.Create)
                fs.Write(bytes, 0, bytes.Length)
                fs.Close()
            End Using

            'documentViewer.Document = String.Format("~/UploadFiles/{0}.pdf", _GUID)
        End Using

    End Sub

End Class
