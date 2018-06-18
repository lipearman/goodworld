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

Partial Class Applications_UWBillingRegister
    Inherits System.Web.UI.Page
    Private Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

        If IsPostBack = False Then
            Dim _ID = Request.Params("ID")
            hdID.Set("ID", _ID)
            Session("UWBillingID") = _ID
            edit(_ID)
        End If

    End Sub
    Private Sub edit(ByVal _ID As String)
        Using dc As New DataClasses_GoodWorldExt()
            Dim data = (From c In dc.v_UWBillingRegisters Where c.ID.Equals(_ID)).FirstOrDefault()


            formPreview.DataSource = data
            formPreview.DataBind()

            'grid_SubBillingDetails.DataBind()
            SqlDataSource_UWBillingPremium.DataBind()
        End Using
    End Sub
    Protected Sub AddPolicyNo_Click(sender As Object, e As EventArgs) Handles AddPolicyNo.Click
        Dim _PolicyID = PolicyNoFilter.Value
        PolicyNoFilter.Text = ""

        newpayment(_PolicyID)
        TaskNewPopup2.ShowOnPageLoad = True
        PolicyNoFilter.DataBind()
    End Sub
    Private Sub newpayment(ByVal _PolicyID As String)
        Using dc As New DataClasses_GoodWorldExt()
            Dim data = (From c In dc.v_Report1s Where c.ID.Equals(_PolicyID)).FirstOrDefault()


            newPolicyForm.DataSource = data
            newPolicyForm.DataBind()

            newServiceFreeP.Value = 0
            newPaymentBy.Text = ""
            newPaymentNo.Text = ""
            newPaymentDate.Value = Nothing

            calpremium()

            hdID.Set("PolicyID", _PolicyID)
        End Using
    End Sub

    Protected Sub TaskNewPopup2_Callback(ByVal sender As Object, ByVal e As CallbackEventArgsBase) Handles TaskNewPopup2.Callback
        Dim args = e.Parameter.ToString()


        Select Case args.ToLower()
            Case "calpremium"
                calpremium()
            Case "savenew"
                savenew2()
        End Select

    End Sub
    Private Sub savenew2()
        Try
            Using dc As New DataClasses_GoodWorldExt()

                Dim chkDuppolicy = (From c In dc.v_UWBillingPolicies Where c.PolicyID.Equals(CInt(hdID("PolicyID")))).FirstOrDefault()
                If chkDuppolicy IsNot Nothing Then
                    Throw New Exception(String.Format("หมายเลขกรมธรรม์ {0} นี้มีในระบบแล้ว", chkDuppolicy.PolicyNo))
                End If


                Dim newData As New tblUWBillingPolicy
                With newData
                    .UWBillingID = CInt(hdID("ID"))
                    .PolicyID = CInt(hdID("PolicyID"))
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


                dc.tblUWBillingPolicies.InsertOnSubmit(newData)
                dc.SubmitChanges()


                PolicyNoFilter.DataBind()

                TaskNewPopup2.JSProperties("cpnewtask") = "savenew"



            End Using
        Catch ex As Exception
            TaskNewPopup2.JSProperties("cpnewtask") = "error - " & ex.Message
        End Try

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

            'Dim _TotalPremium = (_Premium + _TAX3Amt + _ServiceFreeTAX3Amt) - (_BrokerageAmt + _ServiceFreeAmt + _VAT7Amt + _ServiceFreeVAT7Amt)
            Dim _TotalPremium = _GrossPremium - _BrokerageAmt - _VAT7Amt + _TAX3Amt - _ServiceFreeAmt - _ServiceFreeVAT7Amt + _ServiceFreeTAX3Amt

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

            'Dim _TotalPremium = (_Premium + _TAX3Amt + _ServiceFreeTAX3Amt) - (_BrokerageAmt + _ServiceFreeAmt + _VAT7Amt + _ServiceFreeVAT7Amt)
            Dim _TotalPremium = _GrossPremium - _BrokerageAmt - _VAT7Amt + _TAX3Amt - _ServiceFreeAmt - _ServiceFreeVAT7Amt + _ServiceFreeTAX3Amt

            editBrokerageAmt.Value = _BrokerageAmt
            editVAT7Amt.Value = _VAT7Amt
            editTAX3Amt.Value = _TAX3Amt
            editServiceFreeAmt.Value = _ServiceFreeAmt
            editServiceFreeVAT7Amt.Value = _ServiceFreeVAT7Amt
            editServiceFreeTAX3Amt.Value = _ServiceFreeTAX3Amt
            editTotalPremium.Value = _TotalPremium



        End Using
    End Sub



    Protected Sub TaskEditPopup2_Callback(ByVal sender As Object, ByVal e As CallbackEventArgsBase) Handles TaskEditPopup2.Callback
        Dim args = e.Parameter.ToString()

        If args.ToLower().StartsWith("edit") Then
            Dim params = args.Split("|")
            Dim _ID = params(1)
            TaskEditPopup2.JSProperties("cpedittask") = params(0)
            hdID.Set("ID", _ID)
            edit2(_ID)
            TaskEditPopup2.ShowOnPageLoad = True
        Else

            Select Case args.ToLower()
                Case "calpremium"
                    calpremium2()
                Case "saveedit"
                    update2(hdID("ID"))
                    TaskEditPopup2.JSProperties("cpedittask") = "saveedit"
            End Select


        End If





    End Sub
    Private Sub edit2(ByVal _ID As String)
        Using dc As New DataClasses_GoodWorldExt()
            Dim data = (From c In dc.v_UWBillingPolicies Where c.ID.Equals(_ID)).FirstOrDefault()


            editPolicyForm.DataSource = data
            editPolicyForm.DataBind()

        End Using
    End Sub

    Private Sub update2(ByVal _ID As String)
        Try
            Using dc As New DataClasses_GoodWorldExt()

                Dim data = (From c In dc.tblUWBillingPolicies Where c.ID.Equals(_ID)).FirstOrDefault()


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

                TaskEditPopup2.JSProperties("cpedittask") = "saveedit"



            End Using
        Catch ex As Exception
            TaskEditPopup2.JSProperties("cpedittask") = "error - " & ex.Message
        End Try

    End Sub

    Protected Sub TaskGrid2_HtmlRowCreated(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridViewTableRowEventArgs) Handles taskGrid2.HtmlRowPrepared


        If e.RowType <> DevExpress.Web.GridViewRowType.Data Then
            Return
        End If

        Dim EditButton As BootstrapButton = taskGrid2.FindRowCellTemplateControl(e.VisibleIndex, Nothing, "EditButton")
        EditButton.JSProperties.Add("cpID", e.KeyValue().ToString())



    End Sub
    Protected Sub PolicyNo_ItemRequestedByValue(source As Object, e As ListEditItemRequestedByValueEventArgs) Handles PolicyNoFilter.ItemRequestedByValue
        Dim value As Long = 0
        If e.Value Is Nothing Then
            Return
        End If
        Dim _ID = 0
        If Session("UWBillingID") IsNot Nothing Then _ID = CInt(Session("UWBillingID"))
        Dim _UWCODE = ""
        Using dc As New DataClasses_GoodWorldExt()
            Dim data = (From c In dc.v_UWBillingRegisters Where c.ID.Equals(_ID)).FirstOrDefault()
            If data IsNot Nothing Then _UWCODE = data.InsurerCode
        End Using

        Dim comboBox As ASPxComboBox = CType(source, ASPxComboBox)
        SqlDataSource1.SelectCommand = "select ClientName from v_Report1 where InsurerCode like @InsurerCode and PolicyNo like @PolicyNo and isnull(PolicyNo,'') <> '' and ID not in (select PolicyID from tblUWBillingPolicy)"
        SqlDataSource1.SelectParameters.Clear()
        SqlDataSource1.SelectParameters.Add("PolicyNo", TypeCode.String, e.Value.ToString())
        SqlDataSource1.SelectParameters.Add("InsurerCode", TypeCode.String, _UWCODE)
        comboBox.DataSource = SqlDataSource1
        comboBox.DataBind()
    End Sub
    Protected Sub PolicyNo_ItemsRequestedByFilterCondition(source As Object, e As ListEditItemsRequestedByFilterConditionEventArgs) Handles PolicyNoFilter.ItemsRequestedByFilterCondition
        Dim comboBox As ASPxComboBox = CType(source, ASPxComboBox)

        Dim _ID = 0
        If Session("UWBillingID") IsNot Nothing Then _ID = CInt(Session("UWBillingID"))
        Dim _UWCODE = ""
        Using dc As New DataClasses_GoodWorldExt()
            Dim data = (From c In dc.v_UWBillingRegisters Where c.ID.Equals(_ID)).FirstOrDefault()
            If data IsNot Nothing Then _UWCODE = data.InsurerCode
        End Using

        Dim sb As New StringBuilder()
        sb.Append(" SELECT st.* ")
        sb.Append(" FROM (")
        sb.Append(" select v_Report1.* ")
        sb.Append(" , row_number()over(order by v_Report1.PolicyNo) as [rn] ")
        sb.Append(" from v_Report1 ")
        sb.Append(" where InsurerCode like @InsurerCode and PolicyNo LIKE @filter and isnull(PolicyNo,'') <> '' and ID not in (select PolicyID from tblUWBillingPolicy)")
        sb.Append(" ) as st ")
        sb.Append(" where st.[rn] between @startIndex and @endIndex")

        SqlDataSource1.SelectCommand = sb.ToString()

        SqlDataSource1.SelectParameters.Clear()
        SqlDataSource1.SelectParameters.Add("filter", TypeCode.String, String.Format("%{0}%", e.Filter))
        SqlDataSource1.SelectParameters.Add("startIndex", TypeCode.Int64, (e.BeginIndex + 1).ToString())
        SqlDataSource1.SelectParameters.Add("endIndex", TypeCode.Int64, (e.EndIndex + 1).ToString())
        SqlDataSource1.SelectParameters.Add("InsurerCode", TypeCode.String, _UWCODE)
        comboBox.DataSource = SqlDataSource1
        comboBox.DataBind()
    End Sub




    Protected Sub btnPreview_Click(sender As Object, e As EventArgs)
        Dim _UWBillingID = CInt(hdID("ID"))

        edit(_UWBillingID)

        Using dc As New DataClasses_GoodWorldExt()
            Dim data = (From c In dc.v_UWBillingRegisters Where c.ID.Equals(_UWBillingID)).FirstOrDefault()


            Dim sb As New StringBuilder()
            sb.Append(" SELECT * ")
            sb.Append(" FROM v_UWBillingPolicy ")
            sb.AppendFormat(" where UWBillingID='{0}' ", _UWBillingID)
            Dim ds1 = SqlHelper.ExecuteDataset(ConfigurationManager.ConnectionStrings("PortalConnectionString").ConnectionString, System.Data.CommandType.Text, sb.ToString())

            sb = New StringBuilder()
            sb.Append(" SELECT * ")
            sb.Append(" FROM tblUWBillingPremium ")
            sb.AppendFormat(" where UWBillingID='{0}' ", _UWBillingID)
            Dim ds2 = SqlHelper.ExecuteDataset(ConfigurationManager.ConnectionStrings("PortalConnectionString").ConnectionString, System.Data.CommandType.Text, sb.ToString())


            Dim ReportViewer1 As New ReportViewer()
            Dim ReportFile As String = "rptUWBilling.rdl"
            ReportViewer1.Reset()
            ReportViewer1.LocalReport.Dispose()
            ReportViewer1.LocalReport.DataSources.Clear()
            ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/App_Data/reports/" & ReportFile)
            ReportViewer1.LocalReport.DataSources.Add(New ReportDataSource("DataSet1", ds1.Tables(0)))
            ReportViewer1.LocalReport.DataSources.Add(New ReportDataSource("DataSet2", ds2.Tables(0)))

            'BillingDate
            'ReportViewer1.LocalReport.SetParameters(New ReportParameter("BillingDate", data.BillingDate.Value.ToString("dd/MM/yyyy")))


            ReportViewer1.LocalReport.Refresh()


            Dim warnings As Warning()
            Dim streamids As String()
            Dim mimeType As String
            Dim encoding As String
            Dim extension As String
            Dim bytes As Byte() = ReportViewer1.LocalReport.Render("Excel", Nothing, mimeType, encoding, extension, streamids, warnings)

            Dim _GUID = System.Guid.NewGuid().ToString()
            Session("GUID") = _GUID

            Dim FileName = Server.MapPath(String.Format("~/App_Data/UploadTemp/{0}.xls", _GUID))

            Using fs As FileStream = New FileStream(FileName, FileMode.Create)
                fs.Write(bytes, 0, bytes.Length)
                fs.Close()
            End Using

            clientReportPreview.ShowOnPageLoad() = True

            'documentViewer.Document = String.Format("~/App_Data/UploadTemp/{0}.xls", _GUID)

            clientReportPreview.ShowOnPageLoad() = True

            Spreadsheet.Open(FileName)
        End Using

    End Sub




End Class
