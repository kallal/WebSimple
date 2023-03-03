Public Class WebForm2
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then
            EHotel.ShowGrid(True)
            LoadGrid()
        End If

    End Sub

    Sub LoadGrid()
        Dim cmdSQL As SqlCommand = GetMyCommand()

        Dim rstData As DataTable = MyrstP(cmdSQL)
        GridView1.DataSource = rstData
        GridView1.DataBind()

    End Sub

    Protected Sub cmdEdit_Click(sender As Object, e As EventArgs)

        Dim btn As Button = sender
        Dim gRow As GridViewRow = btn.NamingContainer
        Dim intPK As Integer = GridView1.DataKeys(gRow.RowIndex).Item("ID")

        Call EditOne(intPK)

    End Sub

    Sub EditOne(intPK As Integer)

        Me.EHotel.MyPk = intPK
        Me.EHotel.LoadData()
        Me.EHotel.MyFocusCancel()

        ScriptManager.RegisterClientScriptBlock(UpdatePanel1, UpdatePanel1.GetType,
                                            "popedit", "popedit()", True)

    End Sub


    Protected Sub EHotel_MyLoadGrid(sender As Object, e As EventArgs) Handles EHotel.MyLoadGrid

        'GridView1.DataBind()
        LoadGrid()


    End Sub

    Protected Sub cmdAdd_Click(sender As Object, e As EventArgs) Handles cmdAdd.Click

        Call EditOne(0)

    End Sub

    Protected Sub cmdReSet_ServerClick(sender As Object, e As EventArgs)

        MySqlExecute("exec MyRestore")

        GridView1.DataBind()

        MyToast(Me.Page, cmdReSet.ClientID, "Data Restored", "Data re-set back to original", "6000")


    End Sub

    Sub MyToast(my As Page, ctrlBeside As String, Heading As String,
                strText As String,
                Optional strDelay As String = "3000")

        ' same as Mytoast, but a js function called toastcall()
        ' MUST be placed on the page
        ' any master page will have this function
        ' ctrlBesite - do NOT pass # - so Button1 you pass "Button1"

        Dim strScipt As String =
            "toastcall('@ctrlBeside','@Heading','@Text','@strDelay');"

        strScipt = strScipt.Replace("@ctrlBeside", ctrlBeside)
        strScipt = strScipt.Replace("@Heading", Heading)
        strScipt = strScipt.Replace("@Text", strText)
        strScipt = strScipt.Replace("@strDelay", strDelay)


        ScriptManager.RegisterStartupScript(my, my.GetType(), "mytoast", strScipt, True)

    End Sub

    Sub MyTest1()



    End Sub

    Protected Sub cmdSearch_Click(sender As Object, e As EventArgs)

        LoadGrid()


    End Sub

    Protected Sub cmdClear_Click(sender As Object, e As EventArgs)

        txtCity.Text = ""
        txtHotel.Text = ""
        chkActiveOnly.Checked = False
        chkDescripiton.Checked = False
        LoadGrid()


    End Sub

    Private Function GetMyCommand() As SqlCommand

        Dim strSQL As String = "SELECT * FROM VtblHotelsA "
        Dim strORDER As String = " ORDER BY HotelName"
        Dim strFilter As String = ""
        Dim cmdSQL As SqlCommand = New SqlCommand()

        If txtHotel.Text <> "" Then
            strFilter = "(HotelName like '%' + @HotelName + '%')"
            cmdSQL.Parameters.Add("@HotelName", SqlDbType.NVarChar).Value = txtHotel.Text
        End If

        If txtCity.Text <> "" Then
            If strFilter <> "" Then strFilter += " AND "
            strFilter += "(City Like '%' + @City + '%') "
            cmdSQL.Parameters.Add("@City", SqlDbType.NVarChar).Value = txtCity.Text
        End If

        If chkActiveOnly.Checked Then
            If strFilter <> "" Then strFilter += " AND "
            strFilter += "(Active = 1)"
        End If

        If chkDescripiton.Checked Then
            If strFilter <> "" Then strFilter += " AND "
            strFilter += "(Description is not null)"
        End If

        If strFilter <> "" Then strSQL += " WHERE " & strFilter
        strSQL += strORDER
        cmdSQL.CommandText = strSQL
        Debug.Print(strSQL)

        Return cmdSQL
    End Function


End Class