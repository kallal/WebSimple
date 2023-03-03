Public Class SiteMaster
    Inherits MasterPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load

        Debug.Print($"master page load event is postback = {IsPostBack}")


    End Sub


End Class