<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ucUWBillingPayment.ascx.vb" Inherits="Modules_ucUWBillingPayment" %>
<style>
    legend {
        display: block;
        width: 100%;
        padding: 0;
        margin-bottom: 23px;
        font-size: 14px;
        line-height: inherit;
        color: #212121;
        border: 0;
        border-bottom: 1px solid #e5e5e5;
    }

    .text-primary {
        color: #2196f3;
        font-size: 14px;
    }
</style>
<style>
    .saveBt {
        margin-right: 10px;
    }
</style>

<fieldset>
    <legend class="text-primary"><%=PageName %></legend>
</fieldset>
<table>
    <tr>
        <td>

          <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"></asp:SqlDataSource>

            <dx:ASPxComboBox ID="PolicyNoFilter" ClientInstanceName="PolicyNoFilter"
                runat="server" Caption="ค้นหาเลขกรมธรรม์"
                EnableCallbackMode="true"
                CallbackPageSize="10"
                ValueType="System.String"
                ValueField="PolicyID"
                TextFormatString="{0}"
                Width="250px"
                DropDownStyle="DropDown">

                <Columns>





                    <dx:ListBoxColumn FieldName="PolicyNo" Caption="เลขกรมธรรม์" Width="200" />
                    <dx:ListBoxColumn FieldName="ClientName" Caption="ชื่อผู้เอาประกันภัย" Width="150" />
                    <dx:ListBoxColumn FieldName="EffectiveDate" Caption="วันเริ่มคุ้มครอง" Width="100">
                        <CellTemplate>
                            <%# Eval("EffectiveDate", "{0:dd/MM/yyyy}") %>
                        </CellTemplate>
                    </dx:ListBoxColumn>
                    <dx:ListBoxColumn FieldName="CarLicensePlate" Caption="ทะเบียนรถ" Width="100" />

                    
                    <dx:ListBoxColumn FieldName="Premium" Caption="เบี้ยสุทธิ" Width="100">
                        <CellTemplate>
                            <%# Eval("Suminsured", "{0:N2}") %>
                        </CellTemplate>
                    </dx:ListBoxColumn>
                    <dx:ListBoxColumn FieldName="GrossPremium" Caption="เบี้ยรวม" Width="100">
                        <CellTemplate>
                            <%# Eval("GrossPremium", "{0:N2}") %>
                        </CellTemplate>
                    </dx:ListBoxColumn>
            <dx:ListBoxColumn FieldName="BRCommP" Caption="%" Width="100">
                        <CellTemplate>
                            <%# Eval("BRCommP", "{0:N2}") %>
                        </CellTemplate>
                    </dx:ListBoxColumn>                    
   <dx:ListBoxColumn FieldName="BRCommAmt" Caption="ค่าคอม" Width="100">
                        <CellTemplate>
                            <%# Eval("BRCommAmt", "{0:N2}") %>
                        </CellTemplate>
                    </dx:ListBoxColumn>    
  <dx:ListBoxColumn FieldName="VAT7Amt" Caption="Vat(7%)" Width="100">
                        <CellTemplate>
                            <%# Eval("VAT7Amt", "{0:N2}") %>
                        </CellTemplate>
                    </dx:ListBoxColumn> 
    <dx:ListBoxColumn FieldName="TAX3Amt" Caption="Vat(3%)" Width="100">
                        <CellTemplate>
                            <%# Eval("TAX3Amt", "{0:N2}") %>
                        </CellTemplate>
                    </dx:ListBoxColumn>                   
  <dx:ListBoxColumn FieldName="ServiceFreeP" Caption="%" Width="100">
                        <CellTemplate>
                            <%# Eval("ServiceFreeP", "{0:N2}") %>
                        </CellTemplate>
                    </dx:ListBoxColumn>  
  <dx:ListBoxColumn FieldName="ServiceFreeAmt" Caption="ค่าจัดการ" Width="100">
                        <CellTemplate>
                            <%# Eval("ServiceFreeAmt", "{0:N2}") %>
                        </CellTemplate>
                    </dx:ListBoxColumn>                      
  <dx:ListBoxColumn FieldName="ServiceFreeVAT7Amt" Caption="Vat 7%" Width="100">
                        <CellTemplate>
                            <%# Eval("ServiceFreeVAT7Amt", "{0:N2}") %>
                        </CellTemplate>
                    </dx:ListBoxColumn>   
  <dx:ListBoxColumn FieldName="ServiceFreeTAX3Amt" Caption="Vat 3%" Width="100">
                        <CellTemplate>
                            <%# Eval("ServiceFreeTAX3Amt", "{0:N2}") %>
                        </CellTemplate>
                    </dx:ListBoxColumn>   
   <dx:ListBoxColumn FieldName="PaymentDate" Caption="Vat 3%" Width="100">
                        <CellTemplate>
                            <%# Eval("PaymentDate", "{0:N2}") %>
                        </CellTemplate>
                    </dx:ListBoxColumn>   

                </Columns>

            </dx:ASPxComboBox>
        </td>
        <td>&nbsp;
        </td>
        <td>


            <dx:BootstrapDateEdit runat="server" ID="PaymentDate" Caption="วันที่จ่าย" ClientInstanceName="PaymentDate"></dx:BootstrapDateEdit>


        </td>
        <td>&nbsp;
        </td>
        <td>

            <dx:ASPxButton ID="AddPolicyNo" AutoPostBack="false"
                runat="server" Border-BorderWidth="0" CausesValidation="false"
                Image-IconID="actions_download_16x16office2013"
                Text="Add">
                <ClientSideEvents Click="function(s,e){
                                                    var code = PolicyNoFilter.GetValue();
                                                    var pdate = PaymentDate.GetValue();
                                                    if(code==null || pdate==null)
                                                    {
                                                        alert('กรุณาเลือก เลขกรมธรรม์ และวันที่จ่าย');
                                                        e.processOnServer = false;
                                                    }
                                                    else
                                                    {
                                                        e.processOnServer = true;
                                                    }
                                                
                                                }" />

            </dx:ASPxButton>

        </td>
    </tr>
</table>
<br />


<dx:BootstrapGridView ID="TaskGrid" runat="server"
    ClientInstanceName="taskGrid"
    AutoGenerateColumns="False" CssClasses-HeaderRow="removeWrapping" CssClasses-Row="removeWrapping"
    KeyFieldName="ID" SettingsBehavior-ConfirmDelete="true"
    SettingsBehavior-AllowDragDrop="true"
    SettingsPopup-EditForm-AllowResize="true"
    DataSourceID="SqlDataSource_BillingDetails"
    Width="100%"
    PopupAnimationType="Fade" CloseOnEscape="true" CloseAction="None">

    <SettingsEditing Mode="PopupEditForm" EditFormColumnSpan="12">
        <FormLayoutProperties LayoutType="Horizontal"></FormLayoutProperties>
    </SettingsEditing>
    <SettingsBehavior AllowFocusedRow="true" />
    <SettingsDataSecurity AllowEdit="true" AllowInsert="true" AllowDelete="true" />
    <SettingsPager AlwaysShowPager="true" ShowEmptyDataRows="false" PageSize="5">
        <PageSizeItemSettings Visible="true" Items="5,8,12,20" />
    </SettingsPager>
    <SettingsCustomizationDialog Enabled="true" />
    <SettingsCommandButton>
        <EditButton CssClass="edit-btn" RenderMode="Button" Text=" " />
        <UpdateButton RenderMode="Button" Text="Save" CssClass="saveBt" />
        <CancelButton RenderMode="Button" />
    </SettingsCommandButton>

    <SettingsAdaptivity AdaptivityMode="HideDataCells" AllowOnlyOneAdaptiveDetailExpanded="true" />
    <SettingsSearchPanel Visible="true" />

    <CssClasses Control="tasks-grid" PreviewRow="text-muted" />
    <ClientSideEvents ToolbarItemClick="function(s,e){
                switch (e.item.name) {

                case 'ExportToXLSX':
                case 'ExportToXLS':
                    e.processOnServer = true;
                    e.usePostBack = true;
                    break;

         
            } 
        }" />




    <Toolbars>
        <dx:BootstrapGridViewToolbar>
            <Items>

                <dx:BootstrapGridViewToolbarItem Command="Refresh" BeginGroup="true" />
                <dx:BootstrapGridViewToolbarItem Command="Delete" BeginGroup="true" />
                <dx:BootstrapGridViewToolbarItem Command="ClearSorting" BeginGroup="true" />
                <dx:BootstrapGridViewToolbarItem Command="ShowSearchPanel" BeginGroup="true" />


                <dx:BootstrapGridViewToolbarItem Command="Custom" Text="Export To" BeginGroup="true">
                    <Items>
                        <dx:BootstrapGridViewToolbarMenuItem Name="ExportToXLSX" Text="XLSX" />
                        <dx:BootstrapGridViewToolbarMenuItem Name="ExportToXLS" Text="XLS" />
                    </Items>
                </dx:BootstrapGridViewToolbarItem>

                <dx:BootstrapGridViewToolbarItem Command="ShowCustomizationDialog" BeginGroup="true">
                </dx:BootstrapGridViewToolbarItem>


            </Items>
        </dx:BootstrapGridViewToolbar>
    </Toolbars>
    <Columns>

<%--PolicyNo		ระบุเบอร์กรมธรรม์
AgentName		ระบุ Agent Code
ClientName		ชื่อผู้เอาประกันภัย
EffectiveDate		วันเริ่มคุ้มครอง
CarLicensePlate		เลขทะเบียนรถ

Premium		เบี้ยสุทธิ
GrossPremium		เบี้ยรวม
Commission		% คอม
CommissionAmount		ค่าคอม
BillingAmount		จ่ายเบี้ยสุทธิ--%>



<%--<dx:BootstrapGridViewCommandColumn ShowEditButton="true" Width="50"></dx:BootstrapGridViewCommandColumn>--%>

<dx:BootstrapGridViewTextColumn FieldName="ClientName" Width="300" ReadOnly="true" Caption="ชื่อผู้เอาประกันภัย" Settings-AllowFilterBySearchPanel="True"></dx:BootstrapGridViewTextColumn>
<dx:BootstrapGridViewTextColumn FieldName="CarLicensePlate" Width="100" ReadOnly="true" Caption="ทะเบียนรถ" Settings-AllowFilterBySearchPanel="True"></dx:BootstrapGridViewTextColumn>
<dx:BootstrapGridViewTextColumn FieldName="PolicyNo" Width="100" ReadOnly="true" Caption="เลขกรมธรรม์" Settings-AllowFilterBySearchPanel="True"></dx:BootstrapGridViewTextColumn>
<dx:BootstrapGridViewDateColumn FieldName="EffectiveDate" ReadOnly="true" Caption="วันเริ่มคุ้มครอง" Width="100" PropertiesDateEdit-DisplayFormatString="dd/MM/yyyy" />
<dx:BootstrapGridViewTextColumn FieldName="InsurerName" ReadOnly="true"  Caption="บริษัทประกันภัย" Width="100" />
<dx:BootstrapGridViewSpinEditColumn FieldName="Premium" ReadOnly="true" Width="100" AdaptivePriority="2" Caption="เบี้ยสุทธิ" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>
<dx:BootstrapGridViewSpinEditColumn FieldName="GrossPremium" ReadOnly="true" Width="100" AdaptivePriority="2" Caption="เบี้ยรวมภาษี" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>
<dx:BootstrapGridViewSpinEditColumn FieldName="BRCommP" ReadOnly="true" Width="100" AdaptivePriority="2" Caption="%" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>
<dx:BootstrapGridViewSpinEditColumn FieldName="BRCommAmt" ReadOnly="true" Width="100" AdaptivePriority="2" Caption="ค่าคอม" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>
<dx:BootstrapGridViewSpinEditColumn FieldName="VAT7Amt" ReadOnly="true"  Width="100" AdaptivePriority="2" Caption="Vat(7%)" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>
<dx:BootstrapGridViewSpinEditColumn FieldName="TAX3Amt" ReadOnly="true" Width="100" AdaptivePriority="2" Caption="Tax(3%)" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>
<dx:BootstrapGridViewSpinEditColumn FieldName="ServiceFreeP" ReadOnly="true" Width="100" AdaptivePriority="2" Caption="%" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>
<dx:BootstrapGridViewSpinEditColumn FieldName="ServiceFreeAmt" ReadOnly="true" Width="100" AdaptivePriority="2" Caption="ค่าจัดการ" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>
<dx:BootstrapGridViewSpinEditColumn FieldName="ServiceFreeVAT7Amt" ReadOnly="true" Width="100" AdaptivePriority="2" Caption="Vat 7%" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>
<dx:BootstrapGridViewSpinEditColumn FieldName="ServiceFreeTAX3Amt" ReadOnly="true" Width="100" AdaptivePriority="2" Caption="Tax 3%" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>
<dx:BootstrapGridViewSpinEditColumn FieldName="TotalPremium" ReadOnly="true" Width="100" AdaptivePriority="2" Caption="เบี้ยรวม" PropertiesSpinEdit-NumberType="Float" PropertiesSpinEdit-DisplayFormatString="{0:N2}"></dx:BootstrapGridViewSpinEditColumn>

        

<dx:BootstrapGridViewDateColumn FieldName="PaymentDate" Caption="วันที่่บันทึก" PropertiesDateEdit-DisplayFormatString="dd/MM/yyyy" PropertiesDateEdit-ValidationSettings-RequiredField-IsRequired="true" />




        <dx:BootstrapGridViewDateColumn FieldName="CreateDate" Caption="วันที่่บันทึก"
            Visible="false"
            PropertiesDateEdit-DisplayFormatString="dd/MM/yyyy HH:mm:ss" SettingsEditForm-Visible="False" />
        <dx:BootstrapGridViewTextColumn FieldName="CreateBy" Caption="ผู้บันทึก" Visible="false">
            <SettingsEditForm Visible="False" />
        </dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="ModifyDate" Caption="วันที่แก้ไข" Visible="false">
            <SettingsEditForm Visible="False" />
        </dx:BootstrapGridViewTextColumn>
        <dx:BootstrapGridViewTextColumn FieldName="ModifyBy" Caption="ผู้แก้ไข" Visible="false">
            <SettingsEditForm Visible="False" />
        </dx:BootstrapGridViewTextColumn>




    </Columns>


</dx:BootstrapGridView>

<asp:SqlDataSource ID="SqlDataSource_BillingDetails" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
    SelectCommand="select * from v_UWBillingPayment Order By CreateDate desc"

     UpdateCommand="update tblUWBillingPayment
    set PaymentDate=@PaymentDate
    ,ModifyDate=getdate()
    ,ModifyBy=@UserName
    where ID=@ID
    "
    DeleteCommand="delete from tblUWBillingPayment where ID=@ID"
    >

    <UpdateParameters> 
        <asp:Parameter Name="PaymentDate" />
        
         <asp:Parameter Name="UserName" />
         <asp:Parameter Name="ID" />
    </UpdateParameters>
    <DeleteParameters>
         <asp:Parameter Name="ID" />
    </DeleteParameters>
</asp:SqlDataSource>










