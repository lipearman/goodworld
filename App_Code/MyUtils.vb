Imports Microsoft.VisualBasic

Public Class MyUtils
    Public Shared Function chkIDCard(ByVal _IDNO As String) As Boolean
        Dim idc As String
        Dim num As Integer = 0
        Dim i As Integer
        Try
            idc = _IDNO.Trim.Replace("-", "")
            For i = 0 To 11
                num += idc.Substring(i, 1) * (13 - i)
            Next
            num = num Mod (11)
            If num = 0 Or num = 1 Then
                If num = 0 Then
                    num = 1
                Else
                    num = 0
                End If
            Else
                num = 11 - num
            End If
            If num = idc.Substring(12, 1) Then
                Return True
            Else
                Return False
            End If
        Catch ex As Exception
            Return False
        End Try
    End Function
End Class
