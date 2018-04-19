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


    Public Shared Function GenThaiDate(ByVal _Date As Date, ByVal intParameter As Integer) As String
        Dim strMonth As String = String.Empty
        Select Case _Date.Month.ToString
            Case "1"
                If intParameter = 1 Then
                    strMonth = "ม.ค"
                ElseIf intParameter = 2 Then
                    strMonth = "มกราคม"
                End If

            Case "2"
                If intParameter = 1 Then
                    strMonth = "ก.พ"
                ElseIf intParameter = 2 Then
                    strMonth = "กุมภาพันธ์"
                End If

            Case "3"
                If intParameter = 1 Then
                    strMonth = "มี.ค"
                ElseIf intParameter = 2 Then
                    strMonth = "มีนาคม"
                End If

            Case "4"
                If intParameter = 1 Then
                    strMonth = "เม.ษ"
                ElseIf intParameter = 2 Then
                    strMonth = "เมษายน"
                End If

            Case "5"
                If intParameter = 1 Then
                    strMonth = "พ.ค"
                ElseIf intParameter = 2 Then
                    strMonth = "พฤษภาคม"
                End If

            Case "6"
                If intParameter = 1 Then
                    strMonth = "มิ.ย"
                ElseIf intParameter = 2 Then
                    strMonth = "มิถุนายน"
                End If

            Case "7"
                If intParameter = 1 Then
                    strMonth = "ก.ค"
                ElseIf intParameter = 2 Then
                    strMonth = "กรกฏาคม"
                End If

            Case "8"
                If intParameter = 1 Then
                    strMonth = "ส.ค"
                ElseIf intParameter = 2 Then
                    strMonth = "สิงหาคม"
                End If

            Case "9"
                If intParameter = 1 Then
                    strMonth = "ก.ย"
                ElseIf intParameter = 2 Then
                    strMonth = "กันยายน"
                End If

            Case "10"
                If intParameter = 1 Then
                    strMonth = "ต.ค"
                ElseIf intParameter = 2 Then
                    strMonth = "ตุลาคม"
                End If

            Case "11"
                If intParameter = 1 Then
                    strMonth = "พ.ย"
                ElseIf intParameter = 2 Then
                    strMonth = "พฤศจิกายน"
                End If

            Case "12"
                If intParameter = 1 Then
                    strMonth = "ธ.ค"
                ElseIf intParameter = 2 Then
                    strMonth = "ธันวาคม"
                End If

        End Select


        Return String.Format("{0} {1} {2}", _Date.Day.ToString(), strMonth, IIf(_Date.Year > 2500, _Date.Year.ToString(), (_Date.Year + 543).ToString()))

    End Function
    Public Shared Function GenThaiMonthlyDate(ByVal _Date As Date, ByVal intParameter As Integer) As String
        Dim strMonth As String = String.Empty
        Select Case _Date.Month.ToString
            Case "1"
                If intParameter = 1 Then
                    strMonth = "ม.ค"
                ElseIf intParameter = 2 Then
                    strMonth = "มกราคม"
                End If

            Case "2"
                If intParameter = 1 Then
                    strMonth = "ก.พ"
                ElseIf intParameter = 2 Then
                    strMonth = "กุมภาพันธ์"
                End If

            Case "3"
                If intParameter = 1 Then
                    strMonth = "มี.ค"
                ElseIf intParameter = 2 Then
                    strMonth = "มีนาคม"
                End If

            Case "4"
                If intParameter = 1 Then
                    strMonth = "เม.ษ"
                ElseIf intParameter = 2 Then
                    strMonth = "เมษายน"
                End If

            Case "5"
                If intParameter = 1 Then
                    strMonth = "พ.ค"
                ElseIf intParameter = 2 Then
                    strMonth = "พฤษภาคม"
                End If

            Case "6"
                If intParameter = 1 Then
                    strMonth = "มิ.ย"
                ElseIf intParameter = 2 Then
                    strMonth = "มิถุนายน"
                End If

            Case "7"
                If intParameter = 1 Then
                    strMonth = "ก.ค"
                ElseIf intParameter = 2 Then
                    strMonth = "กรกฏาคม"
                End If

            Case "8"
                If intParameter = 1 Then
                    strMonth = "ส.ค"
                ElseIf intParameter = 2 Then
                    strMonth = "สิงหาคม"
                End If

            Case "9"
                If intParameter = 1 Then
                    strMonth = "ก.ย"
                ElseIf intParameter = 2 Then
                    strMonth = "กันยายน"
                End If

            Case "10"
                If intParameter = 1 Then
                    strMonth = "ต.ค"
                ElseIf intParameter = 2 Then
                    strMonth = "ตุลาคม"
                End If

            Case "11"
                If intParameter = 1 Then
                    strMonth = "พ.ย"
                ElseIf intParameter = 2 Then
                    strMonth = "พฤศจิกายน"
                End If

            Case "12"
                If intParameter = 1 Then
                    strMonth = "ธ.ค"
                ElseIf intParameter = 2 Then
                    strMonth = "ธันวาคม"
                End If

        End Select


        Return String.Format("{0} {1}", strMonth, IIf(_Date.Year > 2500, _Date.Year.ToString(), (_Date.Year + 543).ToString()))

    End Function


End Class
