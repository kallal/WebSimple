<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="MyEditHotelC.ascx.vb" 
    Inherits="WebSimple.MyEditHotelC" %>
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

        <div id="EditRecord" runat="server" style="float:left;display:normal" clientidmode="Static"  >

            <br/>

            <style>
                .iForm label {display:inline-block;width:90px}
                .iForm span  {display:inline-block;font-weight:700
                }
                .iForm input {border-radius:8px;border-width:1px;margin-bottom:10px}                
                .iForm select {border-radius:8px;border-width:1px;margin-bottom:10px;margin-bottom:10px;height:24px;margin-left:-3px}                
                .iForm textarea {border-radius:8px;border-width:1px;margin-bottom:10px}     
                .iForm input[type=checkbox] {margin-right:8px}
            </style>
            <div style="float:left" class="iForm">
                <label>HotelName</label>
                <asp:TextBox ID="txtHotel" runat="server" f="HotelName" width="280">
                </asp:TextBox> <br />
                    <label>First Name</label>
                     <asp:TextBox ID="tFN" runat="server" f="FirstName" Width="140"></asp:TextBox> <br />
                    <label>Last Name</label>
                     <asp:TextBox ID="tLN" runat="server" f="LastName" Width="140"></asp:TextBox> <br />
           
                <label>City</label>
                <asp:DropDownList ID="cboCity" runat="server" Width="140px" 
                    DataTextField="City" 
                    DataValueField="id"
                    f="City_ID" >
                </asp:DropDownList>                
                
                <br />
                <label>Province</label><asp:TextBox ID="tProvince" runat="server" f="Province" Width="75"></asp:TextBox> 
            </div>
            <div style="float:left;margin-left:20px" class="iForm">
                
                <div style="float:left">
                <label>Description</label> <br />
                <asp:TextBox ID="txtNotes" runat="server" Width="260px" TextMode="MultiLine" 
                    Height="100px" f="Description" ></asp:TextBox>
                </div>

                <div style="float:left;margin-left:14px">                
                    <label>Hotel Options</label> <br />
                    <asp:CheckBoxList ID="chkOptions" runat="server" 
                        DataTextField="HotelOption" 
                        DataValueField="ID" >
                    </asp:CheckBoxList>                
                </div>

                <div style="clear:both">
                </div>

                    <asp:CheckBox ID="chkActive" f="Active" Text=" Active" 
                        runat="server" TextAlign="Right" Width="171px" />

            </div>
            <div style="clear:both"></div>
            <hr />

            <button id="cmdSave" runat="server" class="btn myshadow" type="button"
                 onserverclick="cmdSave_ServerClick"
                 onclick="$('#EditRecord').dialog('close');">
                <span aria-hidden="true" class="glyphicon glyphicon-floppy-saved"> Save</span> 
            </button>

            <button id="cmdCancel" runat="server" class="btn myshadow" style="margin-left:15px"
                type="button"
                onclick="myclose();return false;">
                <span aria-hidden="true" class="glyphicon glyphicon-arrow-left"> Back/Cancel</span>
            </button>
 
            <button id="cmdDelete" runat="server" class="btn myshadow" style="margin-left:15px"
                type="button"
                onserverclick="cmdDelete_ServerClick"
                onclick="if (!MyConfirmDel(this)) {return false};"  >
                <span aria-hidden="true" class="glyphicon glyphicon-trash"> Delete</span>
            </button>
            <br />
            <br />
       </div>


<%--        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:TEST4 %>" 
            SelectCommand="SELECT [ID], [HotelOption] FROM [tblOptions] ORDER BY [ID]">
        </asp:SqlDataSource>--%>

       <div id="mydelpop" style="display:none">
           <h4>Really delete this Hotel?</h4>
       </div>

       <script>
           function popedit() {

                MyPWidth = "62em"
                MyWidth = $(window).width()

                if (MyWidth < 840) {
                    MyPWidth = (MyWidth - 25)  + 'px'
                }

                var myDialog = $("#EditRecord");
                myDialog.dialog({
                    title: "Edit Hotel",
                    width: MyPWidth,
                    modal: true,
                    appendTo: "form",
                    dialogClass : "dialogWithDropShadow",
                    close: myclose
                });
           }

           function myclose() {
               var myDialog = $("#EditRecord");
               myDialog.dialog('close')
               // myDialog.find("form").remove();
               // destory the instance, but only
               // if exists (if we dont' clean up then button 
               // clicks don't work on 2nd use of dialog)
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

           function ShowChange() {
               btn = $('#<%= cmdSave.ClientID%>')
               btn.css('background-color', '#789eca')
           }


       </script>

