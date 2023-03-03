<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="HowDone.aspx.vb" Inherits="WebSimple.HowDone" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


        <h1>How parts work - approach and some code</h1>

        <h2>Creating a combo box (dropdownlist) example</h2>
        <h4>Form has this drop down.</h4>
        <br />
        <br />

        <div style="text-align:center">

            <img alt="Combo box drop down" src="Content/images/DropDown.png" 
                style="width: 777px; height: 618px"/>

        </div>
            <div style="clear:both">
                <br />
        </div>
        <h3>Markup for combo box (DropDownList) is </h3>
        <div>
            <img src="Content/images/MarkDropDown.png" />
        </div>

        <h4>Note how like MS-Access we have two columns (hidden id, and display City)</h4>
        <br />

        <h4>Code run on page load to fill above combo box. We give combo box a recordSet.</h4>

        <img src="Content/images/CodeDropFill.png" />
    

        <h3>

            &nbsp;The multi-select check box list (in MS-access ZERO code!!)</h3>
        <p>

            <div style="text-align: center">
            <img alt="check box list" src="Content/images/CheckboxList.png" 
                style="width:345px; height:314px" />

            </div>
        <h4>

            The markup is this:</h4>
        <h4>

            <img alt="Check box list markup" src="Content/images/MarkCheckBoxList.png" style="width: 651px; height: 218px" /></h4>
        <h4>

            So, like combo box, listbox or whatever? They are ALL in asp.net data driven. But, like VBA, you can use code or the wizard to build above.</h4>
        <p>
        <br />

            &nbsp;</p>
        <h4>Now fair is fair. While the wizard creted the check box list. 
            And while I let the wizard create the SQL source (just like Access does 
            - we can code the control SQL with VBA or let the wizard do this for us</h4>
        <h4>
        Hovever, we still need to write code to shuffle the check box choices in
            and out of that child table
        </h4>

        <h4>So, code to load (set check box) choices from child table is this</h4>
        <p>&nbsp;</p>
        <p>
            <img alt="Code to load check box selection" src="Content/images/CodeCheckBoxSel.png" style="width: 808px; height: 169px" /></p>
        <p>&nbsp;</p>


        <h4>And code on save? Well, we have to remove or add checked options. 
        What if a option was alredy checked? We can't add again to child table.
        So, I use this lazy trick (I just delete them all and then add checked ones!!).

        eg this code on save:
        </h4>
        <p>
            <img alt="Check Box List Save Code" src="Content/images/CodeCheckBoxSave.png" style="width: 791px; height: 418px" /></p>
        <h4>And just to enusre we not faking anything here. The MyRstSave sends the deleted rows, added rows, or edit rows back to the database in one shot</h4>
        <p>
            <img alt="Recordset (datatable) save in vb.net" src="Content/images/rstsave.png" style="width: 694px; height: 293px" /></p>
        <p>&nbsp;</p>


        However, again note use of reocrdsets (data table). Like MS-Access, this tends 
        to save a bloat load of writing SQL delete or update statements.

       <h2>Creating the main grid pick list to select a record</h2>
       <h4>Again we use wizard and let it build SQL </h4>
       <h4>Note again, we don't write loops in asp.net to fill data bound controls
           (like MS-Access we feed such controls reordsets)</h4>

       <h3>Short create the grid Video - sorry out of time to write this out.</h3>
        <br />
        <br />

    <div style="position:absolute;left:50px;right:50px;text-align:center">
         <video src="Content/Video/creategrid.mp4" controls="controls" width="1200"/>
    </div>
   


</asp:Content>
