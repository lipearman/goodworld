
Imports DevExpress.Web
Imports DevExpress.Web.Bootstrap

Partial Class Test
    Inherits System.Web.UI.Page



    Protected Sub newClientName_ItemRequestedByValue(source As Object, e As ListEditItemRequestedByValueEventArgs)
        Dim value As Long = 0
        If e.Value Is Nothing Then
            Return
        End If
        Dim comboBox As BootstrapComboBox = CType(source, BootstrapComboBox)
        SqlDataSource1.SelectCommand = "select ClientName from tblPolicyRegister where ClientName like @ClientName Group By ClientName Order By ClientName"

        SqlDataSource1.SelectParameters.Clear()
        SqlDataSource1.SelectParameters.Add("ClientName", TypeCode.String, e.Value.ToString())
        comboBox.DataSource = SqlDataSource1
        comboBox.DataBind()
    End Sub
    Protected Sub newClientName_ItemsRequestedByFilterCondition(source As Object, e As ListEditItemsRequestedByFilterConditionEventArgs)
        Dim comboBox As BootstrapComboBox = CType(source, BootstrapComboBox)

        Dim sb As New StringBuilder()
        sb.Append(" SELECT ClientName")
        sb.Append(" FROM (")
        sb.Append(" select ClientName")
        sb.Append(" , row_number()over(order by t.ClientName) as [rn] ")
        sb.Append(" from (select ClientName from tblPolicyRegister where ClientName like @filter Group By ClientName) as t ")
        sb.Append(" where ClientName LIKE @filter")
        sb.Append(" ) as st ")
        sb.Append(" where st.[rn] between @startIndex and @endIndex")

        SqlDataSource1.SelectCommand = sb.ToString()

        SqlDataSource1.SelectParameters.Clear()
        SqlDataSource1.SelectParameters.Add("filter", TypeCode.String, String.Format("%{0}%", e.Filter))
        SqlDataSource1.SelectParameters.Add("startIndex", TypeCode.Int64, (e.BeginIndex + 1).ToString())
        SqlDataSource1.SelectParameters.Add("endIndex", TypeCode.Int64, (e.EndIndex + 1).ToString())
        comboBox.DataSource = SqlDataSource1
        comboBox.DataBind()
    End Sub

End Class
