Module General

    Public Function GetConstr() As String

        ' return conneciton string to AxisMis
        Return ConfigurationManager.ConnectionStrings("test4").ConnectionString

    End Function


    Public Function GetCon() As SqlConnection

        ' return SQL conneciton object to AxisMis

        Return New SqlConnection(ConfigurationManager.ConnectionStrings("test4").ConnectionString)

    End Function


    Public Function Myrst(strSQL As String) As DataTable

        Dim rstData As New DataTable

        Using mycon As New SqlConnection(GetConstr)

            Using cmdSQL As New SqlCommand(strSQL, mycon)
                mycon.Open()
                rstData.Load(cmdSQL.ExecuteReader)
            End Using
        End Using

        Return rstData

    End Function

    Public Function MyrstP(cmdSQL As SqlCommand) As DataTable

        Dim rstData As New DataTable

        Using mycon As New SqlConnection(GetConstr)
            Using (cmdSQL)
                cmdSQL.Connection = mycon
                mycon.Open()
                rstData.Load(cmdSQL.ExecuteReader)
            End Using
        End Using
        Return rstData
    End Function


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


    Public Function MySqlExecute(strSQL As String) As String
        ' general "easey" run sql action query (update, insert etc)

        Dim sError As String = ""
        Using conn As New SqlConnection(GetConstr)
            Using cmdSQL As New SqlCommand(strSQL, conn)
                conn.Open()
                Try
                    cmdSQL.ExecuteNonQuery()
                Catch ex As Exception
                    sError = ex.Message
                End Try
            End Using
        End Using

        Return sError

    End Function


    Public Function MySqlExcuteP(sqlCmd As SqlCommand) As Integer

        Using mycon As New SqlConnection(GetConstr)

            sqlCmd.Connection = mycon
            Dim lngReturn As Integer = 0

            Try
                sqlCmd.Connection.Open()
                lngReturn = sqlCmd.ExecuteNonQuery()
            Catch
                Debug.Print(Err.Description)
            End Try

            Return lngReturn
        End Using


    End Function

    Public Function MySqlInsert(ByVal strSQL As String) As Integer


        Dim vRet As Integer = 0
        ' pass this routine a valid sql insert command. It will do the 
        ' insert and return the PK just generated.

        ' add a second line of sql - do both the insert and the pk pull in one shot
        strSQL += ";SELECT SCOPE_IDENTITY()"

        Using conn As New SqlConnection(GetConstr)
            Using cmdSQL As New SqlCommand(strSQL, conn)
                conn.Open()
                vRet = cmdSQL.ExecuteScalar
            End Using

        End Using

        Return vRet

    End Function

    Public Function MySqlInsertP(ByVal cmdSQL As SqlCommand) As Integer

        ' pass this routine a valid sql insert command. It will do the 
        ' insert and return the PK just generated.

        ' add a second line of sql - do both the insert and the pk pull in one shot
        Dim lngPK As Integer = 0
        Using conn As New SqlConnection(GetConstr)
            Using (cmdSQL)
                cmdSQL.Connection = conn
                conn.Open()
                cmdSQL.CommandText += ";SELECT SCOPE_IDENTITY()"
                lngPK = cmdSQL.ExecuteScalar

            End Using
        End Using

        Return lngPK

    End Function

    Public Sub fLoader(F As HtmlGenericControl, rst As DataRow)

        For Each c As System.Web.UI.Control In F.Controls
            Select Case c.GetType
                Case GetType(TextBox)
                    Dim ctlC As TextBox = c
                    If Not ctlC.Attributes("f") Is Nothing Then
                        If rst.Table.Columns.Contains(ctlC.Attributes("f")) Then
                            ctlC.Text = IIf(IsDBNull(rst(ctlC.Attributes("f"))), "", rst(ctlC.Attributes("f")))
                        End If
                    End If
                Case GetType(Label)
                    Dim ctlC As Label = c
                    If Not ctlC.Attributes("f") Is Nothing Then
                        If rst.Table.Columns.Contains(ctlC.Attributes("f")) Then
                            ctlC.Text = IIf(IsDBNull(rst(ctlC.Attributes("f"))), "", rst(ctlC.Attributes("f")))
                        End If
                    End If
                Case GetType(DropDownList)
                    Dim ctlC As DropDownList = c
                    If Not ctlC.Attributes("f") Is Nothing Then
                        If rst.Table.Columns.Contains(ctlC.Attributes("f")) Then
                            ctlC.Text = IIf(IsDBNull(rst(ctlC.Attributes("f"))), "", rst(ctlC.Attributes("f")))
                            'ctlC.SelectedValue = IIf(IsDBNull(rst(ctlC.Attributes("f"))), "", rst(ctlC.Attributes("f")))
                        End If
                    End If
                Case GetType(CheckBox)
                    Dim ctlC As CheckBox = c
                    If Not ctlC.Attributes("f") Is Nothing Then
                        If rst.Table.Columns.Contains(ctlC.Attributes("f")) Then
                            ctlC.Checked = IIf(IsDBNull(rst(ctlC.Attributes("f"))), False, rst(ctlC.Attributes("f")))
                        End If
                    End If
                Case GetType(RadioButtonList)
                    Dim ctlC As RadioButtonList = c
                    If Not ctlC.Attributes("f") Is Nothing Then
                        If rst.Table.Columns.Contains(ctlC.Attributes("f")) Then
                            ctlC.SelectedValue = rst(ctlC.Attributes("f"))
                        End If
                    End If
            End Select
        Next

    End Sub

    Public Sub fclear(F As HtmlGenericControl)

        For Each c As System.Web.UI.Control In F.Controls
            Select Case c.GetType
                Case GetType(TextBox)
                    Dim ctlC As TextBox = c
                    If Not ctlC.Attributes("f") Is Nothing Then
                        ctlC.Text = ""
                    End If
                Case GetType(Label)
                    Dim ctlC As Label = c
                    If Not ctlC.Attributes("f") Is Nothing Then
                        ctlC.Text = ""
                    End If

                Case GetType(DropDownList)
                    Dim ctlC As DropDownList = c
                    If Not ctlC.Attributes("f") Is Nothing Then
                        ctlC.Text = ""
                        ctlC.SelectedItem.Text = ""
                        ctlC.SelectedItem.Value = ""
                    End If
                Case GetType(CheckBox)
                    Dim ctlC As CheckBox = c
                    If Not ctlC.Attributes("f") Is Nothing Then
                        ctlC.Checked = False
                    End If
                Case GetType(RadioButtonList)
                    Dim ctlC As RadioButtonList = c
                    If Not ctlC.Attributes("f") Is Nothing Then
                        ctlC.SelectedValue = -1
                    End If
            End Select
        Next

    End Sub



    Public Sub fWriter(f As HtmlGenericControl,
                       fPK As Integer, strTable As String,
                       Optional strCon As String = "")

        If strCon = "" Then strCon = My.Settings.TEST4
        ' opposte of fLoader - write a data form to table 
        Dim rstData As New DataTable
        Dim strSQL = "SELECT * FROM " & strTable & " WHERE ID = " & fPK
        Dim cmdSQL As New SqlCommand(strSQL)

        Using conn As New SqlConnection(strCon)
            cmdSQL.Connection = conn
            Using cmdSQL
                conn.Open()
                rstData.Load(cmdSQL.ExecuteReader)
            End Using
        End Using

        Dim rst As DataRow = rstData.Rows(0)

        ' send conrols to this one data row

        For Each c As System.Web.UI.Control In f.Controls
            Select Case c.GetType
                Case GetType(TextBox)
                    Dim ctlC As TextBox = c
                    If Not ctlC.Attributes("f") Is Nothing Then
                        If rst.Table.Columns.Contains(ctlC.Attributes("f")) Then
                            rst(ctlC.Attributes("f")) = IIf(ctlC.Text = "", DBNull.Value, ctlC.Text)
                        End If
                    End If
                Case GetType(Label)
                    Dim ctlC As Label = c
                    If Not ctlC.Attributes("f") Is Nothing Then
                        If rst.Table.Columns.Contains(ctlC.Attributes("f")) Then
                            rst(ctlC.Attributes("f")) = IIf(ctlC.Text = "", DBNull.Value, ctlC.Text)
                        End If
                    End If
                Case GetType(DropDownList)
                    Dim ctlC As DropDownList = c
                    If Not ctlC.Attributes("f") Is Nothing Then
                        If rst.Table.Columns.Contains(ctlC.Attributes("f")) Then
                            rst(ctlC.Attributes("f")) = IIf(ctlC.Text = "", DBNull.Value, ctlC.SelectedValue)
                        End If
                    End If
                Case GetType(CheckBox)
                    Dim ctlC As CheckBox = c
                    If Not ctlC.Attributes("f") Is Nothing Then
                        If rst.Table.Columns.Contains(ctlC.Attributes("f")) Then
                            rst(ctlC.Attributes("f")) = ctlC.Checked
                        End If
                    End If

                Case GetType(RadioButtonList)
                    Dim ctlC As RadioButtonList = c
                    If Not ctlC.Attributes("f") Is Nothing Then
                        If rst.Table.Columns.Contains(ctlC.Attributes("f")) Then
                            rst(ctlC.Attributes("f")) = ctlC.SelectedValue
                        End If
                    End If
            End Select
        Next

        ' data row is filled, write out changes
        Using conn As New SqlConnection(strCon)
            Using cmdSQL
                cmdSQL.Connection = conn
                conn.Open()
                Dim da As New SqlDataAdapter(cmdSQL)
                Dim daU As New SqlCommandBuilder(da)
                da.Update(rstData)
            End Using
        End Using

    End Sub


    Public Sub fWriterW(f As HtmlGenericControl, rst As DataRow)

        For Each c As System.Web.UI.Control In f.Controls
            Select Case c.GetType
                Case GetType(TextBox)
                    Dim ctlC As TextBox = c
                    If Not ctlC.Attributes("f") Is Nothing Then
                        If rst.Table.Columns.Contains(ctlC.Attributes("f")) Then
                            rst(ctlC.Attributes("f")) = IIf(ctlC.Text = "", DBNull.Value, ctlC.Text)
                        End If
                    End If
                Case GetType(Label)
                    Dim ctlC As Label = c
                    If Not ctlC.Attributes("f") Is Nothing Then
                        If rst.Table.Columns.Contains(ctlC.Attributes("f")) Then
                            rst(ctlC.Attributes("f")) = IIf(ctlC.Text = "", DBNull.Value, ctlC.Text)
                        End If
                    End If
                Case GetType(DropDownList)
                    Dim ctlC As DropDownList = c
                    If Not ctlC.Attributes("f") Is Nothing Then
                        If rst.Table.Columns.Contains(ctlC.Attributes("f")) Then
                            rst(ctlC.Attributes("f")) = IIf(ctlC.Text = "", DBNull.Value, ctlC.SelectedValue)
                        End If
                    End If
                Case GetType(CheckBox)
                    Dim ctlC As CheckBox = c
                    If Not ctlC.Attributes("f") Is Nothing Then
                        If rst.Table.Columns.Contains(ctlC.Attributes("f")) Then
                            rst(ctlC.Attributes("f")) = ctlC.Checked
                        End If
                    End If

                Case GetType(RadioButtonList)
                    Dim ctlC As RadioButtonList = c
                    If Not ctlC.Attributes("f") Is Nothing Then
                        If rst.Table.Columns.Contains(ctlC.Attributes("f")) Then
                            rst(ctlC.Attributes("f")) = ctlC.SelectedValue
                        End If
                    End If


            End Select
        Next

    End Sub

    Public Function GetControl(MyPage As ControlCollection, strC As String) As Control

        For Each c As Control In MyPage
            If c.ID = strC Then
                Return c
            End If

            If c.HasControls Then
                Dim c2 As Control = GetControl(c.Controls, strC)
                If c2 IsNot Nothing Then
                    Return c2
                End If
            End If
        Next

        Return Nothing

    End Function

End Module
