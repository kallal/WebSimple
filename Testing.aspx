<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Testing.aspx.vb" Inherits="WebSimple.Testing" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <title></title>
    <script src="Scripts/jquery-3.4.1.js"></script>
    <script src="Scripts/bootstrap.js"></script>
    <link href="Content/bootstrap.css" rel="stylesheet" />
    <link href="Content/bootstrap-theme.css" rel="stylesheet" />
    <link href="Content/jquery-ui.css" rel="stylesheet" />
    <script src="Scripts/jquery-ui.js"></script>
        <style>
        .myshadow
        {box-shadow: 8px 8px 8px 0px gray}
        .myshadow {border-radius:10px}
        .myshadow:hover {background-color:#789eca;transition: 0.5s;}
    </style>

    <style>
     .dialogWithDropShadow
     {
         -webkit-box-shadow: 10px 10px 10px rgba(0, 0, 0, 0.5);  
         -moz-box-shadow: 10px 10px 10px rgba(0, 0, 0, 0.5); 
     }
    </style>



</head>
<body>
    <form id="form1" runat="server">

        <div style="padding:35px">

            <h3>Enter or Select Hotel Name</h3>
            <asp:TextBox ID="txtHotel" runat="server" Width="248px" 
                style="margin-right:15px" ClientIDMode="Static">

            </asp:TextBox>

             <button id="cmdSave" runat="server" class="btn myshadow" type="button"
                 onclick="pophotel(this);return false;">
                <span aria-hidden="true" class="glyphicon glyphicon-home"> Pick&ensp;Hotel</span> 
            </button>

            <div id="popdiv">
            </div>

            <script>
                function pophotel(Btn) {

                    var myDialog = $("#popdiv");
                    myDialog.dialog({
                        title: "Please Select a Hotel",
                        width: "40%",
                        modal: true,
                        autoOpen: false,
                        dialogClass: 'ui-widget-shadow',
                        appendTo: "form",
                        position: { my: "left top", at: "right bottom", of: Btn },

                        buttons: [
                            {
                                text: 'Cancel',
                                class: 'myshadow',
                                click: function () {
                                    myDialog.dialog('close')
                                }
                            }
                        ]
                    })
                    myDialog.load("MyGrid.aspx")
                    myDialog.dialog("open")


                }

                function myselect(sHotel) {
                    var myDialog = $("#popdiv");
                    myDialog.dialog('close')
                    $('#txtHotel').val(sHotel)
                }
            </script>


        </div>

    </form>
</body>
</html>
