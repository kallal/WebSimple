<%@ Page Title="" Language="vb" AutoEventWireup="false" 
    MasterPageFile="~/Site.Master" CodeBehind="MySetup.aspx.vb" Inherits="WebSimple.MySetup" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


    <style>
        .myshadow
        {box-shadow: 8px 8px 8px 0px gray}
        .myshadow {border-radius:10px}
        .myshadow:hover {background-color:#789eca;transition: 0.5s;}
    </style>


    <div>

        <br />
        <asp:Button ID="Button1" runat="server" Text="Process SQL" CssClass="btn myshadow" />

        <asp:Button ID="cmdExecuteReturn" runat="server" 
            Text="Process SQL - return " CssClass="btn myshadow"
            style="margin-left:35px"/>


                <asp:Button ID="cmdExecuteNew" runat="server" 
            Text="Process SQL - new (split) " CssClass="btn myshadow"
            style="margin-left:35px"/>

;<br />
        <asp:Button ID="cmdShowCon" runat="server" Text="show con" />

        <asp:Button ID="cmdTestCon" runat="server" Text="Test con"
            style="margin-left:35px"/>

        <br />

        <br />
        <div>
            <asp:TextBox ID="TextBox1" runat="server" TextMode="MultiLine" 
                style="min-width:none;width:90%;height:400px"
                
                ></asp:TextBox>
        </div>


        <br />
        <br />
 


    </div>


</asp:Content>
