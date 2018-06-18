<%@ Application Language="vb" %> 
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Web.SessionState" %>
<%@ Import Namespace="System.Security.Principal" %>
<%@ Import Namespace="Portal.Components" %>
<%@ Import Namespace="System.Diagnostics" %>
<%@ Import Namespace="System.Web.Security" %>
<%@ Import Namespace="System.Threading" %>
<%@ Import Namespace="System.Globalization" %>
<%@ Import Namespace="System.Web.Mail" %>
<%@ Import Namespace="System.Text" %>
<script runat="server">

    Sub Application_Start(ByVal sender As Object, ByVal e As EventArgs)
        DevExpress.XtraReports.Web.ReportDesigner.DefaultReportDesignerContainer.RegisterDataSourceWizardConfigFileConnectionStringsProvider()
        'DevExpress.XtraReports.Web.ReportDesigner.DefaultReportDesignerContainer.RegisterDataSourceWizardConnectionStringsProvider(Of MyXtraReportsDataSourceWizardConnectionStringsProvider)()

        AddHandler DevExpress.Web.ASPxWebControl.CallbackError, AddressOf CallbackError
    End Sub
    Protected Sub Application_BeginRequest(ByVal sender As Object, ByVal e As EventArgs)
        Dim _PortalContextName As String = ConfigurationSettings.AppSettings("PortalContextName")
        Dim _PageID As String = ""
        'Dim _PageID As String = ""
        'If Not (Request.Params("pageid") Is Nothing) Then
        _PageID = Request.Params("pageid")
        'Else
        '    Dim fullOrigionalpath = Request.Url.ToString().Split("/")
        '    If fullOrigionalpath.Count > 0 Then
        '        Dim repath = fullOrigionalpath(fullOrigionalpath.Count - 1).Replace(".aspx", "").Replace("#", "")
        '        Using dc As New DataClasses_PortalDataContextExt()
        '            Dim data = (From c In dc.PortalCfg_Tabs Where c.PortalId.Equals(ConfigurationSettings.AppSettings("PortalID")) And c.TabName.ToLower().Equals(repath.ToLower())).FirstOrDefault()
        '            If data IsNot Nothing Then
        '                _PageID = data.PageID

        '                Context.RewritePath("~/DesktopDefault.aspx?PageId=" & _PageID)

        '            End If
        '        End Using
        '    End If
        'End If

        ' Build and add the PortalSettings object to the current Context 
        Context.Items.Add(_PortalContextName, New Portal.Components.PortalSettings(_PageID))


        DevExpress.XtraReports.Web.Extensions.ReportStorageWebExtension.RegisterExtensionGlobal(New CustomReportStorageWebExtension(Me.Context))
    End Sub

    Private Sub Application_AcquireRequestState(ByVal sender As Object, ByVal e As EventArgs) '(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.AcquireRequestState

    End Sub

    'Sub Application_Start(ByVal sender As Object, ByVal e As EventArgs)
    '    ' Code that runs on application startup
    '    'DashboardConfigurator.PassCredentials = True

    '    'SqlDependency.Start(ConfigurationManager.ConnectionStrings("PortalBIRawDataConnection").ConnectionString)


    'End Sub

    Sub Application_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs on application shutdown
        'SqlDependency.Stop(ConfigurationManager.ConnectionStrings("PortalBIRawDataConnection").ConnectionString)
    End Sub

    Sub Application_Error(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs when an unhandled error occurs
    End Sub

    Sub Session_Start(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs when a new session is started
    End Sub

    Sub Session_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs when a session ends. 
        ' Note: The Session_End event is raised only when the sessionstate mode
        ' is set to InProc in the Web.config file. If session mode is set to StateServer 
        ' or SQLServer, the event is not raised.
    End Sub
    Public Shared Function GetApplicationPath(ByVal request As HttpRequest) As String
        Dim path As String = String.Empty
        Try
            If request.ApplicationPath <> "/" Then
                path = request.ApplicationPath
            End If
        Catch e As Exception
            Throw e
        End Try

        Return path
    End Function

    Sub CallbackError(ByVal sender As Object, ByVal e As EventArgs)
        ' Logging exceptions occur on callback events of DevExpress ASP.NET controls. 
        ' To learn more, see http://www.devexpress.com/Support/Center/Example/Details/E2398

        ' Use HttpContext.Current to get a Web request processing helper
        Dim exception As Exception = HttpContext.Current.Server.GetLastError()
        If TypeOf exception Is HttpUnhandledException Then
            exception = exception.InnerException
        End If
        ' Log an exception
        If exception IsNot Nothing Then AddToLog(exception.Message, exception.StackTrace)
    End Sub
    Sub AddToLog(ByVal message As String, ByVal stackTrace As String)
        Dim sb As New StringBuilder()
        sb.AppendLine(Date.Now.ToLocalTime().ToString())
        sb.AppendLine(message)
        sb.AppendLine()
        sb.AppendLine("Source File: " & HttpContext.Current.Request.RawUrl)
        sb.AppendLine()
        sb.AppendLine("Stack Trace: ")
        sb.AppendLine(stackTrace)
        For i As Integer = 0 To 149
            sb.Append("-")
        Next i
        sb.AppendLine()
        HttpContext.Current.Session("Log") += sb.ToString()
        sb.AppendLine()
    End Sub
</script>