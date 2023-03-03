<%@ Page Title="Home Page" Language="VB" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.vb" Inherits="WebSimple._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">


    <div style="padding:35px">

        <h1>Simple Edit form (crud) exmaple in ASP.NET</h1>

    <h2>Critera for this example</h2>
        <h4>
            In this exmaple, we are going to select a reocrd to edit, have a multi-list LIST box and also
            a combo box in that form. A simple save, or cancel button after editing the form will suffice.
            I don't think it matters or is approate to have reocrd navagation.
            (but ASP.NET does have a data pager control I could use for this).
            Web Forms lets you build dynamic websites using a familiar drag-and-drop, event-driven model.
        </h4>
        <br />
        <h2>Assumptions made</h2>
        <h4>
            We are to assume that database already exists (to save time here about creating a database).</h4>
        <h4>
            That edit (webform) will have a combo box (like Access 2 columns - first colum hidden with PK, and 2nd colum with text display.</h4>
        <h4>
            A simple save, cancel, and delete button after editing the form will suffice.
        </h4>
        <h4>
            We are free to use the developer tools "wizards" and default templates to create the form, or grids etc.
        </h4>

        <br />
        <h2>Outline of time taken to build this simple edit form</h2>
        <h4>We are free to use existing library code.</h4>
        <h4>
            So, we are to include a outline of how the form was made - AND HOW long!
        </h4>
        <h4>
            We are to outline (share) the code to drive the data, and how the controls and web UI was interfaced to the data.

        </h4>


        <h2>Software specification</h2>

        <h4>The form and function we are to produce is this form</h4>


    <ul>

        <li>
        <h4>Record navagation. A grid or pick list will suffice. This main record page also allows adding of new records.</h4>
        </li>

        <li><h4>Form will have a classic combo box (to select City). So upon save we use/save PK&nbsp; "ID&quot; to City_ID in the one form reocrd. We of course display the City text name. </h4></li>

        <li><h4>The multi-select list box will of course require a child related table tblMyHotelOptions. This simple UI thus requires a child table.
        <br />
        (a table of choices for the multi-select listbox).</h4></li>
        
        <li>
        <h4>So, a select, or del-select of such hotel options will create or delete the appropate child rows
            in that related child table.</h4>
        </li>

    </ul>
        <h2>Data base ER diagram</h2>
        <p>
            <img alt="Database ER diagram" src="Content/images/Er.png" style="width: 864px; height: 697px" /></p>
        <p>&nbsp;</p>

        <br />
        <h2>Estimated Time to cretae the Access form</h2>
        <h4>From start to finish, total time = 3 minutes</h4>

        <h2>Asp.net + vb.net - Estimated Time to create the form</h2>
        <h4>From start to finish, total time = (nuts nuts nuts)</h4>




    </div>




</asp:Content>
