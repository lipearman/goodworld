﻿Imports System
Imports System.Collections.Generic
Imports System.Linq
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports DevExpress.Web
Imports DevExpress.Web.ASPxThemes
Imports DevExpress.Images
Imports System.IO
Imports System.Reflection
Imports System.Text.RegularExpressions
Imports Portal.Components
Imports LWT.Website

Partial Class Modules_ucIconInfo
    Inherits PortalModuleControl

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Init
        If Session("ListOfIcons") Is Nothing Then
            Session("ListOfIcons") = GenerateIconList()
        End If

        gridView.DataSource = TryCast(Session("ListOfIcons"), List(Of IconInfo))
        gridView.DataBind()
    End Sub
    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Dim portalSettings As PortalSettings = CType(HttpContext.Current.Items(webconfig._PortalContextName), PortalSettings)
        If Not PortalSecurity.IsInRoles(portalSettings.ActiveTab.AuthorizedRoles, portalSettings.ActiveTab.TabId) = True Then
            Response.Redirect("~/Admin/AccessDenied.aspx")
        End If
        Session("PortalId") = webconfig._PortalID

        '' Verify that the current user has access to access this page
        'If PortalSecurity.IsInRoles("Admins") = False Then
        '    Response.Redirect("~/Admin/EditAccessDenied.aspx")
        '    'Response.End()
        'End If

        ' If this is the first visit to the page, populate the site data
        If Page.IsPostBack = False Then

            ' Obtain PortalSettings from Current Context
            'Dim portalSettings As PortalSettings = CType(Context.Items(ConfigurationSettings.AppSettings("PortalContextName")), PortalSettings)


            'siteName.Text = portalSettings.PortalName
            'showEdit.Checked = portalSettings.AlwaysShowEditButton

            'BindData()

        End If
    End Sub

    Protected Sub cbEndless_CheckedChanged(ByVal sender As Object, ByVal e As EventArgs) Handles cbEndless.CheckedChanged
        If cbEndless.Checked Then
            gridView.SettingsPager.Mode = GridViewPagerMode.EndlessPaging
        Else
            gridView.SettingsPager.Mode = GridViewPagerMode.ShowPager
        End If
        gridView.PageIndex = 0
        gridView.DataBind()
    End Sub
    Public Function GenerateIconList() As List(Of IconInfo)
        Dim list As New List(Of IconInfo)()
        For Each field In GetType(IconID).GetFields()
            Dim fullIconID As String = field.GetValue("").ToString()

            Dim size As String = Regex.Match(field.Name, "[1-9][0-9]x[1-9][0-9]").ToString()
            Dim sName() As String = Regex.Split(field.Name, "[1-9][0-9]x[1-9][0-9]", RegexOptions.Compiled)
            Dim properties() As String = Regex.Split(sName(0), "(?=[A-Z][a-z])|(?<=[a-z])(?=[A-Z])", RegexOptions.Compiled)


            'fix for names divided by number (like Chart3dclusteredcolumn16x16)
            Dim category As String
            Dim iconName As String
            If properties.Length = 2 Then
                Dim properties2() As String = properties(1).Split("3"c)
                category = properties2(0)
                iconName = "3" & properties2(1)
            Else
                category = properties(1)
                iconName = properties(2)
            End If


            Dim collection As String = sName(1)
            If collection = String.Empty Then
                collection = "Colored"
            Else
                collection = FirstCharToUpper(collection)
            End If

            Dim icon As New IconInfo(category, size, collection, iconName, fullIconID, field.Name)
            list.Add(icon)
        Next field
        Return list
    End Function
    Public Shared Function FirstCharToUpper(ByVal input As String) As String
        If String.IsNullOrEmpty(input) Then
            Return input
        End If
        Return input.First().ToString().ToUpper() & input.Substring(1)
    End Function

    Protected Sub gridView_CustomCallback(ByVal sender As Object, ByVal e As ASPxGridViewCustomCallbackEventArgs) Handles gridView.CustomCallback
        If e.Parameters = "clear" Then
            Dim gridView As ASPxGridView = TryCast(sender, ASPxGridView)
            gridView.FilterExpression = ""
            For Each column As GridViewDataColumn In gridView.Columns
                If column.GroupIndex > -1 Then
                    gridView.UnGroup(column)
                End If
                If column.SortIndex > -1 Then
                    column.SortIndex = -1
                End If
            Next column
            gridView.SearchPanelFilter = ""
            gridView.PageIndex = 0
        End If
    End Sub
End Class
