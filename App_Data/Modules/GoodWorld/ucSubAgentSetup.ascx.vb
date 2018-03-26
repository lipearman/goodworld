﻿Imports System.Data
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


Partial Class Modules_ucSubAgentSetup
    Inherits PortalModuleControl
    Protected PageName As String
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim portalSettings As PortalSettings = CType(HttpContext.Current.Items(webconfig._PortalContextName), PortalSettings)
        If Not PortalSecurity.IsInRoles(portalSettings.ActiveTab.AuthorizedRoles, portalSettings.ActiveTab.TabId) = True Then
            Response.Redirect("~/Admin/AccessDenied.aspx")
        End If

        PageName = portalSettings.ActiveTab.TabName
        Session("PortalId") = webconfig._PortalID

        SqlDataSource_SubAgent.InsertParameters("UserName").DefaultValue = HttpContext.Current.User.Identity.Name
        SqlDataSource_SubAgent.UpdateParameters("UserName").DefaultValue = HttpContext.Current.User.Identity.Name

    End Sub


    Protected Sub TaskGrid_RowInserting(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataInsertingEventArgs) Handles TaskGrid.RowInserting
        Dim SubAgentCode = e.NewValues("SubAgentCode").ToString()
        Using dc As New DataClasses_GoodWorldExt()
            Dim data = dc.tblSubAgents.SingleOrDefault(Function(c) c.SubAgentCode.Equals(SubAgentCode))
            If data IsNot Nothing Then

                Throw New Exception(String.Format("รหัส {0} มีในระบบแล้ว", SubAgentCode))

            End If
        End Using
    End Sub

    Protected Sub TaskGrid_RowUpdating(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataUpdatingEventArgs) Handles TaskGrid.RowUpdating
        Dim ID = e.NewValues("ID").ToString()
        Dim SubAgentCode = e.NewValues("SubAgentCode").ToString()
        Using dc As New DataClasses_GoodWorldExt()
            Dim data = dc.tblSubAgents.SingleOrDefault(Function(c) c.SubAgentCode.Equals(SubAgentCode) And c.ID <> ID)
            If data IsNot Nothing Then

                Throw New Exception(String.Format("รหัส {0} มีในระบบแล้ว", SubAgentCode))

            End If
        End Using
    End Sub
End Class
