<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Test.aspx.vb" Inherits="Test" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <link href="Content/site.css" rel="stylesheet" />
    <link href="Content/font-awesome.min.css" rel="stylesheet" />
    <script src="Scripts/jquery-1.9.1.min.js" type="text/javascript"></script>
    <script src="Scripts/bootstrap.min.js" type="text/javascript"></script>
    <script src="Scripts/site.js" type="text/javascript"></script>


</head>
<body>
    <form id="form1" runat="server">
        <div>


            <dx:BootstrapComboBox runat="server" ID="newClientName"
                DropDownStyle="DropDown"
                TextField="ClientName"
                ValueField="ClientName" ValueType="System.String"
                SelectedIndex="0"
                OnItemRequestedByValue="newClientName_ItemRequestedByValue"
                OnItemsRequestedByFilterCondition="newClientName_ItemsRequestedByFilterCondition"
                CallbackPageSize="25"
                ForceDataBinding="true"
                EnableCallbackMode="true">
  
            </dx:BootstrapComboBox>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>" />

        </div>
    </form>
</body>
</html>
