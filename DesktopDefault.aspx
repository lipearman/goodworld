<%@ Page Language="VB" AutoEventWireup="false" CodeFile="DesktopDefault.aspx.vb" Inherits="DesktopDefault" %>

<!DOCTYPE html>
<html id="Html1" xmlns="http://www.w3.org/1999/xhtml" runat="server">
<head id="Head1" runat="server">
    <title><%=SiteName %></title>
    <meta name="viewport"  content="width=device-width, user-scalable=no, maximum-scale=1.0, minimum-scale=1.0" />
 
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <link href="Content/site.css" rel="stylesheet" />
    <link href="Content/font-awesome.min.css" rel="stylesheet" />
    <script src="Scripts/jquery-1.9.1.min.js" type="text/javascript"></script>
    <script src="Scripts/bootstrap.min.js" type="text/javascript"></script>
    <script src="Scripts/site.js" type="text/javascript"></script>


<style type="text/css">
    .alink {
        color: white; cursor:pointer;
        text-decoration: none;
        background-color: transparent;
        -webkit-text-decoration-skip: objects;
    }
    .saveBt {
        margin-right: 10px;
    }

    .removeWrapping {
        white-space: nowrap;
    }
</style>

   <%-- 
    <style>
        .main-content {
            float: left;
            padding: 0 15px;
            width: calc(100%);
        }
        .navbar-collapse .main-menu
        {
            float: right;
            font-size: 15.5px;
        }

        .dropdown-toggle
        {
            font-size: 15.5px;
        }

        .dropdown-menu
        {
            font-size: 15.5px;
        }

        .main-toolbar-container
        {
            padding: 0px 0;
        }
    </style>--%>
</head>
<body>
    <form id="form1" runat="server">
        <dx:ASPxLoadingPanel ID="LoadingPanel" runat="server" ClientInstanceName="LoadingPanel" Modal="True"></dx:ASPxLoadingPanel>

        <dx:ASPxCallback ID="cbLoginOut" runat="server" ClientInstanceName="cbLoginOut">
        </dx:ASPxCallback>

        <nav class="navbar-inverse navbar-fixed-top" role="navigation">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".main-menu-container">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <table>
                    <tr>
                        <td style="color:white"><a id="A1" runat="server" href="#">
                            <img src="Content/Images/logo.png" height="64" title="<%=SiteName %>" />
                        </a></td>


                        <td style="vertical-align: bottom;color:white">

                            <div>
                                Welcome, <%=HttpContext.Current.User.Identity.Name%> :  
                        <dx:BootstrapHyperLink ID="BootstrapHyperLink1"  CssClasses-Control="alink"  runat="server" AutoPostBack="false" Text="[Logout]">
                            <ClientSideEvents Click="function(s,e){

                                 LoadingPanel.Show();
                                 cbLoginOut.PerformCallback();
                                 e.processOnServer = false;
                                }" />
                        </dx:BootstrapHyperLink>

                            </div>
                        </td>
                    </tr>
                </table>


            </div>
            <div class="collapse navbar-collapse main-menu-container">
                <dx:BootstrapMenu ID="MainMenu" runat="server" ShowPopOutImages="true"
                    Orientation="Horizontal"
                    SyncSelectionMode="CurrentPath"
                    EnableViewState="false">
                    <CssClasses Control="main-menu"></CssClasses>
                    <SettingsBootstrap NavbarMode="true"></SettingsBootstrap>
                </dx:BootstrapMenu>

            </div>
        </nav>
        <div class="main-content-container">

            <div class="main-content">
                <div class="main-toolbar-container">
                    <div>
                     <%--   Welcome, <%=HttpContext.Current.User.Identity.Name%> :  
                        <dx:BootstrapHyperLink ID="btnLogout" runat="server" AutoPostBack="false" Text="[Logout]">
                            <ClientSideEvents Click="function(s,e){

                                 LoadingPanel.Show();
                                 cbLoginOut.PerformCallback();
                                 e.processOnServer = false;
                                }" />
                        </dx:BootstrapHyperLink>--%>
                        Navigate : <%=parenttabname %>
                    </div>
                </div> 
                <dx:BootstrapCallbackPanel ID="MainCallbackPanel" runat="server" ClientInstanceName="mainCallbackPanel">
                    <ContentCollection>
                        <dx:ContentControl>
                            
                            <div runat="server" id="container"></div>

                           
                        </dx:ContentControl>
                    </ContentCollection>
                </dx:BootstrapCallbackPanel>  
            </div>
            <div class="clearfix"></div>
        </div>


        <div class="footer">
            <center>
            <div>
                <span>Copyright © <%=Now.Year%> <%=SiteName %></span>
            </div>

            </center>
        </div>
    </form>
</body>
</html>
