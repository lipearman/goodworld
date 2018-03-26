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
            Case "calbrokerage"
                calbrokerage()
            Case "savenew"
                savenew()
        End Select



    End Sub






    Private Sub calbrokerage()
        'Using dc As New DataClasses_GoodWorldExt()
        '    Dim _insurercode = newInsurerCode.Value
        '    Dim _InsureType = IIf(newInsureType.Value IsNot Nothing, newInsureType.Value, 0)

        '    Dim _Premium = IIf(newPremium.Value IsNot Nothing, newPremium.Value, 0)
        '    Dim _Stamp = Math.Ceiling((Convert.ToDouble(_Premium) * 0.004))
        '    Dim _Vat = (_Stamp + Convert.ToDouble(_Premium)) * 0.07
        '    Dim _GrossPremium = _Premium + _Stamp + _Vat


        '    ''--Set @PolicyPremium = Floor(Convert(float,@PolicyTotalPremium) / 1.07428)
        '    ''--Set @PolicyStamp = Round((@PolicyPremium * 0.004),0)
        '    ''--Set @PolicyVat = (@PolicyPremium + @PolicyStamp) * 0.07
        '    'Dim _GrossPremium = IIf(newGrossPremium.Value IsNot Nothing, newGrossPremium.Value, 0)
        '    'Dim _Premium = Math.Floor((_GrossPremium) / 1.07428)
        '    'Dim _Stamp = Math.Ceiling(_Premium * 0.004)
        '    'Dim _Vat = (_Premium + _Stamp) * 0.07

        '    Dim _newBRCommP = 0.0
        '    Dim _newPRCommP = 0.0

        '    Dim _newBRCommAmt = 0.0
        '    Dim _newPRCommAmt = 0.0

        '    Dim data = (From c In dc.tblBrokerages Where c.InsurerCode.Equals(_insurercode) And c.InsureType.Equals(_InsureType)).FirstOrDefault()

        '    If data IsNot Nothing Then
        '        _newBRCommP = data.BRCommP
        '        _newPRCommP = data.PRCommP

        '        _newBRCommAmt = _Premium * _newBRCommP / 100
        '        _newPRCommAmt = _Premium * _newPRCommP / 100
        '    End If

        '    'newPremium.Value = _Premium
        '    newStamp.Value = _Stamp
        '    newVat.Value = _Vat
        '    newGrossPremium.Value = _GrossPremium

        '    newBRCommAmt.Value = _newBRCommAmt
        '    newPRCommAmt.Value = _newPRCommAmt

        '    Dim SubCommAmt = 0.0
        '    Dim _AgentCode = IIf(newAgentCode.Value IsNot Nothing, newAgentCode.Value, "")
        '    Dim subcomm = (From c In dc.tblSubComms Where c.AgentCode.Equals(_AgentCode) And c.InsureType.Equals(_InsureType)).FirstOrDefault()
        '    If subcomm IsNot Nothing Then

        '        SubCommAmt = _Premium * subcomm.SubCommP / 100
        '    End If

        '    newSubCommAmt.Value = SubCommAmt

        'End Using
    End Sub

    Private Sub savenew()
        Try
            Using dc As New DataClasses_GoodWorldExt()

                Dim newData As New tblPolicyRegister
                With newData
                    'บริษัทประกัน/ตัวแทน
                    .InsurerCode = newInsurerCode.Value
                    .AgentCode = newAgentCode.Value
                    'ผู้เอาประกัน
                    .CustomerType = newCustomerType.Value
                    .FirstName = newFirstName.Value
                    .LastName = newLastName.Value
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
            TaskNewPopup.JSProperties("cpnewtask") = ex.Message
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
                Case "calbrokerage"
                    calbrokerage2()
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
    Private Sub calbrokerage2()
        'Using dc As New DataClasses_GoodWorldExt()
        '    Dim _insurercode = editInsurerCode.Value
        '    Dim _InsureType = IIf(editInsureType.Value IsNot Nothing, editInsureType.Value, 0)

        '    Dim _Premium = IIf(editPremium.Value IsNot Nothing, editPremium.Value, 0)
        '    Dim _Stamp = Math.Ceiling((Convert.ToDouble(_Premium) * 0.004))
        '    Dim _Vat = (_Stamp + Convert.ToDouble(_Premium)) * 0.07
        '    Dim _GrossPremium = _Premium + _Stamp + _Vat


        '    ''--Set @PolicyPremium = Floor(Convert(float,@PolicyTotalPremium) / 1.07428)
        '    ''--Set @PolicyStamp = Round((@PolicyPremium * 0.004),0)
        '    ''--Set @PolicyVat = (@PolicyPremium + @PolicyStamp) * 0.07
        '    'Dim _GrossPremium = IIf(newGrossPremium.Value IsNot Nothing, newGrossPremium.Value, 0)
        '    'Dim _Premium = Math.Floor((_GrossPremium) / 1.07428)
        '    'Dim _Stamp = Math.Ceiling(_Premium * 0.004)
        '    'Dim _Vat = (_Premium + _Stamp) * 0.07

        '    Dim _BRCommP = 0.0
        '    Dim _PRCommP = 0.0

        '    Dim _BRCommAmt = 0.0
        '    Dim _PRCommAmt = 0.0

        '    Dim data = (From c In dc.tblBrokerages Where c.InsurerCode.Equals(_insurercode) And c.InsureType.Equals(_InsureType)).FirstOrDefault()

        '    If data IsNot Nothing Then
        '        _BRCommP = data.BRCommP
        '        _PRCommP = data.PRCommP

        '        _BRCommAmt = _Premium * _BRCommP / 100
        '        _PRCommAmt = _Premium * _PRCommP / 100
        '    End If

        '    'newPremium.Value = _Premium
        '    editStamp.Value = _Stamp
        '    editVat.Value = _Vat
        '    editGrossPremium.Value = _GrossPremium

        '    editBRCommAmt.Value = _BRCommAmt
        '    editPRCommAmt.Value = _PRCommAmt

        '    Dim SubCommAmt = 0.0
        '    Dim _AgentCode = IIf(editAgentCode.Value IsNot Nothing, editAgentCode.Value, "")
        '    Dim subcomm = (From c In dc.tblSubComms Where c.AgentCode.Equals(_AgentCode) And c.InsureType.Equals(_InsureType)).FirstOrDefault()
        '    If subcomm IsNot Nothing Then

        '        SubCommAmt = _Premium * subcomm.SubCommP / 100
        '    End If

        '    editSubCommAmt.Value = SubCommAmt

        'End Using
    End Sub
    Private Sub update(ByVal _ID As String)
        Try
            Using dc As New DataClasses_GoodWorldExt()

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
                    .FirstName = editFirstName.Value
                    .LastName = editLastName.Value
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
            TaskEditPopup.JSProperties("cpedittask") = ex.Message
        End Try

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


End Class
