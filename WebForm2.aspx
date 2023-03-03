 <%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="WebForm2.aspx.vb" Inherits="WebSimple.WebForm2" %>


<%@ Register src="Controls/MyEditHotelC.ascx" tagname="MyEditHotelC" tagprefix="uc1" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <br />
    <div style="float:right">
      <button id="cmdReSet" runat="server" class="btn myshadow" style="margin-left:15px"
                type="button"
                onclick="if (!MyReSet(this)) {return false};"
                onserverclick="cmdReSet_ServerClick" >
                <span aria-hidden="true" class="glyphicon glyphicon-retweet"> Reset Data</span>
       </button>
    </div>
      

    <div id="resetpop" style="display:none">
        <h4><i>This will re-set the database to original data</i></h4>
    </div>
    <link href="Scripts/jquery.toast.min.css" rel="stylesheet" />
    <script src="Scripts/jquery.toast.min.js"></script>
    <script>

       var MyReSetOk = false
           function MyReSet(Btn) {
               if (MyReSetOk) {
                   MyReSetOk = false
                   return true
               }
               var myDialog = $("#resetpop");
               myDialog.dialog({
                   title: "Reset data",
                   width: "26em",
                   modal: true,
                   dialogClass: 'ui-widget-shadow',
                   position: { my: "right top", at: "right bottom", of: Btn },
                   buttons: [
                       {
                           text: 'Reset',
                           class: 'myshadow',
                           click: function () {
                               myDialog.dialog('close')
                               MyReSetOk = true
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


        function toastcall(c, h, t, d) {
            var cmd = $('#' + c);
            var mypos = cmd.position();
            // mypos.left = mypos.left + cmd.width() + 0;
            // mypos.top = 80;

            $.toast({
                heading: h,
                text: t,
                position: mypos,
                icon: 'info',
                hideAfter: d,
                allowToastClose: false,
                loader: false,
                stack: 10,
                showHideTransition: 'slide'
            });
        }
    </script>



    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <ContentTemplate>


    <div id="MyGridArea" runat="server" ClientIdMode="static">

        <div id="mysearchArea" runat="server" style="border:solid;border-width:1px;width:84%;float:left;padding:8px">

            <div style="float:left;margin-right:10px">
            <h4>Filter</h4>
            </div>
            <div style="float:left">
                <asp:Label ID="Label1" runat="server" Text="Search Hotel"></asp:Label>
                <br />
                 <asp:TextBox ID="txtHotel" runat="server"></asp:TextBox>
            </div>

            <div style="float:left;margin-left:20px">
                <asp:Label ID="Label2" runat="server" Text="Search City"></asp:Label>
                <br />
                <asp:TextBox ID="txtCity" runat="server"></asp:TextBox>
            </div>

            <div style="float:left;margin-left:20px">
                <asp:Label ID="Label3" runat="server" Text="Must Have Description"></asp:Label>
                <br />
                <asp:CheckBox ID="chkDescripiton" runat="server"  />
            </div>

            <div style="float:left;margin-left:20px">
                <asp:Label ID="Label4" runat="server" Text="Show only Active Hotels"></asp:Label>
                <br />
                <asp:CheckBox ID="chkActiveOnly" runat="server"  />
            </div>

            <div style="float:left;margin-left:20px">
                <asp:Button ID="cmdSearch" runat="server" Text="Search" CssClass="btn myshadow" OnClick="cmdSearch_Click"/>
            </div>

            <div style="float:left;margin-left:20px">
                <asp:Button ID="cmdClear" runat="server" Text="Clear Fitler" CssClass="btn myshadow" OnClick="cmdClear_Click"/>
            </div>

        </div>



        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        DataKeyNames="ID" 
        CssClass="table table-hover" Width="60em" AllowPaging="True" GridLines="None"
        ShowHeaderWhenEmpty="true" 
        
        >
        <EmptyDataTemplate>
            <h3><i>No Hotels found</i></h3>
        </EmptyDataTemplate>
        <Columns>
            <asp:BoundField DataField="FirstName" HeaderText="FirstName" SortExpression="FirstName" />
            <asp:BoundField DataField="LastName" HeaderText="LastName" SortExpression="LastName" />
            <asp:BoundField DataField="City" HeaderText="City" SortExpression="City" />
            <asp:BoundField DataField="HotelName" HeaderText="HotelName" SortExpression="HotelName" />
            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Button ID="cmdEdit" runat="server" Text="Edit" CssClass="btn myshadow"
                        OnClick="cmdEdit_Click" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <PagerStyle CssClass="GridPager" />
    </asp:GridView>
    </div>
            <br />
            <br />
        <asp:Button ID="cmdAdd" runat="server" Text="+Add" CssClass="btn myshadow"/>


    <br />
            <div id="MyEditArea" runat="server">

                <uc1:MyEditHotelC ID="EHotel" runat="server"
                    MyEditArea="MyEditArea"
                    MyGridArea="MyGridArea"
                    MyTable="tblHotelsA"
                    MyTitle="Edit Hotel Informaton" />

            </div>


        </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>
