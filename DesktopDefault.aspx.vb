Imports Portal.Components
Imports System.Security
Imports System.Data
Imports DevExpress.Web
Imports LWT.Website


Partial Class DesktopDefault
    Inherits BasePage

    Protected SiteName As String
    Protected NavigateBar As String
    Protected parenttabname As String = ""
    Protected _PortalContextName As String = ConfigurationSettings.AppSettings("PortalContextName")
    Private Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init


        Dim portalSettings As PortalSettings = CType(HttpContext.Current.Items(_PortalContextName), PortalSettings)
        If Not PortalSecurity.IsInRoles(portalSettings.ActiveTab.AuthorizedRoles, portalSettings.ActiveTab.TabId) = True Then
            ASPxWebControl.RedirectOnCallback("~/Admin/AccessDenied.aspx")
            'Response.Redirect("~/Admin/AccessDenied.aspx")
            Return
        End If

        SiteName = portalSettings.PortalName

        GenMainMenu()

        GenControl()

        GenSiteNavigate()
    End Sub

    Public Sub GenSiteNavigate()

        Dim portalSettings As PortalSettings = CType(Context.Items(ConfigurationSettings.AppSettings("PortalContextName")), PortalSettings)
        Dim _tabs = (From c In portalSettings.DesktopTabs Where Not c.ParentId Is Nothing And c.PortalId = portalSettings.PortalId Order By c.Sortpath).ToList()
        Dim _currtab = (From c In portalSettings.DesktopTabs Where c.PageID = portalSettings.ActiveTab.PageID And c.ParentId IsNot Nothing And c.PortalId = portalSettings.PortalId Order By c.Sortpath).FirstOrDefault()

        parenttabname = ""


        If Not _currtab Is Nothing Then
            Dim parentname = GetSiteMap(_currtab, _tabs)

            If Not String.IsNullOrEmpty(parentname) Then
                Dim _tempname = parentname.Split(";")
                For i As Integer = _tempname.Count - 1 To 0 Step -1
                    If Not String.IsNullOrEmpty(_tempname(i)) Then
                        parenttabname = _tempname(i) & " -> " & parenttabname
                    End If
                Next
                parenttabname = parenttabname & ("<b>" + _currtab.TabName + "</b>")
            Else
                parenttabname = ("<b>" + _currtab.TabName + "</b>")
            End If
        End If
    End Sub
    Private Function GetSiteMap(ByVal _CurrentTab As DesktopTab, ByVal _tabs As List(Of DesktopTab)) As String
        Dim sbTabName As New StringBuilder()
        Dim _ParentTab = (From c In _tabs Where c.TabId = _CurrentTab.ParentId).FirstOrDefault()
        If _ParentTab IsNot Nothing Then
            sbTabName.Append(GetSiteMap(_ParentTab, _tabs))
            sbTabName.Append(_ParentTab.TabName & ";")
        End If
        Return sbTabName.ToString()
    End Function

    Private Sub GenMainMenu()
        Dim portalSettings As PortalSettings = CType(Context.Items(_PortalContextName), PortalSettings)

        Using dc As New DataClasses_PortalDataContextExt()
            Dim _tabs = (From c In dc.v_UserTabs Where c.PortalId = portalSettings.PortalId And c.UserName.ToLower() = HttpContext.Current.User.Identity.Name.ToLower() Order By c.Sortpath, c.TabOrder).ToList()
            Dim _menuObj = (From c In _tabs Where c.ParentId = 1).ToList()
            For Each _menu In _menuObj 'mainmenu
                Dim _GroupNode = MainMenu.Items.Add(_menu.TabName, _menu.TabId, "icon icon-settings", "#")


                Dim _subMenuHeader = (From c In _tabs Where c.ParentId = _menu.TabId).ToList()
                For Each item In _subMenuHeader
                    _GroupNode.Items.Add(item.TabName, item.TabId, "", item.TabName & ".aspx")
                Next
            Next

            NavigateBar = dc.ExecuteQuery(Of String)("select top 1 Navigation from V_PageID where PageID='" & portalSettings.ActiveTab.PageID & "'").FirstOrDefault()



        End Using

        'MainMenu.ExpandAll()
        MainMenu.SelectedItem = MainMenu.Items.FindAllRecursive(Function(n) ResolveUrl(n.NavigateUrl).Equals(Request.Url.LocalPath, StringComparison.InvariantCultureIgnoreCase)).FirstOrDefault()
        If MainMenu.SelectedItem IsNot Nothing AndAlso MainMenu.SelectedItem.Parent IsNot Nothing Then
            MainMenu.SelectedItem.Parent.CssClass = "active-parent"
        End If


    End Sub


    Private Sub GenControl()
        ''*********************************************************************
        '' Obtain PortalSettings from Current Context
        Dim portalSettings As PortalSettings = CType(HttpContext.Current.Items(_PortalContextName), PortalSettings)

        ' Dynamically Populate the Left, Center and Right pane sections of the portal page
        If portalSettings.ActiveTab.Modules.Count > 0 Then

            ' Loop through each entry in the configuration system for this tab
            Dim _moduleSettings As ModuleSettings
            For Each _moduleSettings In portalSettings.ActiveTab.Modules

                If PortalSecurity.IsInRoles(_moduleSettings.AuthorizedEditRoles, _moduleSettings.TabId) Then

                    'Dim parent As ContentPanel = Page.FindControl("ContentPanel1")

                    ' If no caching is specified, create the user control instance and dynamically
                    ' inject it into the page.  Otherwise, create a cached module instance that
                    ' may or may not optionally inject the module into the tree
                    If _moduleSettings.CacheTimeOut = 0 Then

                        If Not String.IsNullOrEmpty(_moduleSettings.DesktopSourceFile) Then
                            Dim _ascx = String.Format("~/App_Data/Modules/{0}", _moduleSettings.DesktopSourceFile)
                            If System.IO.File.Exists(Server.MapPath(_ascx)) Then

                                Dim portalModule As PortalModuleControl = CType(Page.LoadControl(_ascx), PortalModuleControl)

                                portalModule.PortalId = portalSettings.PortalId
                                portalModule.ModuleConfiguration = _moduleSettings

                                container.Controls.Add(portalModule)
                            End If
                        End If
                    Else

                        Dim portalModule As New CachedPortalModuleControl

                        portalModule.PortalId = portalSettings.PortalId
                        portalModule.ModuleConfiguration = _moduleSettings

                        container.Controls.Add(portalModule)
                    End If

                    ' Dynamically inject separator break between portal modules
                    container.Controls.Add(New LiteralControl("<" + "br" + ">"))
                    container.Visible = True


                End If

            Next _moduleSettings
        End If
    End Sub


    Protected Sub cbLoginOut_Callback(ByVal sender As Object, ByVal e As CallbackEventArgs) Handles cbLoginOut.Callback

        FormsAuthentication.SignOut()
        Session("CustomPrincipal") = Nothing
        HttpContext.Current.Response.Clear()

        ASPxWebControl.RedirectOnCallback("~/Default.aspx")

    End Sub


End Class
