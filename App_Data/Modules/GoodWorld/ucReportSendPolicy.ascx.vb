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

Partial Class Modules_ucReportSendPolicy
    Inherits PortalModuleControl
    Protected PageName As String



    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        If datefrom.Value Is Nothing Then
            If Now.Year < 2500 Then
                datefrom.Value = Today.AddYears(543)
            Else
                datefrom.Value = Today
            End If
        End If
        If dateto.Value Is Nothing Then
            If Now.Year < 2500 Then
                dateto.Value = Today.AddYears(543)
            Else
                dateto.Value = Today
            End If
        End If
    End Sub


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim portalSettings As PortalSettings = CType(HttpContext.Current.Items(webconfig._PortalContextName), PortalSettings)
        If Not PortalSecurity.IsInRoles(portalSettings.ActiveTab.AuthorizedRoles, portalSettings.ActiveTab.TabId) = True Then
            Response.Redirect("~/Admin/AccessDenied.aspx")
        End If
        PageName = portalSettings.ActiveTab.TabName

    End Sub



    'Protected Sub cbSend_Callback(ByVal sender As Object, ByVal e As CallbackEventArgs) Handles cbSend.Callback

    '    System.Threading.Thread.Sleep(1000)

    '    e.Result = "success"



    'End Sub




    Protected Sub TaskGrid_ToolbarItemClick(ByVal sender As Object, ByVal e As BootstrapGridViewToolbarItemClickEventArgs) Handles TaskGrid.ToolbarItemClick

        Select Case e.Item.Name
            Case "ExportToXLS"
                TaskGrid.ExportXlsToResponse(New XlsExportOptionsEx With {.ExportType = ExportType.WYSIWYG})
            Case "ExportToXLSX"
                TaskGrid.ExportXlsxToResponse(New XlsxExportOptionsEx With {.ExportType = ExportType.WYSIWYG})
        End Select
    End Sub
    Protected Sub btnSearch_Click(sender As Object, e As EventArgs) Handles btnSearch.Click

        If Not datefrom.Value Is Nothing And Not dateto.Value Is Nothing Then
            binddata()
            TaskGrid.Visible = True
        End If


    End Sub


    Private Sub binddata()

        '/****** Script for SelectTopNRows command from SSMS  ******/
        'Select Case InsurerName,InsurerCode
        ',count(*) 
        ',sum([GrossPremium])
        ',sum([BrokerageAmt])
        'FROM [goodworld].[dbo].[v_Report1]
        'group by [InsurerName]
        '--order by [EffectiveDate],[ExpiredDate]

        'If datefrom.Value Is Nothing Then
        '    If Now.Year < 2500 Then
        '        datefrom.Value = Today.AddYears(543)
        '    Else
        '        datefrom.Value = Today
        '    End If
        'End If
        'If dateto.Value Is Nothing Then
        '    If Now.Year < 2500 Then
        '        dateto.Value = Today.AddYears(543)
        '    Else
        '        dateto.Value = Today
        '    End If
        'End If




        Dim sb As New StringBuilder()
        sb.Append("SELECT ROW_NUMBER() OVER(ORDER BY InsurerName) AS RowNo")
        sb.Append(",InsurerName ")
        sb.Append(",InsurerCode ")
        sb.Append(",count(*) as PolicyCount ")
        sb.Append(",sum(GrossPremium) as TotalPremium ")
        sb.Append(",sum(BrokerageAmt) as Brokerage")
        sb.Append(" FROM v_Report1 ")
        sb.AppendFormat(" where  convert(varchar,EffectiveDate,112) between '{0}' and '{1}' ", DirectCast(datefrom.Value, Date).ToString("yyyyMMdd"), DirectCast(dateto.Value, Date).ToString("yyyyMMdd"))
        sb.Append(" group by InsurerName,InsurerCode ")

        SqlDataSource_gridData.DataSourceMode = SqlDataSourceMode.DataReader
        '============ todo2=======================
        SqlDataSource_gridData.SelectCommand = sb.ToString()
        SqlDataSource_gridData.DataBind()

        TaskGrid.DataSourceID = "SqlDataSource_gridData"
        TaskGrid.DataBind()



        'Throw New Exception(sb.ToString())

    End Sub


    Protected Sub TaskGrid_HtmlRowCreated(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridViewTableRowEventArgs) Handles TaskGrid.HtmlRowPrepared


        If e.RowType <> DevExpress.Web.GridViewRowType.Data Then
            Return
        End If

        Dim exportButton As BootstrapButton = TaskGrid.FindRowCellTemplateControl(e.VisibleIndex, Nothing, "exportButton")
        exportButton.JSProperties.Add("cpInsurerCode", e.KeyValue().ToString())



    End Sub



    'Protected Sub cbExport_Callback(ByVal sender As Object, ByVal e As CallbackEventArgs) Handles cbExport.Callback

    '    Dim _InsurerCode = e.Parameter.ToString()




    '    Dim sb As New StringBuilder()
    '    sb.Append(" SELECT * ")
    '    sb.Append(" FROM v_Report1 ")
    '    sb.AppendFormat(" where  convert(varchar,EffectiveDate,112) between '{0}' and '{1}' ", DirectCast(datefrom.Value, Date).ToString("yyyyMMdd"), DirectCast(dateto.Value, Date).ToString("yyyyMMdd"))
    '    sb.AppendFormat(" and InsurerCode='{0}' ", _InsurerCode)

    '    SqlDataSource_gridData.DataSourceMode = SqlDataSourceMode.DataReader
    '    '============ todo2=======================
    '    SqlDataSource_gridData.SelectCommand = sb.ToString()
    '    SqlDataSource_gridData.DataBind()

    '    ExportGrid.DataSourceID = "SqlDataSource_gridData"
    '    ExportGrid.DataBind()


    '    ExportGrid.ExportXlsxToResponse(New XlsxExportOptionsEx With {.ExportType = ExportType.WYSIWYG})

    '    e.Result = _InsurerCode

    'End Sub


    Protected Sub exportButton_Click(sender As Object, e As EventArgs)
        Dim _InsurerCode = DirectCast(sender, BootstrapButton).CommandArgument.ToString()

        Dim sb As New StringBuilder()
        sb.Append(" SELECT * ")
        sb.Append(" FROM v_Report1 ")
        sb.AppendFormat(" where  convert(varchar,EffectiveDate,112) between '{0}' and '{1}' ", DirectCast(datefrom.Value, Date).ToString("yyyyMMdd"), DirectCast(dateto.Value, Date).ToString("yyyyMMdd"))
        sb.AppendFormat(" and InsurerCode='{0}' ", _InsurerCode)

        SqlDataSource_Export.DataSourceMode = SqlDataSourceMode.DataReader
        '============ todo2=======================
        SqlDataSource_Export.SelectCommand = sb.ToString()
        SqlDataSource_Export.DataBind()

        ExportGrid.DataSourceID = "SqlDataSource_Export"
        ExportGrid.DataBind()


        ExportGrid.ExportXlsxToResponse(New XlsxExportOptionsEx With {.ExportType = ExportType.WYSIWYG})

    End Sub
End Class
