<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="MyGrid.aspx.vb" Inherits="WebSimple.MyGrid" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
            DataKeyNames="ID" CssClass="table table-hover"  >
            <Columns>
                <asp:BoundField DataField="FirstName" HeaderText="First Name" />
                <asp:BoundField DataField="LastName" HeaderText="Last Name" />
                <asp:BoundField DataField="City" HeaderText="City" />
                <asp:BoundField DataField="HotelName" HeaderText="Hotel Name" />
                <asp:BoundField DataField="Description" HeaderText="Description" />
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Button ID="cmdEdit" runat="server" Text="Select" 
                            CssClass="btn myshadow"
                            OnClientClick='<%# "myselect(""" + Eval("HotelName").ToString + """);return false;" %>'
                             />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        </div>
    </form>
</body>
</html>
