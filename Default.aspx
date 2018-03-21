<%@ Page Language="vb" AutoEventWireup="true" CodeFile="Default.aspx.vb" Inherits="_Default" %>

<!DOCTYPE html>
<html id="Html1" xmlns="http://www.w3.org/1999/xhtml" runat="server">
<head id="Head1" runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, user-scalable=no, maximum-scale=1.0, minimum-scale=1.0" />
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <link href="Content/site.css" rel="stylesheet" />
    <link href="Content/font-awesome.min.css" rel="stylesheet" />

    <script src="Scripts/jquery-1.9.1.min.js" type="text/javascript"></script>
    <script src="Scripts/bootstrap.min.js" type="text/javascript"></script>
    <script src="Scripts/site.js" type="text/javascript"></script>
    <style>
        .panel-heading
        {
            padding: 5px 15px;
            font-size:19.5px;
        }

        .panel-footer
        {
            padding: 1px 15px;
            color: #A0A0A0;
        }

        .profile-img
        {
            width: 96px;
            height: 96px;
            margin: 0 auto 10px;
            display: block;
            -moz-border-radius: 50%;
            -webkit-border-radius: 50%;
            border-radius: 50%;
        }
    </style>
    <script>
        function signin() {
            
            var loginname = document.getElementById("loginname").value;
            var password = document.getElementById("password").value;


            if (loginname == '' || password == '') {
                return false;
            }
            else {
                cbSignIn.PerformCallback(loginname + '|' + password);
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server" onsubmit="javascript:signin();return false;">

<dx:ASPxLoadingPanel ID="LoadingPanel" runat="server" ClientInstanceName="LoadingPanel" Modal="True"></dx:ASPxLoadingPanel>

        <dx:ASPxCallback ID="cbSignIn" runat="server" ClientInstanceName="cbSignIn">
            <ClientSideEvents  BeginCallback="function(s,e){
                                                    LoadingPanel.Show();
                                                     msg.SetText('');
                                                    }"
                                CallbackComplete="function(s,e){
                                                        msg.SetText(e.result);
                                                    }"
                                EndCallback="function(s,e){
                                                        LoadingPanel.Hide();
                                                    }" 
                                 CallbackError="function(s,e){
                                 LoadingPanel.Hide();
                                }"
                
                />
        </dx:ASPxCallback>



        
        <nav class="navbar-inverse navbar-fixed-top" role="navigation">
            <div class="navbar-header">
                 <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".main-menu-container">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a id="A1" runat="server" href="#">
                    <img src="Content/Images/logo.png"  height="64" title="Good World" />
                </a>
<%--                <div style="color:white" >
                     Computer Hardware and Networking 
                </div>--%>
            </div>
            <div class="collapse navbar-collapse main-menu-container">
            </div>
        </nav>
        <div class="main-content-container">
            <div class="clearfix"></div>


            <div class="container" style="margin-top: 40px">
                <div class="row">
                    <div class="col-sm-6 col-md-4 col-md-offset-4">
                        <div class="panel panel-default">
                           <%-- <div class="panel-heading">
                                 <i class="glyphicon glyphicon-globe"></i>
                               Sign in to continue 
                                  
                            </div>--%>
                            
                            <legend class="panel-heading"><a href="#"><i class="glyphicon glyphicon-globe"></i></a> Sign up!</legend>
                             
                            <div class="panel-body">

                                <fieldset>
                                    <div class="row">
                                        <div class="center-block">

                                            <img src="Content/Images/if_3_avatar_2754579.png" class="profile-img" />
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-12 col-md-10  col-md-offset-1 ">
                                            <div class="form-group">
                                                <div class="input-group">
                                                    <span class="input-group-addon">
                                                        <i class="glyphicon glyphicon-user"></i>
                                                    </span>
                                                    <input class="form-control" placeholder="Username" name="loginname" id="loginname" type="text" autofocus required>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="input-group">
                                                    <span class="input-group-addon">
                                                        <i class="glyphicon glyphicon-lock"></i>
                                                    </span>
                                                    <input class="form-control" placeholder="Password" name="password" id="password" type="password" value="" required>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <%--<input type="button" class="btn btn-lg btn-primary btn-block" value="Sign in" onclick="javascript: signin();">--%>
                                                <button type="submit" class="btn btn-lg btn-primary btn-block" onclick="msg.SetText('');"> Sign in</button>
                                            </div>
                                        </div>
                                    </div>
                                </fieldset>

                            </div>
                            <div class="panel-footer ">
                                <dx:ASPxLabel runat="server" ID="msg" ClientInstanceName="msg" ForeColor="Red"></dx:ASPxLabel>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
        <div class="footer">
<%--            <div>
                <a href="#"><img src="Content/Images/FooterLogo.png" alt="DevExpress" /></a>
            </div>--%>
            <center>
            <div>
               <span>Copyright © <%=Now.Year%> <%=_PortalContextName %></span>
                <%--<a href="#">All trademarks or registered trademarks are property of their respective owners.</a>--%>
            </div></center>
        </div>


    </form>
</body>
</html>
