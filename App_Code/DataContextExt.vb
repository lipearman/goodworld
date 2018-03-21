Imports Microsoft.VisualBasic
Imports Portal.Components
Imports Microsoft.VisualBasic.FileIO
Imports System.Configuration
Imports System.ComponentModel
Imports System.IO




Partial Public Class DataClasses_GoodWorldExt
    Inherits DataClasses_GoodWorldDataContext
    Private Shared ReadOnly Property ConnectionString() As String
        Get
            Dim Conn As String = ConfigurationManager.ConnectionStrings("PortalConnectionString").ConnectionString

            Return Conn
        End Get
    End Property
    Public Sub New()
        MyBase.New(ConnectionString)
    End Sub
End Class






Public Class MyObjectDataSource
    Public Function GetModulePath(ByVal rootpath As String, ByVal pathname As String) As List(Of String)
        Dim dir = New DirectoryInfo(rootpath & "\" & pathname)
        Dim files = dir.GetFiles()
        Dim listItems As New List(Of String)
        For Each item In files
            If item.Name.EndsWith(".ascx") Then listItems.Add(pathname & "/" & item.Name)
        Next
        Return listItems
    End Function
End Class




