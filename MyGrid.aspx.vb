Public Class MyGrid
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then

            Using conn As New SqlConnection(My.Settings.TEST4)
                Dim strSQL =
                    "SELECT * FROM tblHotelsA ORDER BY HotelName"

                Using cmdSQL As New SqlCommand(strSQL, conn)
                    conn.Open()
                    Dim rstData As New DataTable
                    rstData.Load(cmdSQL.ExecuteReader)
                    GridView1.DataSource = rstData
                    GridView1.DataBind()
                End Using
            End Using

        End If
    End Sub

End Class