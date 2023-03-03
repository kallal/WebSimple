Public Class MySetup
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click

        Dim strSQL As String = Me.TextBox1.Text

        Dim sError As String = MySqlExecute(strSQL)

        TextBox1.Text = "Sql return = (" & sError & ")"

    End Sub


    Protected Sub cmdShowCon_Click(sender As Object, e As EventArgs) Handles cmdShowCon.Click

        TextBox1.Text = GetConstr()

    End Sub

    Protected Sub cmdTestCon_Click(sender As Object, e As EventArgs) Handles cmdTestCon.Click

        Using conn = New SqlConnection(GetConstr)
            Try
                conn.Open()
                TextBox1.Text = "con open = ok"
            Catch ex As Exception
                TextBox1.Text = "con fail" & vbCrLf &
                    ex.Message
            End Try
        End Using
    End Sub


    Protected Sub cmdExecuteReturn_Click(sender As Object, e As EventArgs) Handles cmdExecuteReturn.Click

        Dim strSQL As String = TextBox1.Text
        Dim strResult As String = ""

        Using conn = New SqlConnection(GetConstr)
            Using cmdSQL As New SqlCommand(strSQL, conn)
                conn.Open()
                strResult = cmdSQL.ExecuteScalar

                TextBox1.Text &= vbCrLf & "Result" & vbCrLf &
                    strResult
            End Using
        End Using

    End Sub

    Protected Sub cmdExecuteNew_Click(sender As Object, e As EventArgs) Handles cmdExecuteNew.Click

        Dim strSQL2 As String = TextBox1.Text
        Dim cmds() As String = Split(strSQL2, "GO")

        Using conn = New SqlConnection(GetConstr)
            Using cmdSQL As New SqlCommand("", conn)
                conn.Open()
                For Each strCMD As String In cmds
                    cmdSQL.CommandText = strCMD

                    cmdSQL.ExecuteNonQuery()

                Next
            End Using
        End Using

        TextBox1.Text = "done"


    End Sub


End Class