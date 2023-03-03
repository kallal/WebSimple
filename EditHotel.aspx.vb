Public Class EditHotel
    Inherits System.Web.UI.Page

    Dim intHotelPK As Integer = 0

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then

            intHotelPK = Session("HotelPK")

            ViewState("HotelPK") = intHotelPK

            ' Load up our form to edit hotel
            Dim strSQL As String = "SELECT * FROM tblHotelsA WHERE ID = " & intHotelPK

            Dim rstHotel As DataRow = Myrst(strSQL).Rows(0)

            Call fLoader(Me.EditHotelDiv, rstHotel)
        Else
            intHotelPK = ViewState("HotelPK")
        End If

    End Sub

    Protected Sub cmdSave_ServerClick(sender As Object, e As EventArgs)

        Dim strSQL As String = "SELECT * FROM tblHotelsA WHERE ID = " & intHotelPK
        Dim rstData As DataTable = Myrst(strSQL)
        Call fWriterW(EditHotelDiv, rstData.Rows(0))
        Call MyRstSave(rstData, "tblHotelsA")

        Response.Redirect("ChooseHotel")

    End Sub


End Class