Imports System.Data
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
Imports DevExpress.Web.Bootstrap
Imports DevExpress.XtraPrinting
Imports DevExpress.Export
Imports Microsoft.Reporting.WebForms

Partial Class Modules_ucUWBillingPayment
    Inherits PortalModuleControl
    Protected PageName As String
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim portalSettings As PortalSettings = CType(HttpContext.Current.Items(webconfig._PortalContextName), PortalSettings)
        If Not PortalSecurity.IsInRoles(portalSettings.ActiveTab.AuthorizedRoles, portalSettings.ActiveTab.TabId) = True Then
            Response.Redirect("~/Admin/AccessDenied.aspx")
        End If
        PageName = portalSettings.ActiveTab.TabName
        Session("PortalId") = webconfig._PortalID

    End Sub
    Protected Sub TaskGrid_ToolbarItemClick(ByVal sender As Object, ByVal e As BootstrapGridViewToolbarItemClickEventArgs) Handles TaskGrid.ToolbarItemClick

        Select Case e.Item.Name
            Case "ExportToXLS"
                TaskGrid.ExportXlsToResponse(New XlsExportOptionsEx With {.ExportType = ExportType.WYSIWYG})
            Case "ExportToXLSX"
                TaskGrid.ExportXlsxToResponse(New XlsxExportOptionsEx With {.ExportType = ExportType.WYSIWYG})
        End Select
    End Sub

    Protected Sub AddPolicyNo_Click(sender As Object, e As EventArgs) Handles AddPolicyNo.Click
        Dim _PolicyID = PolicyNoFilter.Value
        Dim _PaymentDate = PaymentDate.Value

        Using dc As New DataClasses_GoodWorldExt()


            Dim _newData As New tblUWBillingPayment
            With _newData

                .PolicyID = _PolicyID
                .PaymentDate = _PaymentDate
                .CreateDate = Now
                .CreateBy = HttpContext.Current.User.Identity.Name

            End With

            dc.tblUWBillingPayments.InsertOnSubmit(_newData)
            dc.SubmitChanges()

        End Using

        PolicyNoFilter.Text = ""
        PaymentDate.Value = Nothing

        TaskGrid.DataBind()
    End Sub


    Protected Sub PolicyNo_ItemRequestedByValue(source As Object, e As ListEditItemRequestedByValueEventArgs) Handles PolicyNoFilter.ItemRequestedByValue
        Dim value As Long = 0
        If e.Value Is Nothing Then
            Return
        End If
        Dim comboBox As ASPxComboBox = CType(source, ASPxComboBox)
        SqlDataSource1.SelectCommand = "select PolicyNo from v_UWBillingDetails where v_UWBillingDetails.PolicyID not in (select PolicyID from tblUWBillingPayment) and PolicyNo <> '' and  PolicyNo like @PolicyNo and isnull(PolicyNo,'') <> ''"

        SqlDataSource1.SelectParameters.Clear()
        SqlDataSource1.SelectParameters.Add("PolicyNo", TypeCode.String, e.Value.ToString())
        comboBox.DataSource = SqlDataSource1
        comboBox.DataBind()
    End Sub
    Protected Sub PolicyNo_ItemsRequestedByFilterCondition(source As Object, e As ListEditItemsRequestedByFilterConditionEventArgs) Handles PolicyNoFilter.ItemsRequestedByFilterCondition
        Dim comboBox As ASPxComboBox = CType(source, ASPxComboBox)

        Dim sb As New StringBuilder()
        sb.Append(" SELECT st.* ")
        sb.Append(" FROM (")
        sb.Append(" select v_UWBillingDetails.* ")
        sb.Append(" , row_number()over(order by v_UWBillingDetails.PolicyNo) as [rn] ")
        sb.Append(" from v_UWBillingDetails ")
        sb.Append(" where v_UWBillingDetails.PolicyID not in (select PolicyID from tblUWBillingPayment) and PolicyNo <> '' and PolicyNo LIKE @filter and isnull(PolicyNo,'') <> '' ")
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
