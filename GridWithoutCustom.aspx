<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="GridWithoutCustom.aspx.vb" Inherits="WebSimple.GridWithoutCustom" %>

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
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>


    <div style="padding:35px">

    <div id="MyGridArea" runat="server" clientidmode="static">
        <h3><i>Edit Hotels</i></h3>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
            DataKeyNames="ID" Width="38%" CssClass="table table-hover"  >
            <Columns>
                <asp:BoundField DataField="FirstName" HeaderText="First Name" />
                <asp:BoundField DataField="LastName" HeaderText="Last Name" />
                <asp:BoundField DataField="City" HeaderText="City" />
                <asp:BoundField DataField="HotelName" HeaderText="Hotel Name" />
                <asp:BoundField DataField="Description" HeaderText="Description" />
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Button ID="cmdEdit" runat="server" Text="Edit" CssClass="btn myshadow"
                            OnClick="cmdEdit_Click" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>

    
            <style>
                .iForm label {display:inline-block;width:90px}
                .iForm span  {display:inline-block;font-weight:700
                }
                .iForm input {border-radius:8px;border-width:1px;margin-bottom:10px}                
                .iForm select {border-radius:8px;border-width:1px;margin-bottom:10px;margin-bottom:10px;height:24px;margin-left:-3px}                
                .iForm textarea {border-radius:8px;border-width:1px;margin-bottom:10px}     
                .iForm input[type=checkbox] {margin-right:8px}
            </style>


    <div id="EditRecord" runat="server"
        style="float: left; display: none;border:solid 2px;padding:15px;border-radius:20px" clientidmode="Static" >
    <br />
    <div style="float: left" class="iForm">

        <label>HotelName</label>
        <asp:TextBox ID="txtHotel" runat="server"  Width="280">
        </asp:TextBox>
        <br />
        <label>First Name</label>
        <asp:TextBox ID="tFN" runat="server"  Width="140"></asp:TextBox>
        <br />
        <label>Last Name</label>
        <asp:TextBox ID="tLN" runat="server"  Width="140"></asp:TextBox>
        <br />
        <label>City</label>
        <asp:TextBox ID="tCity" runat="server" Width="140"></asp:TextBox>
        <br />
        <label>Province</label><asp:TextBox ID="tProvince" runat="server"  Width="75"></asp:TextBox>
    </div>

    <div style="float: left; margin-left: 20px" class="iForm">
        <div style="float: left">
            <label>Description</label>
            <br />
            <asp:TextBox ID="txtNotes" runat="server" Width="260px" TextMode="MultiLine"
                Height="100px" ></asp:TextBox>
        </div>

        <div style="float: left; margin-left: 14px">
            <label>Hotel Options</label>
            <br />
            <asp:CheckBox ID="chkBalcony" runat="server" Text="Balcony" />
            <br />
            <asp:CheckBox ID="chkBags" runat="server" Text="Has Baggage" />
            <br />
        </div>

        <div style="clear: both">
        </div>

        <asp:CheckBox ID="chkActive" f="Active" Text=" Active"
            runat="server" TextAlign="Right" Width="171px" />

    </div>
    <div style="clear: both"></div>
    <hr />

                <button id="cmdSave" runat="server" class="btn myshadow" type="button"
                    onserverclick="cmdSave_ServerClick"
                    onclick="$('#EditRecord').dialog('close');">
                    <span aria-hidden="true" class="glyphicon glyphicon-floppy-saved">Save</span>
                </button>

                <button id="cmdCancel" runat="server" class="btn myshadow" style="margin-left: 15px"
                    type="button"
                    onserverclick="cmdCancel_ServerClick" >
                    <span aria-hidden="true" class="glyphicon glyphicon-arrow-left">Back/Cancel</span>
                </button>

                <button id="cmdDelete" runat="server" class="btn myshadow" style="margin-left: 15px"
                    type="button"
                    onserverclick="cmdDelete_ServerClick"
                    onclick="if (!MyConfirmDel(this)) {return false};">
                    <span aria-hidden="true" class="glyphicon glyphicon-trash">Delete</span>
                </button>
                <br />
                <br />
            </div>

       <div id="mydelpop" style="display:none">
           <h4>Really delete this Hotel?</h4>
       </div>
        </div>


            <script>
                function popedit() {

                    var myDialog = $("#EditRecord");
                    myDialog.dialog({
                        title: "Edit Hotel",
                        width: "62em",
                        modal: true,
                        appendTo: "form",
                        dialogClass: "dialogWithDropShadow",
                        close: myclose
                    });
                }

                function myclose() {
                    var myDialog = $("#EditRecord");
                    myDialog.dialog('close')
                    if (myDialog.hasClass('ui-dialog-content')) {
                        myDialog.dialog('destroy');
                    }
                }


                var MyConfirmDelOK = false
                function MyConfirmDel(Btn) {
                    if (MyConfirmDelOK) {
                        MyConfirmDelOK = false
                        return true
                    }
                    var myDialog = $("#mydelpop");
                    myDialog.dialog({
                        title: "Delete Hotel",
                        width: "26em",
                        modal: true,
                        dialogClass: 'ui-widget-shadow',
                        position: { my: "left top", at: "right bottom", of: Btn },
                        buttons: [

                            {
                                text: 'Delete',
                                class: 'myshadow',
                                click: function () {
                                    myDialog.dialog('close')
                                    MyConfirmDelOK = true
                                    $(Btn).click()
                                }
                            },
                            {
                                text: 'Cancel',
                                class: 'myshadow',
                                click: function () {
                                    myDialog.dialog('close')
                                }
                            }
                        ]
                    })
                }
            </script>



    </form>

</body>
</html>
