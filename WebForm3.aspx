<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="WebForm3.aspx.vb" Inherits="WebSimple.WebForm3" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <asp:Button ID="Button1" runat="server" Text="Dialog Test" CssClass="btn"
        OnClientClick="popdiv();return false" />

    <div id="mypop" style="padding:1em">
        <h3>Dialog test</h3>
        <p>&nbsp;</p>
        <p>
            <asp:CheckBoxList ID="CheckBoxList1" runat="server">
            </asp:CheckBoxList>
        </p>
    </div>

    <script>
        function popdiv() {
            var myDialog = $("#mypop");
            myDialog.dialog({
                title:"This is the title",
                width: "30em",
                appendTo: "form",
                buttons: {
                    ok: function () { alert(' hit ok'); },
                    cancel: function () { alert(' hit cancel '); }
                }
            });
        }
    </script>




</asp:Content>
