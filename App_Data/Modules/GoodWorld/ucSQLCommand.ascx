<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ucSQLCommand.ascx.vb" Inherits="Modules_ucSQLCommand" %>
 

 <dx:BootstrapMemo ID="txtSqlCommand" ClientInstanceName="txtSqlCommand" runat="server" Rows="10" >
</dx:BootstrapMemo>
<dx:BootstrapButton ID="BootstrapButton1" runat="server" Text="Summit" AutoPostBack="false">
    <ClientSideEvents Click="function(s,e) { 
        cbCommand.PerformCallback(txtSqlCommand.GetText());
         }" />
</dx:BootstrapButton>

 <dx:ASPxCallback ID="cbCommand" runat="server" ClientInstanceName="cbCommand">
            <ClientSideEvents CallbackComplete="function(s, e) {
                    alert(e.result);                                               
             }" />
        </dx:ASPxCallback>
