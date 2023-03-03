<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="GridWithoutCustom2.aspx.vb" 
    Inherits="WebSimple.GridWithoutCustom2" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="ajaxToolkit" %>

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
		<div style="padding: 35px">
	<div id="MyGridArea" runat="server">
	<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
		DataKeyNames="ID"
		CssClass="table table-hover" Width="50%" GridLines="None"
		ShowHeaderWhenEmpty="true">
		<Columns>
			<asp:BoundField DataField="FirstName" HeaderText="FirstName" />
			<asp:BoundField DataField="LastName" HeaderText="LastName" />
			<asp:BoundField DataField="City" HeaderText="City" />
			<asp:BoundField DataField="HotelName" HeaderText="HotelName" />
			<asp:BoundField DataField="Description" HeaderText="Description" />
            <asp:TemplateField HeaderText="Info">
                <ItemTemplate>
                    <asp:Label ID="lblMarkUp" runat="server" width="340px"
                        Text='<%# Eval("ImageInfo") %>' >
                    </asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
			<asp:TemplateField>
				<ItemTemplate>
					<asp:Button ID="cmdEdit" runat="server" Text="Edit" CssClass="btn myshadow"
						OnClick="cmdEdit_Click" />
				</ItemTemplate>
			</asp:TemplateField>
		</Columns>
	</asp:GridView>
		<br />
		<asp:Button ID="cmdAdd" runat="server" Text="+Add new"  CssClass="btn myshadow"/>
	</div>
            <script>
                function myrowclick(rNum) {
                    __doPost
                    alert(rNum)
                }
            </script>

			<style>
				.iForm label {
					display: inline-block;
					width: 90px
				}

				.iForm span {
					display: inline-block;
					font-weight: 700
				}

				.iForm input {
					border-radius: 8px;
					border-width: 1px;
					margin-bottom: 10px
				}

				.iForm select {
					border-radius: 8px;
					border-width: 1px;
					margin-bottom: 10px;
					margin-bottom: 10px;
					height: 24px;
					margin-left: -3px
				}

				.iForm textarea {
					border-radius: 8px;
					border-width: 1px;
					margin-bottom: 10px
				}

				.iForm input[type=checkbox] {
					margin-right: 8px
				}
			</style>


            <div id="MyEditArea" runat="server" 
                style="float: left; display: none ;padding:15px;border-style:solid" >


            <div style="float: left" class="iForm">

	            <label>HotelName</label>
	            <asp:TextBox ID="txtHotel" runat="server" f="HotelName" Width="280" /> <br />
	            <label>First Name</label>
	            <asp:TextBox ID="tFN" runat="server" f="FirstName" Width="140" /> <br />
	            <label>Last Name</label>
	            <asp:TextBox ID="tLN" runat="server" f="LastName" Width="140" /><br />

	            <label>City</label>
	            <asp:TextBox ID="tCity" runat="server" f="City" Width="140" /><br />
	            <label>Province</label>
	            <asp:TextBox ID="tProvince" runat="server" f="Province" Width="75" />
            </div>

            <div style="float: left; margin-left: 20px" class="iForm">
	            <div style="float: left">
		            <label>Description</label>
		            <br />
		            <asp:TextBox ID="txtNotes" runat="server" Width="290px" TextMode="MultiLine"
			            Height="100px" f="Description"></asp:TextBox>
	            </div>

	            <div style="float: left; margin-left: 14px">
		            <label>Hotel Options</label>
		            <br />
		            <asp:CheckBox ID="chkSmoking" runat="server" Text="Smoking" f="Smoking" /><br />
		            <asp:CheckBox ID="chkBalcony" runat="server" Text="Balcony" f="Balcony" /><br />
		            <asp:CheckBox ID="chkBags" runat="server" Text="Has Baggage" f="HasBaggage" /><br />
	            </div>

	            <div style="clear: both">
	            </div>

	            <asp:CheckBox ID="chkActive" f="Active" Text=" Active"
		            runat="server" TextAlign="Right" Width="171px" />
                

            </div>
            <div style="clear: both"></div>
            <hr />
                <div>
                    <h5>Markup Display</h5>
                    <asp:TextBox ID="tImageInfo" runat="server" TextMode="MultiLine" Width="100%"
                        rows="12" f="ImageInfo"
                        ></asp:TextBox>
                    <ajaxToolkit:HtmlEditorExtender ID="tImageInfo_HtmlEditorExtender" runat="server" BehaviorID="tImageInfo_HtmlEditorExtender" TargetControlID="tImageInfo" EnableSanitization="False">
                    </ajaxToolkit:HtmlEditorExtender>
                </div>
            <br />

            <hr />
            <button id="cmdSave" runat="server" class="btn myshadow" type="button"
	            onserverclick="cmdSave_ServerClick" >
	            <span aria-hidden="true" class="glyphicon glyphicon-floppy-saved">Save</span>
            </button>

            <button id="cmdCancel" runat="server" class="btn myshadow" style="margin-left: 15px"
	            type="button"
                onserverclick="cmdCancel_ServerClick">
	            <span aria-hidden="true" class="glyphicon glyphicon-arrow-left">Back/Cancel</span>
            </button>

            <button id="cmdDelete" runat="server" class="btn myshadow" style="margin-left: 15px"
	            type="button"
	            onserverclick="cmdDelete_ServerClick"
	            onclick="if (!confirm('Delete this record?')) {return false};">
	            <span aria-hidden="true" class="glyphicon glyphicon-trash">Delete</span>
            </button>
            <br />
            <br />

       </div>


    <script>

        function popedit(btnS) {
            var btn = $('#' + btnS)
            var myDialog = $("#MyEditArea");
            myDialog.dialog({
                title: "Edit Hotel",
                width: "45%",
                modal: true,
                appendTo: "form",
                dialogClass: "dialogWithDropShadow",
                close: myclose,
                position: { my: "right top", at: "right bottom", of: btn }
            });
        }

        function myclose() {
            var myDialog = $("#MyEditArea");
            myDialog.dialog('close')
            if (myDialog.hasClass('ui-dialog-content')) {
                myDialog.dialog('destroy');
            }
        }

    </script>



	</div>

<script>
                   //function MyConfirmDel(Btn) {

                   //    if (MyConfirmDelOK) {
                   //        MyConfirmDelOK = false
                   //        return true
                   //    }
                   //    var myDialog = $("#mydelpop");
                   //    myDialog.dialog({
                   //        title: "Delete Hotel",
                   //        width: "26em",
                   //        modal: true,
                   //        dialogClass: 'ui-widget-shadow',
                   //        position: { my: "left top", at: "right bottom", of: Btn },
                   //        buttons: [

                   //            {
                   //                text: 'Delete',
                   //                class: 'myshadow',
                   //                click: function () {
                   //                    myDialog.dialog('close')
                   //                    MyConfirmDelOK = true
                   //                    $(Btn).click()
                   //                }
                   //            },
                   //            {
                   //                text: 'Cancel',
                   //                class: 'myshadow',
                   //                click: function () {
                   //                    myDialog.dialog('close')
                   //                }
                   //            }
                   //        ]
                   //    })
                   //}

        //var MyConfirmDelOK = false
</script>

    </form>

</body>
</html>
