Imports System
Imports DevExpress.Web
Imports Portal.Components
Imports LWT.Website
Partial Public Class _Default
    Inherits System.Web.UI.Page
    Protected _PortalContextName As String = ConfigurationSettings.AppSettings("PortalContextName")

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
      
    End Sub


    Protected Sub cbSignIn_Callback(ByVal sender As Object, ByVal e As CallbackEventArgs) Handles cbSignIn.Callback
        Dim data = e.Parameter.ToString().Split("|")

        Dim _username = data(0)
        Dim _password = data(1)



      
        Using dc As New DataClasses_PortalDataContextExt()

            Dim _data = (From c In dc.Portal_Users Where c.UserName.Equals(_username) Select c).FirstOrDefault()
            If _data Is Nothing Then
                e.Result = "No User in System"
                Return
            End If
             

            If Not _data.Password.Equals(_password) Then
                e.Result = "Invalid Password"
                Return

            End If


            dc.ExecuteCommand("insert into tblLogin_Log(UserName,IP,CREATEDATE) Values({0},{1},getdate())", _username, Context.Request.UserHostAddress)


            FormsAuthentication.SetAuthCookie(_data.UserName, True)
            Dim _defaultPage = (From c In dc.Portal_Users_DefaultPages Where c.PortalId.Equals(ConfigurationSettings.AppSettings("PortalID")) And c.UserId = _data.UserID).FirstOrDefault()
            If _defaultPage IsNot Nothing Then
                Dim defaulttab = (From c In dc.v_DesktopTabs Where c.TabId = _defaultPage.TabId And c.PortalId.Equals(ConfigurationSettings.AppSettings("PortalID"))).FirstOrDefault()

                'ASPxWebControl.RedirectOnCallback(defaulttab.TabName & ".aspx")
                ASPxWebControl.RedirectOnCallback(String.Format("~/DesktopDefault.aspx?pageid={0}", defaulttab.PageId))
            Else

                ASPxWebControl.RedirectOnCallback(String.Format("~/DesktopDefault.aspx?pageid={0}", webconfig._DefaultPageID))
                'ASPxWebControl.RedirectOnCallback("home.aspx")
            End If



        End Using

        e.Result = "success"



    End Sub
End Class
