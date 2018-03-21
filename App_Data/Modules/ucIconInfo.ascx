﻿<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ucIconInfo.ascx.vb" Inherits="Modules_ucIconInfo" %>


<table>
    <tr style="width: 100%">
        <td style="width: 100%">
            <dx:ASPxCheckBox ID="cbEndless" runat="server" Theme="iOS" AutoPostBack="true"
                Text="Enable Endless Paging Mode" OnCheckedChanged="cbEndless_CheckedChanged">
            </dx:ASPxCheckBox>
        </td>
        <td>
            <dx:ASPxButton ID="clearSettings" runat="server" Text="Reset all"
                AutoPostBack="false" ToolTip="Remove all filtering, sorting and grouping">
                <ClientSideEvents Click="function(s, e){ grid.PerformCallback('clear'); }" />
            </dx:ASPxButton>
        </td>
    </tr>
</table>

<dx:ASPxGridView ID="gridView" runat="server" ClientInstanceName="grid" AutoGenerateColumns="false"
    KeyFieldName="FullIconID" Width="100%" OnCustomCallback="gridView_CustomCallback">
    <Settings ShowHeaderFilterButton="true" VerticalScrollableHeight="400" ShowGroupPanel="true" GroupFormat="{1}{2}" ShowFooter="true" />
    <SettingsSearchPanel Visible="true" />
    <SettingsPager Mode="ShowPager" PageSize="15"></SettingsPager>
    <SettingsBehavior AllowFixedGroups="true" />
    <SettingsCookies Enabled="true" StoreFiltering="true" StoreGroupingAndSorting="true" StoreColumnsVisiblePosition="true"
        StorePaging="true" StoreColumnsWidth="false" StoreControlWidth="false" />
    <Columns>
        <dx:GridViewDataImageColumn VisibleIndex="0" Name="ImageColumn" Caption="Icon" Width="40">
            <Settings AllowGroup="False" />
            <DataItemTemplate>
                <dx:ASPxImage ID="ASPxImage1" runat="server" ShowLoadingImage="true" EmptyImage-IconID='<%#Eval("FullIconID")%>'></dx:ASPxImage>
            </DataItemTemplate>
        </dx:GridViewDataImageColumn>
        <dx:GridViewDataTextColumn FieldName="FullIconID" VisibleIndex="1" Width="350">
            <Settings AllowHeaderFilter="False" AllowGroup="False" />
            <DataItemTemplate>
                <dx:ASPxTextBox ID="ASPxTextBox1" runat="server" Width="100%" Text='<%#Eval("FullIconID")%>' ReadOnly="true">
                    <ClientSideEvents GotFocus="function(s, e){ s.SelectAll(); }" />
                </dx:ASPxTextBox>
            </DataItemTemplate>
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataComboBoxColumn FieldName="Category" VisibleIndex="2" Width="150">
        </dx:GridViewDataComboBoxColumn>
        <dx:GridViewDataTextColumn FieldName="IconName" VisibleIndex="3">
            <Settings AllowHeaderFilter="False" />
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="EnumName" VisibleIndex="4">
            <Settings AllowHeaderFilter="False" AllowGroup="False" />
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="Collection" VisibleIndex="5" Width="100">
            <Settings HeaderFilterMode="CheckedList" />
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="Size" VisibleIndex="6" Width="60">
            <Settings HeaderFilterMode="CheckedList" />
        </dx:GridViewDataTextColumn>
    </Columns>
    <GroupSummary>
        <dx:ASPxSummaryItem SummaryType="Count" />
    </GroupSummary>
    <TotalSummary>
        <dx:ASPxSummaryItem FieldName="FullIconID" SummaryType="Count" />
    </TotalSummary>
    <Styles>
        <Header HorizontalAlign="Center"></Header>
        <AlternatingRow Enabled="True"></AlternatingRow>
    </Styles>
</dx:ASPxGridView>