
Public Class MyEditHotelC
    Inherits System.Web.UI.UserControl

    Private _MyPk As String = ""

    Public Property MyTable As String = ""

    Public Property TriggerLoadGrid As Boolean = False

    Public Property MyTitle As String = ""

    Public Event MyLoadGrid As EventHandler

    Public Property MyGridArea As String = ""
    Public Property MyEditArea As String = ""

    Public Property MyPk As String
        Get
            _MyPk = ViewState(Me.ID + "_MyPk")
            Return _MyPk
        End Get
        Set(value As String)
            _MyPk = value
            ViewState(Me.ID + "_MyPk") = _MyPk
            Debug.Print("ID = " & Me.ID)
        End Set
    End Property

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Debug.Print($"UC page load event = PostBack = {IsPostBack}")

        If Not IsPostBack Then

            Me.EditRecord.Style.Add("display", "none")

        End If

    End Sub



    Public Sub LoadData()


        Dim strSQL As String = "SELECT * FROM " & Me.MyTable & " WHERE ID = " & Me.MyPk
        Dim rstData = Myrst(strSQL)

        If MyPk = 0 Then
            AddNewRow(rstData)      ' add blank row to edit (add mode!)
        End If

        Dim rstCity As DataTable
        rstCity = Myrst("SELECT ID, City FROM tblCity ORDER BY City")
        cboCity.DataSource = rstCity
        cboCity.DataBind()
        cboCity.Items.Insert(0, New ListItem("Select", "")) ' add blank "select"

        Call fLoader(Me.EditRecord, rstData.Rows(0))

        ' load multi value select box list
        chkOptions.DataSource = Myrst("select ID, HotelOption FROM tblOptions")
        chkOptions.DataBind()
        'chkOptions.ClearSelection()         ' clear all selections
        strSQL = "SELECT * FROM tblHotelOptions WHERE tblHotelsA_ID = " & MyPk
        Dim rstOptions As DataTable = Myrst(strSQL)
        For Each OneRow As DataRow In rstOptions.Rows
            chkOptions.Items.FindByValue(OneRow("tblOptions_ID")).Selected = True
        Next

    End Sub

    Sub AddNewRow(rstData As DataTable)

        Dim MyNewRow As DataRow = rstData.NewRow
        MyNewRow("Active") = True

        MyNewRow("Province") = "AB"
        rstData.Rows.Add(MyNewRow)

    End Sub

    Public Sub MyFocusCancel()

        cmdCancel.Focus()

    End Sub


    Protected Sub cmdSave_ServerClick(sender As Object, e As EventArgs)

        Dim strSQL As String = "SELECT * FROM " & Me.MyTable & " WHERE ID = " & MyPk
        Dim rstData As DataTable = Myrst(strSQL)

        If rstData.Rows.Count = 0 Then
            ' is a new row
            AddNewRow(rstData)
        End If

        Call fWriterW(EditRecord, rstData.Rows(0))
        Call MyRstSave(rstData, "tblHotelsA")


        ' now write out child table for hotel options
        strSQL = "SELECT * FROM tblHotelOptions WHERE tblHotelsA_ID = " & MyPk
        Dim rstOptions As DataTable = Myrst(strSQL)
        ' delete all existing
        For Each OneRow As DataRow In rstOptions.Rows
            OneRow.Delete()
        Next

        For Each chkItem As ListItem In chkOptions.Items
            If chkItem.Selected Then
                Dim NewRow As DataRow = rstOptions.NewRow
                NewRow("tblHotelsA_ID") = MyPk
                NewRow("tblOptions_ID") = chkItem.Value
                rstOptions.Rows.Add(NewRow)
            End If
        Next
        Call MyRstSave(rstOptions, "tblHotelOptions")


        RaiseEvent MyLoadGrid(Me, e)

    End Sub



    'Protected Sub cmdCancel_ServerClick(sender As Object, e As EventArgs)

    '    ShowGrid(True)


    'End Sub

    Sub ShowGrid(bolYes As Boolean)

        'Dim gArea As HtmlControl = Page.FindControl(Me.MyGridArea)
        'Dim eArea As HtmlControl = Page.Master.FindControl(Me.MyEditArea)

        Dim gArea As HtmlControl = GetControl(Page.Controls, Me.MyGridArea)
        Dim eArea As HtmlControl = GetControl(Page.Controls, Me.MyEditArea)

        If bolYes Then
            gArea.Style.Add("display", "normal")
            eArea.Style.Add("display", "none")
        Else
            gArea.Style.Add("display", "none")
            eArea.Style.Add("display", "normal")
        End If


    End Sub

    Protected Sub cmdDelete_ServerClick(sender As Object, e As EventArgs)

        Dim cmdSQL As New SqlCommand("DELETE FROM tblHotelsA  WHERE ID = @ID")
        cmdSQL.Parameters.Add("@ID", SqlDbType.Int).Value = MyPk
        MySqlExcuteP(cmdSQL)

        RaiseEvent MyLoadGrid(Me, e)


    End Sub

    Public Sub PopEdit(UpP As UpdatePanel)

        '' don't hide/show grid, but pop this as a dialog

        ScriptManager.RegisterClientScriptBlock(UpP, UpP.GetType, "popedit", "popedit()", True)


    End Sub


End Class