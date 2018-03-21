
Imports System.Data
Imports System.Web.Security
Imports Portal.Components
'Imports FineUI

Imports System.Collections.Generic
Imports System.Linq
'Imports System.Data
Imports System.Reflection
Imports LWT.Website
Imports DevExpress.Web

Partial Class Modules_ucSQLCommand
    Inherits PortalModuleControl
    Protected PageName As String
    '*******************************************************
    '
    ' The Page_Load server event handler on this user control is used
    ' to populate the current site settings from the config system
    '
    '*******************************************************
    'Private Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Init
    '    Dim portalSettings As PortalSettings = CType(HttpContext.Current.Items(webconfig._PortalContextName), PortalSettings)
    '    If Not PortalSecurity.IsInRoles(portalSettings.ActiveTab.AuthorizedRoles, portalSettings.ActiveTab.TabId) = True Then
    '        Response.Redirect("~/Admin/AccessDenied.aspx")
    '    End If
    '    Session("PortalId") = webconfig._PortalID
    '    pnMain.HeaderImage.IconID = "export_exporttomht_16x16office2013"
    '    pnMain.HeaderText = portalSettings.ActiveTab.TabName
    'End Sub


    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Dim portalSettings As PortalSettings = CType(HttpContext.Current.Items(webconfig._PortalContextName), PortalSettings)
        If Not PortalSecurity.IsInRoles(portalSettings.ActiveTab.AuthorizedRoles, portalSettings.ActiveTab.TabId) = True Then
            Response.Redirect("~/Admin/AccessDenied.aspx")
        End If
        Session("PortalId") = webconfig._PortalID


        ' If this is the first visit to the page, populate the site data
        If Page.IsPostBack = False Then


        End If
    End Sub

    Protected Sub cbCommand_Callback(ByVal sender As Object, ByVal e As CallbackEventArgs) Handles cbCommand.Callback
        Dim sql = e.Parameter.ToString()

        Using dc As New DataClasses_PortalDataContextExt()

            dc.ExecuteCommand(sql)

        End Using


        e.Result = "Success"
    End Sub
End Class
