<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="HotelEdit.aspx.vb" Inherits="WebSimple.HotelEdit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <script src="Scripts/jquery-3.4.1.js"></script>
    <link href="Content/bootstrap.css" rel="stylesheet" />
    <script src="Scripts/bootstrap.js"></script>

</head>
<body>
    <form id="form1" runat="server">
        <div style="padding:35px">
            <asp:FormView ID="FormView1" runat="server" DataKeyNames="ID" DataSourceID="SqlDataSource1">
                <ItemTemplate>

                    <div style="float:left;text-align:right">
                        <br />
                    HotelName:
                    <asp:TextBox ID="HotelNameTextBox" runat="server" Text='<%# Eval("HotelName") %>' />
                    <br />
                    FirstName:
                    <asp:TextBox ID="FirstNameTextBox" runat="server" Text='<%# Eval("FirstName") %>' />
                    <br />
                    LastName:
                    <asp:TextBox ID="LastNameTextBox" runat="server" Text='<%# Eval("LastName") %>' />
                    <br />
                    City:
                    <asp:TextBox ID="CityTextBox" runat="server" Text='<%# Eval("City") %>' />
                    <br />
                    &nbsp;<br />
                    </div>

                    <div style="float:left;margin-left:25px">
                    Description<br />
                        &nbsp;<asp:TextBox ID="DescriptionTextBox" runat="server" 
                        Text='<%# Eval("Description") %>'  TextMode="MultiLine" Width="400px" Height="100px"/>
                    </div>

                    <div style="clear:both">

                    </div>
                    <br />
                    <asp:Button ID="UpdateButton" runat="server" 
                        CausesValidation="True" CommandName="Update" Text="Update" CssClass="btn"/>
                    &nbsp;
                    <asp:Button ID="UpdateCancelButton" runat="server" CausesValidation="False" 
                        CommandName="Cancel" Text="Cancel" CssClass="btn"/>
                </ItemTemplate>

            </asp:FormView>
            <br />
            <br />
            <br />
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:TEST4 %>" DeleteCommand="DELETE FROM [tblHotelsA] WHERE [ID] = @ID" InsertCommand="INSERT INTO [tblHotelsA] ([FirstName], [LastName], [City], [HotelName], [Description]) VALUES (@FirstName, @LastName, @City, @HotelName, @Description)" SelectCommand="SELECT [ID], [FirstName], [LastName], [City], [HotelName], [Description] FROM [tblHotelsA] ORDER BY [HotelName]" UpdateCommand="UPDATE [tblHotelsA] SET [FirstName] = @FirstName, [LastName] = @LastName, [City] = @City, [HotelName] = @HotelName, [Description] = @Description WHERE [ID] = @ID">
                <DeleteParameters>
                    <asp:Parameter Name="ID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="FirstName" Type="String" />
                    <asp:Parameter Name="LastName" Type="String" />
                    <asp:Parameter Name="City" Type="String" />
                    <asp:Parameter Name="HotelName" Type="String" />
                    <asp:Parameter Name="Description" Type="String" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="FirstName" Type="String" />
                    <asp:Parameter Name="LastName" Type="String" />
                    <asp:Parameter Name="City" Type="String" />
                    <asp:Parameter Name="HotelName" Type="String" />
                    <asp:Parameter Name="Description" Type="String" />
                    <asp:Parameter Name="ID" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <br />
            <br />
        </div>
    </form>
</body>
</html>
