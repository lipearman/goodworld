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
Imports System.Globalization

Partial Class Modules_ucReportForInsurer2
    Inherits PortalModuleControl
    Protected PageName As String



    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init

        'Using dc As New DataClasses_GoodWorldExt()
        '    Dim _Report1s = (From c In dc.v_Report1s Where c.Monthly IsNot Nothing).ToList()

        '    Dim _data = (From c In _Report1s
        '                 Group By Monthly = c.Monthly Into MyGroup = Group
        '                 Select Monthly Order By Monthly Descending).ToList()
        '    For Each item In _data
        '        Dim _Rows = _Report1s.Where(Function(c) c.Monthly.Equals(item.Value)).Count

        '        Dim _MonthlyName = String.Format("{0} ({1})", MyUtils.GenThaiMonthlyDate(item, 2), _Rows.ToString())

        '        MonthlyName.Items.Add(New BootstrapListEditItem With {.Text = item.Value.ToString("MMMM yyyy"), .Value = item.Value.ToString("yyyy-MM-dd")})

        '    Next


        'End Using
    End Sub


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim portalSettings As PortalSettings = CType(HttpContext.Current.Items(webconfig._PortalContextName), PortalSettings)
        If Not PortalSecurity.IsInRoles(portalSettings.ActiveTab.AuthorizedRoles, portalSettings.ActiveTab.TabId) = True Then
            Response.Redirect("~/Admin/AccessDenied.aspx")
        End If
        PageName = portalSettings.ActiveTab.TabName

    End Sub


    Protected Sub btnPrintDetail_Click(sender As Object, e As EventArgs) Handles btnPrintDetail.Click



        Dim sb As New StringBuilder()
        sb.Append(" SELECT * ")
        sb.Append(" FROM v_Report1 ")
        sb.AppendFormat(" where  convert(varchar,EffectiveDate,112) between '{0}' and '{1}' ", DirectCast(datefrom.Value, Date).ToString("yyyyMMdd"), DirectCast(dateto.Value, Date).ToString("yyyyMMdd"))
        'sb.AppendFormat(" and InsurerCode='{0}'", insurer.Value)

        Dim ReportFile = "rptSaleReportForInsurer2Details.rdl"
        Dim ds = SqlHelper.ExecuteDataset(ConfigurationManager.ConnectionStrings("PortalConnectionString").ConnectionString, System.Data.CommandType.Text, sb.ToString())

        'Session("Report1") = ds.Tables(0)
        Dim ReportViewer1 As New ReportViewer()
        ReportViewer1.Reset()
        ReportViewer1.LocalReport.Dispose()
        ReportViewer1.LocalReport.DataSources.Clear()
        ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/App_Data/reports/" & ReportFile)
        ReportViewer1.LocalReport.DataSources.Add(New ReportDataSource("DataSet1", ds.Tables(0)))
        ReportViewer1.LocalReport.Refresh()



        Dim warnings As Warning()
        Dim streamids As String()
        Dim mimeType As String
        Dim encoding As String
        Dim extension As String
        Dim bytes As Byte() = ReportViewer1.LocalReport.Render("Excel", Nothing, mimeType, encoding, extension, streamids, warnings)

        Session("GUID") = System.Guid.NewGuid().ToString()

        Dim FileName = Server.MapPath(String.Format("~/App_Data/UploadTemp/{0}.xls", Session("GUID").ToString()))

        Using fs As FileStream = New FileStream(FileName, FileMode.Create)
            fs.Write(bytes, 0, bytes.Length)
            fs.Close()
        End Using

        clientReportPreview.ShowOnPageLoad() = True

        Spreadsheet.Open(FileName)
    End Sub

    Protected Sub btnPrintSummary_Click(sender As Object, e As EventArgs) Handles btnPrintSummary.Click

        Dim sb As New StringBuilder()
        sb.Append(" SELECT InsurerName,count(PolicyNo) as PolicyNo,sum(Premium) as Premium,sum(Vat) as Vat,sum(Stamp) as Stamp,sum(GrossPremium) as GrossPremium ")
        sb.Append(" FROM v_Report1 ")
        sb.AppendFormat(" where  convert(varchar,EffectiveDate,112) between '{0}' and '{1}' ", DirectCast(datefrom.Value, Date).ToString("yyyyMMdd"), DirectCast(dateto.Value, Date).ToString("yyyyMMdd"))
        sb.Append(" group by InsurerName")

        Dim ReportFile = "rptSaleReportForInsurer2Summary.rdl"
        Dim ds = SqlHelper.ExecuteDataset(ConfigurationManager.ConnectionStrings("PortalConnectionString").ConnectionString, System.Data.CommandType.Text, sb.ToString())

        'Session("Report1") = ds.Tables(0)
        Dim ReportViewer1 As New ReportViewer()
        ReportViewer1.Reset()
        ReportViewer1.LocalReport.Dispose()
        ReportViewer1.LocalReport.DataSources.Clear()
        ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/App_Data/reports/" & ReportFile)
        ReportViewer1.LocalReport.DataSources.Add(New ReportDataSource("DataSet1", ds.Tables(0)))
        ReportViewer1.LocalReport.Refresh()



        Dim warnings As Warning()
        Dim streamids As String()
        Dim mimeType As String
        Dim encoding As String
        Dim extension As String
        Dim bytes As Byte() = ReportViewer1.LocalReport.Render("Excel", Nothing, mimeType, encoding, extension, streamids, warnings)

        Session("GUID") = System.Guid.NewGuid().ToString()

        Dim FileName = Server.MapPath(String.Format("~/App_Data/UploadTemp/{0}.xls", Session("GUID").ToString()))

        Using fs As FileStream = New FileStream(FileName, FileMode.Create)
            fs.Write(bytes, 0, bytes.Length)
            fs.Close()
        End Using

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
End Class
