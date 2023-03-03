Public Class GridWithoutCustom2
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then
            LoadGrid()
        End If

    End Sub

    Sub LoadGrid()

        Dim strSQL As String = "SELECT * FROM tblHotelsP ORDER BY HotelName"
        GridView1.DataSource = Myrst(strSQL)
        GridView1.DataBind()

    End Sub

    Public Function Myrst(strSQL As String) As DataTable

        Dim rstData As New DataTable
        Using mycon As New SqlConnection(My.Settings.TEST4)

            Using cmdSQL As New SqlCommand(strSQL, mycon)
                mycon.Open()
                rstData.Load(cmdSQL.ExecuteReader)
            End Using

        End Using

        Return rstData

    End Function

    Protected Sub cmdEdit_Click(sender As Object, e As EventArgs)

        Dim btn As Button = sender
        Dim gRow As GridViewRow = btn.NamingContainer
        Dim intPK As Integer = GridView1.DataKeys(gRow.RowIndex).Item("ID")

        Dim strSQL As String =
            $"SELECT * FROM tblHotelsP WHERE ID = {intPK}"
        fLoader(MyEditArea, Myrst(strSQL).Rows(0))
        ViewState("PK") = intPK     ' same our PK for later

        MyGridArea.Style.Add("display", "none")
        MyEditArea.Style.Add("display", "normal")
        ' ClientScript.RegisterStartupScript(Page.GetType, "popedit", $"popedit('{btn.ClientID}')", True)

    End Sub

    Sub EditOne(intPK As Integer)


    End Sub

    Protected Sub cmdSave_ServerClick(sender As Object, e As EventArgs)

        ' check for dupliate hotel name when saving or adding new reocrd.
        Dim intPK As Integer = ViewState("PK")

        Call fWriter(MyEditArea, intPK, "tblHotelsP")
        MyGridArea.Style.Add("display", "normal")
        MyEditArea.Style.Add("display", "none")
        LoadGrid()

    End Sub

    Protected Sub cmdDelete_ServerClick(sender As Object, e As EventArgs)

    End Sub

    Protected Sub cmdAdd_Click(sender As Object, e As EventArgs) Handles cmdAdd.Click

        EditOne(0)      ' 0 pk = add mode


    End Sub

    Protected Sub cmdCancel_ServerClick(sender As Object, e As EventArgs)

        MyGridArea.Style.Add("display", "normal")
        MyEditArea.Style.Add("display", "none")


    End Sub

    Protected Sub GridView1_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles GridView1.RowDataBound

        If e.Row.RowType = DataControlRowType.DataRow Then

            e.Row.Cells(3).Attributes.Add("onclick", $"myrowclick('{e.Row.RowIndex.ToString}')")

        End If

    End Sub


End Class