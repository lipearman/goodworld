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

Partial Class Modules_ucPaymentRegister
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

    Protected Sub TaskNewPopup_Callback(ByVal sender As Object, ByVal e As CallbackEventArgsBase) Handles TaskNewPopup.Callback

        'If Not MyUtils.chkIDCard(newIdentityNo.Value) Then
        '    Throw New Exception("หมายเลขบัตรประชาชนไม่ถูกต้อง")
        'End If


        Dim args = e.Parameter.ToString()


        Select Case args.ToLower()
            Case "calpremium"
                calpremium()
            Case "savenew"
                savenew()
        End Select

    End Sub

    Private Sub savenew()
        Try
            Using dc As New DataClasses_GoodWorldExt()

                Dim chkDuppolicy = (From c In dc.v_PaymentRegisters Where c.PolicyID.Equals(CInt(hdID("ID")))).FirstOrDefault()
                If chkDuppolicy IsNot Nothing Then
                    Throw New Exception(String.Format("หมายเลขกรมธรรม์ {0} นี้มีในระบบแล้ว", chkDuppolicy.PolicyNo))
                End If


                Dim newData As New tblPaymentRegister
                With newData

                    .PolicyID = CInt(hdID("ID"))
                    .PaymentBy = newPaymentBy.Value
                    .PaymentDate = newPaymentDate.Value
                    .PaymentNo = newPaymentNo.Value

                    .BRCommP = newBrokerage.Value
                    .BRCommAmt = newBrokerageAmt.Value

                    .VAT7Amt = newVAT7Amt.Value
                    .TAX3Amt = newTAX3Amt.Value

                    .ServiceFreeP = newServiceFreeP.Value
                    .ServiceFreeAmt = newServiceFreeAmt.Value
                    .ServiceFreeTAX3Amt = newServiceFreeTAX3Amt.Value
                    .ServiceFreeVAT7Amt = newServiceFreeVAT7Amt.Value
                    .TotalPremium = newTotalPremium.Value

                    .CreateDate = DateTime.Now
                    .CreateBy = HttpContext.Current.User.Identity.Name


                End With


                dc.tblPaymentRegisters.InsertOnSubmit(newData)
                dc.SubmitChanges()

                TaskNewPopup.JSProperties("cpnewtask") = "savenew"



            End Using
        Catch ex As Exception
            TaskNewPopup.JSProperties("cpnewtask") = "error - " & ex.Message
        End Try

    End Sub


    Private Sub newpayment(ByVal _ID As String)
        Using dc As New DataClasses_GoodWorldExt()
            Dim data = (From c In dc.v_BillingDetails Where c.PolicyID.Equals(_ID)).FirstOrDefault()


            newPolicyForm.DataSource = data
            newPolicyForm.DataBind()

            newServiceFreeP.Value = 0
            newPaymentBy.Text = ""
            newPaymentNo.Text = ""
            newPaymentDate.Value = Nothing

            calpremium()

            hdID.Set("ID", _ID)







        End Using
    End Sub

    Private Sub calpremium()
        Using dc As New DataClasses_GoodWorldExt()
            Dim _Premium = newPremium.Value
            Dim _GrossPremium = newGrossPremium.Value

            Dim _Brokerage = newBrokerage.Value
            Dim _BrokerageAmt = _Premium * _Brokerage / 100
            Dim _VAT7Amt = _BrokerageAmt * 7 / 100
            Dim _TAX3Amt = _BrokerageAmt * 3 / 100

            Dim _ServiceFreeP = newServiceFreeP.Value
            Dim _ServiceFreeAmt = _Premium * _ServiceFreeP / 100
            Dim _ServiceFreeVAT7Amt = _ServiceFreeAmt * 7 / 100
            Dim _ServiceFreeTAX3Amt = _ServiceFreeAmt * 3 / 100

            Dim _TotalPremium = (_Premium + _TAX3Amt + _ServiceFreeTAX3Amt) - (_BrokerageAmt + _ServiceFreeAmt + _VAT7Amt + _ServiceFreeVAT7Amt)

            newBrokerageAmt.Value = _BrokerageAmt
            newVAT7Amt.Value = _VAT7Amt
            newTAX3Amt.Value = _TAX3Amt
            newServiceFreeAmt.Value = _ServiceFreeAmt
            newServiceFreeVAT7Amt.Value = _ServiceFreeVAT7Amt
            newServiceFreeTAX3Amt.Value = _ServiceFreeTAX3Amt
            newTotalPremium.Value = _TotalPremium



        End Using
    End Sub


    Private Sub calpremium2()
        Using dc As New DataClasses_GoodWorldExt()
            Dim _Premium = editPremium.Value
            Dim _GrossPremium = editGrossPremium.Value

            Dim _Brokerage = editBrokerage.Value
            Dim _BrokerageAmt = _Premium * _Brokerage / 100
            Dim _VAT7Amt = _BrokerageAmt * 7 / 100
            Dim _TAX3Amt = _BrokerageAmt * 3 / 100

            Dim _ServiceFreeP = editServiceFreeP.Value
            Dim _ServiceFreeAmt = _Premium * _ServiceFreeP / 100
            Dim _ServiceFreeVAT7Amt = _ServiceFreeAmt * 7 / 100
            Dim _ServiceFreeTAX3Amt = _ServiceFreeAmt * 3 / 100

            Dim _TotalPremium = (_Premium + _TAX3Amt + _ServiceFreeTAX3Amt) - (_BrokerageAmt + _ServiceFreeAmt + _VAT7Amt + _ServiceFreeVAT7Amt)

            editBrokerageAmt.Value = _BrokerageAmt
            editVAT7Amt.Value = _VAT7Amt
            editTAX3Amt.Value = _TAX3Amt
            editServiceFreeAmt.Value = _ServiceFreeAmt
            editServiceFreeVAT7Amt.Value = _ServiceFreeVAT7Amt
            editServiceFreeTAX3Amt.Value = _ServiceFreeTAX3Amt
            editTotalPremium.Value = _TotalPremium



        End Using
    End Sub




    Protected Sub TaskEditPopup_Callback(ByVal sender As Object, ByVal e As CallbackEventArgsBase) Handles TaskEditPopup.Callback
        Dim args = e.Parameter.ToString()

        If args.ToLower().StartsWith("edit") Then
            Dim params = args.Split("|")
            Dim _ID = params(1)
            TaskEditPopup.JSProperties("cpedittask") = params(0)
            hdID.Set("ID", _ID)
            edit(_ID)
            TaskEditPopup.ShowOnPageLoad = True
        Else

            Select Case args.ToLower()
                Case "calpremium"
                    calpremium2()
                Case "saveedit"
                    update(hdID("ID"))
                    TaskEditPopup.JSProperties("cpedittask") = "saveedit"
            End Select


        End If





    End Sub

    Private Sub update(ByVal _ID As String)
        Try
            Using dc As New DataClasses_GoodWorldExt()

                Dim data = (From c In dc.tblPaymentRegisters Where c.ID.Equals(_ID)).FirstOrDefault()


                With data

                    .PaymentBy = editPaymentBy.Value
                    .PaymentDate = editPaymentDate.Value
                    .PaymentNo = editPaymentNo.Value

                    .BRCommP = editBrokerage.Value
                    .BRCommAmt = editBrokerageAmt.Value

                    .VAT7Amt = editVAT7Amt.Value
                    .TAX3Amt = editTAX3Amt.Value

                    .ServiceFreeP = editServiceFreeP.Value
                    .ServiceFreeAmt = editServiceFreeAmt.Value
                    .ServiceFreeTAX3Amt = editServiceFreeTAX3Amt.Value
                    .ServiceFreeVAT7Amt = editServiceFreeVAT7Amt.Value
                    .TotalPremium = editTotalPremium.Value

                    .ModifyDate = DateTime.Now
                    .ModifyBy = HttpContext.Current.User.Identity.Name


                End With

                dc.SubmitChanges()

                TaskNewPopup.JSProperties("cpedittask") = "saveedit"



            End Using
        Catch ex As Exception
            TaskNewPopup.JSProperties("cpedittask") = "error - " & ex.Message
        End Try

    End Sub




    Private Sub edit(ByVal _ID As String)
        Using dc As New DataClasses_GoodWorldExt()
            Dim data = (From c In dc.v_PaymentRegisters Where c.ID.Equals(_ID)).FirstOrDefault()


            editPolicyForm.DataSource = data
            editPolicyForm.DataBind()

        End Using
    End Sub




    Protected Sub TaskGrid_HtmlRowCreated(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridViewTableRowEventArgs) Handles TaskGrid.HtmlRowPrepared


        If e.RowType <> DevExpress.Web.GridViewRowType.Data Then
            Return
        End If

        Dim EditButton As BootstrapButton = TaskGrid.FindRowCellTemplateControl(e.VisibleIndex, Nothing, "EditButton")
        EditButton.JSProperties.Add("cpID", e.KeyValue().ToString())



    End Sub





    Protected Sub PolicyNo_ItemRequestedByValue(source As Object, e As ListEditItemRequestedByValueEventArgs) Handles PolicyNoFilter.ItemRequestedByValue
        Dim value As Long = 0
        If e.Value Is Nothing Then
            Return
        End If
        Dim comboBox As ASPxComboBox = CType(source, ASPxComboBox)
        SqlDataSource1.SelectCommand = "select ClientName from v_BillingDetails where PolicyNo like @PolicyNo and isnull(PolicyNo,'') <> '' and PolicyID not in (select PolicyID from tblPaymentRegister)"
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
        sb.Append(" select v_BillingDetails.* ")
        sb.Append(" , row_number()over(order by v_BillingDetails.PolicyNo) as [rn] ")
        sb.Append(" from v_BillingDetails ")
        sb.Append(" where PolicyNo LIKE @filter and isnull(PolicyNo,'') <> '' and PolicyID not in (select PolicyID from tblPaymentRegister)")
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



    Protected Sub AddPolicyNo_Click(sender As Object, e As EventArgs) Handles AddPolicyNo.Click
        Dim _ID = PolicyNoFilter.Value
        PolicyNoFilter.Text = ""

        newpayment(_ID)
        TaskNewPopup.ShowOnPageLoad = True
        PolicyNoFilter.DataBind()
    End Sub
End Class
