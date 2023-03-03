Public Class GridWithoutCustom
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then
            LoadGrid()
        End If

    End Sub

    Sub LoadGrid()

        Dim cmdSQL = New SqlCommand
        cmdSQL.CommandText = "SELECT * FROM tblHotelsA ORDER BY HotelName"

        GridView1.DataSource = MyrstP(cmdSQL)
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

    Public Function MyrstP(cmdSQL As SqlCommand) As DataTable

        Dim rstData As New DataTable
        Using mycon As New SqlConnection(My.Settings.TEST4)

            Using (cmdSQL)
                cmdSQL.Connection = mycon
                mycon.Open()
                rstData.Load(cmdSQL.ExecuteReader)
            End Using

        End Using

        Return rstData

    End Function

    Protected Sub cmdEdit_Click(sender As Object, e As EventArgs)

        Dim btn As Button = sender
        Dim gRow As GridViewRow = btn.NamingContainer

        EditRow(gRow.RowIndex)

    End Sub

    Sub EditRow(rowNum As Integer)

        Dim intPK As Integer = GridView1.DataKeys(rowNum).Item("ID")
        Dim cmdSQL As New SqlCommand()
        cmdSQL.CommandText = "SELECT * FROM tblHotelsA WHERE ID = @ID"
        cmdSQL.Parameters.Add("@ID", SqlDbType.Int).Value = intPK

        Dim rstData As DataTable = MyrstP(cmdSQL)

        ' load up our edit div
        With rstData.Rows(0)
            tFN.Text = .Item("FirstName")
            tLN.Text = .Item("lastName")
            txtHotel.Text = .Item("HotelName")
            txtNotes.Text = .Item("Description")
            chkActive.Checked = .Item("Active")
            chkBags.Checked = .Item("HasBags")
        End With
        ViewState("PK") = intPK

        ' now hide gv, show edit area
        MyGridArea.Style.Add("display", "none")
        EditRecord.Style.Add("display", "normal")


        'ScriptManager.RegisterStartupScript(Me.Page, Page.GetType, "mypopedit", "popedit()", True)

    End Sub

    Protected Sub cmdSave_ServerClick(sender As Object, e As EventArgs)

        Dim cmdSQL As New SqlCommand("SELECT * FROM tblHotelsA WHERE ID = @ID")
        cmdSQL.Parameters.Add("@ID", SqlDbType.Int).Value = ViewState("PK")

        Dim rstData As DataTable = MyrstP(cmdSQL)

        With rstData.Rows(0)
            .Item("FirstName") = tFN.Text
            .Item("lastName") = tLN.Text
            .Item("HotelName") = txtHotel.Text
            .Item("Description") = txtNotes.Text
            .Item("Active") = chkActive.Checked
            .Item("HasBags") = chkBags.Checked
        End With

        MyRstSave(rstData, "tblHotelsA")

        ' re-fresh grid
        LoadGrid()

    End Sub

    Public Sub MyRstSave(rstData As DataTable, strTable As String)

        Dim strSQL = "SELECT * FROM " & strTable
        Using conn As New SqlConnection(GetConstr)
            Using cmdSQL As New SqlCommand(strSQL, conn)
                conn.Open()
                Dim da As New SqlDataAdapter(cmdSQL)
                Dim daU As New SqlCommandBuilder(da)
                da.Update(rstData)
            End Using
        End Using

    End Sub



    Protected Sub cmdDelete_ServerClick(sender As Object, e As EventArgs)

    End Sub

    Protected Sub GridView1_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles GridView1.RowDataBound

        If e.Row.RowType = DataControlRowType.DataRow Then

            e.Row.Attributes.Add("onclick",
                 "__doPostBack('myrowedit'," & e.Row.RowIndex & ")")

        End If

    End Sub

    Protected Sub cmdCancel_ServerClick(sender As Object, e As EventArgs)

        MyGridArea.Style.Add("display", "normal")
        EditRecord.Style.Add("display", "none")


    End Sub


End Class