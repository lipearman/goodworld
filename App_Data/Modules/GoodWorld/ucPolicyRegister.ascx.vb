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

Partial Class Modules_ucPolicyRegister
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




    Protected Sub TaskNewPopup_Callback(ByVal sender As Object, ByVal e As CallbackEventArgsBase) Handles TaskNewPopup.Callback

        'If Not MyUtils.chkIDCard(newIdentityNo.Value) Then
        '    Throw New Exception("หมายเลขบัตรประชาชนไม่ถูกต้อง")
        'End If


        Dim args = e.Parameter.ToString()
        TaskNewPopup.JSProperties("cpnewtask") = args.ToLower()


        Select Case args.ToLower()
            Case "calpremium"
                calpremium()
            Case "calvatstamp"
                calvatstamp()
            Case "clientselect"
                clientselect()
            Case "savenew"
                savenew()
        End Select



    End Sub

    Private Sub clientselect()
        Using dc As New DataClasses_GoodWorldExt()
            Dim _data = (From c In dc.tblPolicyRegisters Where c.ClientName.Equals(newClientName.Value) Order By c.EffectiveDate Descending).FirstOrDefault()

            If _data IsNot Nothing Then
                newAddress1.Value = _data.Address1
                newAddress2.Value = _data.Address2
                newDOB.Value = _data.DOB
                newIdentityNo.Value = _data.IdentityNo
                newTelNo.Value = _data.TelNo
                newMobile.Value = _data.Mobile
                newFax.Text = _data.Fax
                newEmail.Text = _data.Email
                newSocialMediaNo.Text = _data.SocialMediaNo
                newBenefitName.Text = _data.BenefitName
            End If


        End Using
    End Sub

    Private Sub calvatstamp()
        Dim _Premium = IIf(newPremium.Value IsNot Nothing, newPremium.Value, 0)
        Dim _Stamp = IIf(newStamp.Value IsNot Nothing, newStamp.Value, 0)
        Dim _Vat = IIf(newVat.Value IsNot Nothing, newVat.Value, 0)
        Dim _GrossPremium = _Premium + _Stamp + _Vat
        newGrossPremium.Value = _GrossPremium
    End Sub



    Private Sub calpremium()
        Using dc As New DataClasses_GoodWorldExt()
            'Dim _insurercode = newInsurerCode.Value
            Dim _InsureType = IIf(newInsureType.Value IsNot Nothing, newInsureType.Value, 0)

            Dim _Premium = IIf(newPremium.Value IsNot Nothing, newPremium.Value, 0)
            Dim _Stamp = Math.Ceiling((Convert.ToDouble(_Premium) * 0.004))
            Dim _Vat = (_Stamp + Convert.ToDouble(_Premium)) * 0.07
            Dim _GrossPremium = _Premium + _Stamp + _Vat

            Dim _newBRCommP = 0.0
            Dim _newBRCommAmt = 0.0

            Dim data = (From c In dc.tblInsureTypes Where c.ID.Equals(_InsureType)).FirstOrDefault()

            If data IsNot Nothing Then
                _newBRCommP = data.Commission
                _newBRCommAmt = _Premium * _newBRCommP / 100
            End If

            newStamp.Value = _Stamp
            newVat.Value = _Vat
            newGrossPremium.Value = _GrossPremium
            newBRCommAmt.Value = _newBRCommAmt

        End Using
    End Sub

    Private Sub savenew()
        Try
            Using dc As New DataClasses_GoodWorldExt()
                If Not String.IsNullOrEmpty(newPolicyNo.Value) Then
                    Dim chkDuppolicy = (From c In dc.tblPolicyRegisters Where c.PolicyNo.Equals(newPolicyNo.Value)).FirstOrDefault()
                    If chkDuppolicy IsNot Nothing Then
                        Throw New Exception(String.Format("หมายเลขกรมธรรม์ {0} นี้มีในระบบแล้ว", newPolicyNo.Value))
                    End If
                End If



                Dim newData As New tblPolicyRegister
                With newData
                    'บริษัทประกัน/ตัวแทน
                    .InsurerCode = newInsurerCode.Value
                    .AgentCode = newAgentCode.Value
                    'ผู้เอาประกัน
                    .CustomerType = newCustomerType.Value
                    '.FirstName = newFirstName.Value
                    '.LastName = newLastName.Value
                    .ClientName = newClientName.Text
                    .Address1 = newAddress1.Value
                    .Address2 = newAddress2.Value
                    .DOB = newDOB.Value
                    .IdentityNo = newIdentityNo.Value
                    .TelNo = newTelNo.Value
                    .Mobile = newMobile.Value
                    .Fax = newFax.Text
                    .Email = newEmail.Text
                    .SocialMediaNo = newSocialMediaNo.Text
                    .BenefitName = newBenefitName.Text

                    'รายละเอียดกรมธรรม์
                    .PolicyType = newPolicyType.Value
                    .NewRenew = newNewRenew.Value
                    .RenewPolicyYear = CInt(newRenewPolicyYear.Value)
                    .PolicyNo = newPolicyNo.Value
                    .EffectiveDate = newEffectiveDate.Value
                    .ExpiredDate = newExpiredDate.Value
                    .InsureType = CInt(newInsureType.Value)


                    'รายละเอียดรถคันที่เอาประกันภัย
                    .CarType = CInt(newCarType.Value)
                    .CarBrandModel = CInt(newCarBrandModel.Value)
                    .CarRegYear = newCarRegYear.Value
                    .CarLicensePlate = newCarLicensePlate.Value
                    .Engine = newEngine.Text
                    .Chassis = newChassis.Text
                    .CarSize = newCarSize.Text
                    .ChassisType = newChassisType.Text
                    .CarUse = newCarUse.Value
                    .DriverName1 = newDriverName1.Text
                    .DriverDOB1 = newDriverDOB1.Value
                    .DriverName2 = newDriverName2.Text
                    .DriverDOB2 = newDriverDOB2.Value


                    'รายละเอียดความคุ้มครอง
                    .Suminsured = CInt(newSuminsured.Value)
                    .Premium = newPremium.Value
                    .Vat = newVat.Value
                    .Stamp = newStamp.Value
                    .GrossPremium = newGrossPremium.Value

                    .BRCommAmt = newBRCommAmt.Value
                    .PRCommAmt = newPRCommAmt.Value
                    .SubCommAmt = newSubCommAmt.Value

                    .SentPolicyDate = newSentPolicyDate.Value
                    .GetPolicyDate = newGetPolicyDate.Value
                    '.SubGetPolicyDate = newSubGetPolicyDate.Value
                    .SendPolicy2CustomerDate = newSendPolicy2CustomerDate.Value
                    .CustomerGetPolicyDate = newCustomerGetPolicyDate.Value


                    .CreateDate = DateTime.Now
                    .CreateBy = HttpContext.Current.User.Identity.Name
                    '.Status = newStatus.value


                    .Status = "1"


                    'Dim brokerage = (From c In dc.tblBrokerages Where c.InsurerCode.Equals(.InsurerCode) And c.InsureType.Equals(.InsureType)).FirstOrDefault()
                    'If brokerage IsNot Nothing Then
                    '    .BRCommP = brokerage.BRCommP
                    '    .PRCommP = brokerage.PRCommP
                    'End If

                    'Dim subcomm = (From c In dc.tblSubComms Where c.AgentCode.Equals(.AgentCode) And c.InsureType.Equals(.InsureType)).FirstOrDefault()
                    'If subcomm IsNot Nothing Then
                    '    .SubCommP = subcomm.SubCommP
                    '    .SubCommID = subcomm.SubCommID
                    'End If

                End With


                dc.tblPolicyRegisters.InsertOnSubmit(newData)
                dc.SubmitChanges()



            End Using
        Catch ex As Exception
            TaskNewPopup.JSProperties("cpnewtask") = "error - " & ex.Message
        End Try


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
                Case "calvatstamp"
                    calvatstamp2()
                Case "clientselect"
                    clientselect2()
                Case "saveedit"
                    update(hdID("ID"))
            End Select


        End If





    End Sub

    Private Sub edit(ByVal _ID As String)
        Using dc As New DataClasses_GoodWorldExt()
            Dim data = (From c In dc.tblPolicyRegisters Where c.ID.Equals(_ID)).FirstOrDefault()

            BootstrapFormEdit1.DataSource = data
            BootstrapFormEdit1.DataBind()
            BootstrapFormEdit2.DataSource = data
            BootstrapFormEdit2.DataBind()
            BootstrapFormEdit3.DataSource = data
            BootstrapFormEdit3.DataBind()
            BootstrapFormEdit4.DataSource = data
            BootstrapFormEdit4.DataBind()
            BootstrapFormEdit5.DataSource = data
            BootstrapFormEdit5.DataBind()

            'editAddress1.Value = data.Address1
            'editAddress2.Value = data.Address2

            'editTelNo.Value = data.TelNo
            'editMobile.Value = data.Mobile

            editCreateBy.Value = String.Format("{0} {1}", data.CreateBy, data.CreateDate)
            editModifyBy.Value = String.Format("{0} {1}", data.ModifyBy, data.ModifyDate)

        End Using
    End Sub
    Private Sub calpremium2()
        Using dc As New DataClasses_GoodWorldExt()
            Dim _insurercode = editInsurerCode.Value
            Dim _InsureType = IIf(editInsureType.Value IsNot Nothing, editInsureType.Value, 0)

            Dim _Premium = IIf(editPremium.Value IsNot Nothing, editPremium.Value, 0)
            Dim _Stamp = Math.Ceiling((Convert.ToDouble(_Premium) * 0.004))
            Dim _Vat = (_Stamp + Convert.ToDouble(_Premium)) * 0.07
            Dim _GrossPremium = _Premium + _Stamp + _Vat

            Dim _BRCommP = 0.0

            Dim _BRCommAmt = 0.0

            Dim data = (From c In dc.tblInsureTypes Where c.ID.Equals(_InsureType)).FirstOrDefault()

            If data IsNot Nothing Then
                _BRCommP = data.Commission
                _BRCommAmt = _Premium * _BRCommP / 100
            End If

            editStamp.Value = _Stamp
            editVat.Value = _Vat
            editGrossPremium.Value = _GrossPremium
            editBRCommAmt.Value = _BRCommAmt

        End Using
    End Sub
    Private Sub calvatstamp2()
        Dim _Premium = IIf(editPremium.Value IsNot Nothing, editPremium.Value, 0)
        Dim _Stamp = IIf(editStamp.Value IsNot Nothing, editStamp.Value, 0)
        Dim _Vat = IIf(editVat.Value IsNot Nothing, editVat.Value, 0)
        Dim _GrossPremium = _Premium + _Stamp + _Vat
        editGrossPremium.Value = _GrossPremium
    End Sub
    Private Sub update(ByVal _ID As String)
        Try
            Using dc As New DataClasses_GoodWorldExt()

                If Not String.IsNullOrEmpty(editPolicyNo.Value) Then
                    Dim chkDuppolicy = (From c In dc.tblPolicyRegisters Where c.PolicyNo.Equals(editPolicyNo.Value) And c.ID <> (_ID)).FirstOrDefault()
                    If chkDuppolicy IsNot Nothing Then
                        Throw New Exception(String.Format("หมายเลขกรมธรรม์ {0} นี้มีในระบบแล้ว", editPolicyNo.Value))
                    End If
                End If


                Dim data = (From c In dc.tblPolicyRegisters Where c.ID.Equals(_ID)).FirstOrDefault()

                With data
                    '.InsurerCode = editInsurerCode.Value
                    '.AgentCode = editAgentCode.Value
                    '.FirstName = editFirstName.Value
                    '.LastName = editLastName.Value
                    ''.IdentityNo = editIdentityNo.Value
                    '.TelNo = editTelNo.Value
                    '.Mobile = editMobile.Value
                    '.Address1 = editAddress1.Value
                    '.Address2 = editAddress2.Value
                    '.InsureType = CInt(editInsureType.Value)
                    '.PolicyNo = editPolicyNo.Value
                    '.PolicyType = editPolicyType.Value
                    '.EffectiveDate = editEffectiveDate.Value
                    '.ExpiredDate = editExpiredDate.Value
                    '.Suminsured = CInt(editSuminsured.Value)
                    '.Premium = editPremium.Value
                    '.Vat = editVat.Value
                    '.Stamp = editStamp.Value
                    '.GrossPremium = editGrossPremium.Value

                    '.BRCommAmt = editBRCommAmt.Value
                    '.PRCommAmt = editPRCommAmt.Value
                    '.SubCommAmt = editSubCommAmt.Value

                    '.SentPolicyDate = editSentPolicyDate.Value
                    '.GetPolicyDate = editGetPolicyDate.Value
                    ''.SubGetPolicyDate = editSubGetPolicyDate.Value
                    '.ModifyDate = DateTime.Now
                    '.ModifyBy = HttpContext.Current.User.Identity.Name
                    ''.Status = newStatus.value
                    ''.DOB = editDOB.Value
                    '.CarLicensePlate = editCarLicensePlate.Value
                    '.CarRegYear = editCarRegYear.Value

                    ''Dim brokerage = (From c In dc.tblBrokerages Where c.InsurerCode.Equals(.InsurerCode) And c.InsureType.Equals(.InsureType)).FirstOrDefault()
                    ''If brokerage IsNot Nothing Then
                    ''    .BRCommP = brokerage.BRCommP
                    ''    .PRCommP = brokerage.PRCommP
                    ''End If

                    ''Dim subcomm = (From c In dc.tblSubComms Where c.AgentCode.Equals(.AgentCode) And c.InsureType.Equals(.InsureType)).FirstOrDefault()
                    ''If subcomm IsNot Nothing Then
                    ''    .SubCommP = subcomm.SubCommP
                    ''    .SubCommID = subcomm.SubCommID
                    ''End If


                    'บริษัทประกัน/ตัวแทน
                    .InsurerCode = editInsurerCode.Value
                    .AgentCode = editAgentCode.Value
                    'ผู้เอาประกัน
                    .CustomerType = editCustomerType.Value
                    '.FirstName = editFirstName.Value
                    '.LastName = editLastName.Value
                    .ClientName = editClientName.Text
                    .Address1 = editAddress1.Value
                    .Address2 = editAddress2.Value
                    .DOB = editDOB.Value
                    .IdentityNo = editIdentityNo.Value
                    .TelNo = editTelNo.Value
                    .Mobile = editMobile.Value
                    .Fax = editFax.Text
                    .Email = editEmail.Text
                    .SocialMediaNo = editSocialMediaNo.Text
                    .BenefitName = editBenefitName.Text

                    'รายละเอียดกรมธรรม์
                    .PolicyType = editPolicyType.Value
                    .NewRenew = editNewRenew.Value
                    .RenewPolicyYear = CInt(editRenewPolicyYear.Value)
                    .PolicyNo = editPolicyNo.Value
                    .EffectiveDate = editEffectiveDate.Value
                    .ExpiredDate = editExpiredDate.Value
                    .InsureType = CInt(editInsureType.Value)


                    'รายละเอียดรถคันที่เอาประกันภัย
                    .CarType = CInt(editCarType.Value)
                    .CarBrandModel = CInt(editCarBrandModel.Value)
                    .CarRegYear = editCarRegYear.Value
                    .CarLicensePlate = editCarLicensePlate.Value
                    .Engine = editEngine.Text
                    .Chassis = editChassis.Text
                    .CarSize = editCarSize.Text
                    .ChassisType = editChassisType.Text
                    .CarUse = editCarUse.Value
                    .DriverName1 = editDriverName1.Text
                    .DriverDOB1 = editDriverDOB1.Value
                    .DriverName2 = editDriverName2.Text
                    .DriverDOB2 = editDriverDOB2.Value


                    'รายละเอียดความคุ้มครอง
                    .Suminsured = CInt(editSuminsured.Value)
                    .Premium = editPremium.Value
                    .Vat = editVat.Value
                    .Stamp = editStamp.Value
                    .GrossPremium = editGrossPremium.Value

                    .BRCommAmt = editBRCommAmt.Value
                    .PRCommAmt = editPRCommAmt.Value
                    .SubCommAmt = editSubCommAmt.Value

                    .SentPolicyDate = editSentPolicyDate.Value
                    .GetPolicyDate = editGetPolicyDate.Value
                    '.SubGetPolicyDate = newSubGetPolicyDate.Value
                    .SendPolicy2CustomerDate = editSendPolicy2CustomerDate.Value
                    .CustomerGetPolicyDate = editCustomerGetPolicyDate.Value
                    .Status = editStatus.Value
                    .Remark = editRemark.Value
                    .ModifyDate = DateTime.Now
                    .ModifyBy = HttpContext.Current.User.Identity.Name
                End With


                dc.SubmitChanges()


                TaskEditPopup.JSProperties("cpedittask") = "saveedit"
            End Using
        Catch ex As Exception
            TaskEditPopup.JSProperties("cpedittask") = "error - " & ex.Message
        End Try

    End Sub


    Private Sub clientselect2()
        Using dc As New DataClasses_GoodWorldExt()
            Dim _data = (From c In dc.tblPolicyRegisters Where c.ClientName.Equals(editClientName.Value) Order By c.EffectiveDate Descending).FirstOrDefault()

            If _data IsNot Nothing Then
                editAddress1.Value = _data.Address1
                editAddress2.Value = _data.Address2
                editDOB.Value = _data.DOB
                editIdentityNo.Value = _data.IdentityNo
                editTelNo.Value = _data.TelNo
                editMobile.Value = _data.Mobile
                editFax.Text = _data.Fax
                editEmail.Text = _data.Email
                editSocialMediaNo.Text = _data.SocialMediaNo
                editBenefitName.Text = _data.BenefitName
            End If


        End Using
    End Sub



    Protected Sub TaskGrid_HtmlRowCreated(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridViewTableRowEventArgs) Handles TaskGrid.HtmlRowPrepared


        If e.RowType <> DevExpress.Web.GridViewRowType.Data Then
            Return
        End If

        Dim EditButton As BootstrapButton = TaskGrid.FindRowCellTemplateControl(e.VisibleIndex, Nothing, "EditButton")
        EditButton.JSProperties.Add("cpID", e.KeyValue().ToString())



    End Sub


    Protected Sub TaskGrid_ToolbarItemClick(ByVal sender As Object, ByVal e As BootstrapGridViewToolbarItemClickEventArgs) Handles TaskGrid.ToolbarItemClick

        Select Case e.Item.Name
            Case "ExportToXLS"
                TaskGrid.ExportXlsToResponse(New XlsExportOptionsEx With {.ExportType = ExportType.WYSIWYG})
            Case "ExportToXLSX"
                TaskGrid.ExportXlsxToResponse(New XlsxExportOptionsEx With {.ExportType = ExportType.WYSIWYG})
        End Select
    End Sub


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


    'Protected Sub ASPxComboBox_OnItemRequestedByValue_SQL(ByVal source As Object, ByVal e As ListEditItemRequestedByValueEventArgs)
    '    Dim value As Long = 0
    '    If e.Value Is Nothing Then
    '        Return
    '    End If
    '    Dim comboBox As ASPxComboBox = CType(source, ASPxComboBox)
    '    SqlDataSource1.SelectCommand = "select ClientName from tblPolicyRegister where ClientName like @ClientName Group By ClientName Order By ClientName"

    '    SqlDataSource1.SelectParameters.Clear()
    '    SqlDataSource1.SelectParameters.Add("ClientName", TypeCode.String, e.Value.ToString())
    '    comboBox.DataSource = SqlDataSource1
    '    comboBox.DataBind()
    'End Sub

    'Protected Sub ASPxComboBox_OnItemsRequestedByFilterCondition_SQL(ByVal source As Object, ByVal e As ListEditItemsRequestedByFilterConditionEventArgs)
    '    Dim comboBox As ASPxComboBox = CType(source, ASPxComboBox)

    '    Dim sb As New StringBuilder()
    '    sb.Append(" SELECT ClientName")
    '    sb.Append(" FROM (")
    '    sb.Append(" select ClientName")
    '    sb.Append(" , row_number()over(order by t.ClientName) as [rn] ")
    '    sb.Append(" from (select ClientName from tblPolicyRegister Group By ClientName) as t ")
    '    sb.Append(" where ClientName LIKE @filter")
    '    sb.Append(" ) as st ")
    '    sb.Append(" where st.[rn] between @startIndex and @endIndex")

    '    SqlDataSource1.SelectCommand = sb.ToString()

    '    SqlDataSource1.SelectParameters.Clear()
    '    SqlDataSource1.SelectParameters.Add("filter", TypeCode.String, String.Format("%{0}%", e.Filter))
    '    SqlDataSource1.SelectParameters.Add("startIndex", TypeCode.Int64, (e.BeginIndex + 1).ToString())
    '    SqlDataSource1.SelectParameters.Add("endIndex", TypeCode.Int64, (e.EndIndex + 1).ToString())
    '    comboBox.DataSource = SqlDataSource1
    '    comboBox.DataBind()
    'End Sub
End Class
