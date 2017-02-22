Imports System.Net
Imports System.Net.Mail
Imports BOP.SSO
Imports BOP.OTM

Partial Class _Default
    Inherits System.Web.UI.Page

    Private mySSO As SSOInfo
    Private siteDefaults As Defaults
    Private _order As ORDER_RELEASE
    Private _plt As PALLET
    Private _transmission As TRANSMISSION
    Private _script, _transNumber, _transMsg As String
    Private _adding As Boolean
    Private _log As Log
    Private _env As Environment

    Private Sub _Default_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not IsPostBack Then
            mySSO = New SSOInfo(My.User.Name)
            'TODO: Change from testing...
            userimage.ImageUrl = mySSO.URL_PICTURE
            btnUser.Text = mySSO.DiplayName
            If Not Session("Env") Is Nothing Then
                lblEnv.Text = Session("Env").ToString
            End If
            ' Testing/Documentation only
            'userimage.ImageUrl = "http://localhost:24996/images/no-image.png"
            'btnUser.Text = "Your Name (GE HelthCare)"
            ResetFields()
            txtOrder.Focus()
        End If
    End Sub
    Private Sub btnCancel_Click(sender As Object, e As EventArgs) Handles btnCancel.Click
        ResetFields()
        _Default_Load(Me, New EventArgs)
    End Sub
    Private Sub btnGet_Click(sender As Object, e As EventArgs) Handles btnGet.Click
        If Page.IsValid Then
            tblAddress.Visible = True
            hdAdding.Value = "False"
            _order = New ORDER_RELEASE(txtOrder.Text)
            siteDefaults = New Defaults(_order.SOURCE_LOCATION.ORGID, _order.SOURCE_LOCATION.COUNTRY_CODE, MapPath("~\"))
            Session("Defaults") = siteDefaults

            If _order.LINES Is Nothing Then
                _script = "alert('Order " & txtOrder.Text & " does not have any lines and cannot be updated with new ship units...')"
                ScriptManager.RegisterClientScriptBlock(TryCast(sender, Control), Me.GetType(), "Alert", _script, True)
                ResetFields()
                _Default_Load(Me, New EventArgs)
                Exit Sub
            End If
            If Not _order.EDITABLE Then
                btnAdd.Enabled = False
                btnClear.Enabled = False
                btnAdd.CssClass = "btn btn-default"
                btnClear.CssClass = "btn btn-default"
                _script = "alert('Order " & txtOrder.Text & " cannot be updated due to status...')"
                ScriptManager.RegisterClientScriptBlock(TryCast(sender, Control), Me.GetType(), "Alert", _script, True)
            End If

            If Not _order.SHIP_UNITS Is Nothing AndAlso Not AlreadyModified(_order.SHIP_UNITS, OTM_USER.NAME(Session("Env"))) And _order.EDITABLE Then
                _order.SHIP_UNITS = New List(Of SHIP_UNIT)
            End If
            Session("Order") = _order
            lblOrigin.Text = _order.SOURCE_LOCATION_DESC
            lblDest.Text = _order.DEST_LOCATION_DESC
            lblStatus.Text = _order.STATUS
            fillGridView(_order)
            btnCancel.Focus()
        Else
            txtOrder.Text = ""
            txtOrder.Focus()
        End If
    End Sub
    Private Sub fillGridView(_order As ORDER_RELEASE)
        btnUpdate.Visible = _order.MODIFIED
        btnClear.Visible = False
        If Not _order.SHIP_UNITS Is Nothing Then
            If _order.SHIP_UNITS.Count > 0 Then
                gvShipUnits.DataSource = _order.SHIP_UNITS
                btnClear.Visible = True
            Else
                gvShipUnits.DataSource = Nothing
            End If
        Else
            gvShipUnits.DataSource = Nothing
        End If
        gvShipUnits.DataBind()
    End Sub
    Private Sub btnUpdate_Click(sender As Object, e As EventArgs) Handles btnUpdate.Click
        Try
            If Not Session("Order") Is Nothing Then
                _order = Session("Order")
                _order.UpdateWeightAndVolume()
                Using _transmission = New TRANSMISSION(_order)
                    _transmission.POST()
                    _transNumber = _transmission.Number
                    _transMsg = _transmission.Message
                    If _transmission.MessageType = "E" Then Throw New Exception(_transNumber & "|" & _transMsg)
                End Using
                _script = "alert('Changes Submitted successfully. Transmission No: " & _transNumber & " Message: " & _transMsg & "')"
                ScriptManager.RegisterClientScriptBlock(TryCast(sender, Control), Me.GetType(), "Alert", _script, True)
                _log = New Log(Now, Page.User.Identity.Name, _order.SOURCE_LOCATION.COUNTRY_CODE, _order.GID, _transNumber, "", MapPath("~/"))
                ResetFields()
            End If
        Catch ex As Exception
            Dim err() As String = ex.Message.Split("|")
            If err.Length > 1 Then
                _transNumber = err(0)
                _transMsg = err(1)
            Else
                _transNumber = ""
                _transMsg = ex.Message
            End If
            _script = "alert('Ups!!!... Something happened on Transmission No: " & _transNumber & " Message: " & _transMsg & "')"
            ScriptManager.RegisterClientScriptBlock(TryCast(sender, Control), Me.GetType(), "Alert", _script, True)
            _log = New Log(Now, Page.User.Identity.Name, _order.SOURCE_LOCATION.COUNTRY_CODE, _order.GID, _transNumber, _transMsg, MapPath("~/"))
            ResetFields()
        End Try
    End Sub
    Private Sub cuvOrder_ServerValidate(source As Object, args As ServerValidateEventArgs) Handles cuvOrder.ServerValidate
        args.IsValid = ORDER_RELEASE.Exists(txtOrder.Text)
    End Sub
    Private Sub ResetFields()
        Session.Remove("Order")
        btnUpdate.Visible = False
        txtOrder.Text = ""
        lblOrigin.Text = ""
        lblDest.Text = ""
        lblStatus.Text = ""
        btnAdd.Enabled = True
        btnClear.Enabled = True
        btnAdd.CssClass = "btn btn-info"
        btnClear.CssClass = "btn btn-danger"
        gvShipUnits.DataSource = Nothing
        gvShipUnits.DataBind()
        tblAddress.Visible = False
    End Sub
    Private Sub gvShipUnits_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvShipUnits.RowCommand
        Select Case e.CommandName
            Case "Modify"
                gvShipUnits.EditIndex = CType(e.CommandSource.NamingContainer, GridViewRow).RowIndex
            Case "Remove"
                _order = Session("Order")
                _order.MODIFIED = True
                _order.DelShipUnit(e.CommandArgument)
                Session("Order") = _order
                gvShipUnits.EditIndex = -1
            Case "Save"
                Update(e.CommandArgument, e.CommandSource.NamingContainer)
                gvShipUnits.EditIndex = -1
                hdAdding.Value = "False"
            Case "Cancelar"
                If hdAdding.Value = "True" Then
                    _order = Session("Order")
                    _order.DelShipUnit(e.CommandArgument)
                    Session("Order") = _order
                    hdAdding.Value = "False"
                End If
                gvShipUnits.EditIndex = -1
        End Select
        fillGridView(Session("Order"))
    End Sub
    Private Sub Update(ShipUnitGID As String, gr As GridViewRow)
        _order = Session("Order")
        Dim txtWidth As TextBox = gr.Cells(2).FindControl("txtWidth")
        Dim txtLength As TextBox = gr.Cells(2).FindControl("txtLength")
        Dim txtHeight As TextBox = gr.Cells(2).FindControl("txtHeight")
        Dim txtVolume As TextBox = gr.Cells(2).FindControl("txtVolume")
        Dim txtweight As TextBox = gr.Cells(3).FindControl("txtWeight")
        Dim ddl As DropDownList = gr.Cells(2).FindControl("ddlPallets")
        Dim ddl1 As DropDownList = gr.Cells(2).FindControl("ddlUOM1")
        Dim ddl5 As DropDownList = gr.Cells(2).FindControl("ddlUOM5")
        Dim ddl4 As DropDownList = gr.Cells(3).FindControl("ddlUOM4")
        Dim su1 As SHIP_UNIT = _order.SHIP_UNITS.Find(Function(c) c.GID = ShipUnitGID)
        With su1
            .PALLET_GID = IIf(ddl.SelectedIndex > 0, ddl.SelectedValue, String.Format("{0}{1}x{2}{3}", txtWidth.Text.Trim, ddl1.SelectedValue, txtLength.Text.Trim, ddl1.SelectedValue))
            .HEIGHT = txtHeight.Text
            .HEIGHT_UOM_CODE = ddl1.SelectedValue
            .WIDTH = txtWidth.Text
            .WIDTH_UOM_CODE = ddl1.SelectedValue
            .LENGTH = txtLength.Text
            .LENGTH_UOM_CODE = ddl1.SelectedValue
            .VOLUME = txtVolume.Text
            .VOLUME_UOM_CODE = ddl5.SelectedValue
            .UNIT_DIMENSION = String.Format("{0:#}x{1:#}x{2:#}{3}", su1.WIDTH, su1.LENGTH, su1.HEIGHT, su1.WIDTH_UOM_CODE)
        End With
        'PALLET.UpdatePallet(_order.SOURCE_LOCATION.ORGID, myDefaults.System, su1.PALLET_GID, MapPath("~/"), Decimal.Parse(txtWidth.Text), ddl1.SelectedValue, Decimal.Parse(txtLength.Text), ddl1.SelectedValue)
        _order.ModifyWeight(ShipUnitGID, txtweight.Text, ddl4.SelectedValue, txtVolume.Text, ddl5.SelectedValue)
        _order.MODIFIED = True
        Session("Order") = _order
    End Sub
    Private Sub gvShipUnits_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvShipUnits.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            If e.Row.RowState = DataControlRowState.Edit OrElse e.Row.RowState = CType(5, DataRowState) Then
                Dim ddl As DropDownList = e.Row.Cells(2).FindControl("ddlPallets")
                Dim lbl As Label = e.Row.Cells(2).FindControl("lblGID")
                Dim ddl1 As DropDownList = e.Row.Cells(2).FindControl("ddlUOM1")
                Dim lbl1 As Label = e.Row.Cells(2).FindControl("lblUOM1")
                Dim ddl4 As DropDownList = e.Row.Cells(2).FindControl("ddlUOM4")
                Dim lbl4 As Label = e.Row.Cells(3).FindControl("lblUOM4")

                Dim txtWidth As TextBox = e.Row.Cells(2).FindControl("txtWidth")
                Dim txtLength As TextBox = e.Row.Cells(2).FindControl("txtLength")
                Dim txtHeight As TextBox = e.Row.Cells(2).FindControl("txtHeight")
                Dim txtVolume As TextBox = e.Row.Cells(2).FindControl("txtVolume")
                Dim txtweight As TextBox = e.Row.Cells(3).FindControl("txtWeight")

                If lbl.Text.Length > 0 Then
                    ddl.SelectedValue = lbl.Text
                Else
                    ddl.SelectedIndex = 0
                End If
                PalletSelected(ddl, New EventArgs)
                If lbl4.Text.Length > 0 Then
                    ddl4.SelectedValue = lbl4.Text
                End If
            ElseIf e.Row.RowState = DataControlRowState.Normal OrElse e.Row.RowState = DataControlRowState.Alternate Then
                Dim btn1 As Button = e.Row.Cells(0).FindControl("btnEdit")
                Dim btn2 As Button = e.Row.Cells(0).FindControl("btnDelete")
                _order = Session("Order")
                btn1.Enabled = _order.EDITABLE
                btn2.Enabled = _order.EDITABLE
                If Not _order.EDITABLE Then
                    btn1.CssClass = "btn btn-default"
                    btn2.CssClass = "btn btn-default"
                End If
            End If
        End If
    End Sub
    Protected Sub UOM_Selected(sender As Object, e As EventArgs)
        Dim ddl1 As DropDownList = sender
        Dim gr As GridViewRow = sender.NamingContainer
        Dim ddl5 As DropDownList = gr.Cells(2).FindControl("ddlUOM5")
        ddl5.SelectedValue = UOM.GetCorrespondent(ddl1.SelectedValue)
    End Sub
    Private Sub btnAdd_Click(sender As Object, e As EventArgs) Handles btnAdd.Click
        hdAdding.Value = "True"
        _order = Session("Order")
        _order.AddShipUnit(ConfigurationManager.AppSettings("otmUserName"))
        Session("Order") = _order
        gvShipUnits.EditIndex = 0
        fillGridView(_order)
    End Sub
    Protected Sub Dimension_Changed(sender As Object, e As EventArgs)
        Dim gr As GridViewRow = sender.NamingContainer
        Dim txt1 As TextBox = gr.Cells(2).FindControl("txtWidth")
        Dim txt2 As TextBox = gr.Cells(2).FindControl("txtLength")
        Dim txt3 As TextBox = gr.Cells(2).FindControl("txtHeight")
        Dim txt4 As TextBox = gr.Cells(2).FindControl("txtVolume")
        Dim Width As Decimal = Val(txt1.Text)
        Dim Length As Decimal = Val(txt2.Text)
        Dim Height As Decimal = Val(txt3.Text)
        txt4.Text = (Width * Length * Height).ToString("n4")
    End Sub
    Protected Sub PalletSelected(sender As Object, e As EventArgs)
        Dim ddl As DropDownList = sender
        Dim gr As GridViewRow = sender.NamingContainer
        Dim txtWidth As TextBox = gr.Cells(2).FindControl("txtWidth")
        Dim txtLength As TextBox = gr.Cells(2).FindControl("txtLength")
        Dim ddl1 As DropDownList = gr.Cells(2).FindControl("ddlUOM1")
        Dim lbl1 As Label = gr.Cells(2).FindControl("lblUOM1")
        Dim ddl5 As DropDownList = gr.Cells(2).FindControl("ddlUOM5")
        _order = Session("Order")
        siteDefaults = Session("Defaults")
        If ddl.SelectedIndex > 0 Then
            _plt = New PALLET(siteDefaults.Site, siteDefaults.System, ddl.SelectedValue, MapPath("~/"))
            txtWidth.Text = _plt.Width.ToString
            txtWidth.Enabled = False
            txtLength.Text = _plt.Length.ToString
            txtLength.Enabled = False
            Dimension_Changed(txtWidth, New EventArgs)
            ddl1.SelectedValue = _plt.Width_UOM
            ddl1.Enabled = False
            ddl5.SelectedValue = UOM.GetCorrespondent(_plt.Width_UOM)
            ddl5.Enabled = False
        Else
            txtWidth.Enabled = True
            txtLength.Enabled = True
            ddl1.Enabled = True
            ddl1.SelectedIndex = 0
            If lbl1.Text.Length > 0 Then
                ddl1.SelectedValue = lbl1.Text
                ddl5.SelectedValue = UOM.GetCorrespondent(lbl1.Text)
            End If
        End If
    End Sub
    Protected Function FillUOMLen() As List(Of UOM)
        siteDefaults = Session("Defaults")
        Return UOM.LIST_BY_UNIT_SYSTEM(UOM.UOM_Type.LENGTH, siteDefaults.System, True)
    End Function
    Protected Function FillUOMWgt() As List(Of UOM)
        siteDefaults = Session("Defaults")
        Return UOM.LIST_BY_UNIT_SYSTEM(UOM.UOM_Type.WEIGHT, siteDefaults.System, True)
    End Function
    Protected Function FillUOMVol() As List(Of UOM)
        siteDefaults = Session("Defaults")
        Return UOM.LIST_BY_UNIT_SYSTEM(UOM.UOM_Type.VOLUME, siteDefaults.System, True)
    End Function
    Protected Function fillPallets() As OTMDataSet.dtPalletsDataTable
        _order = Session("Order")
        siteDefaults = Session("Defaults")
        Return PALLET.GetPalletsPerSiteUnitSystem(siteDefaults.Site, siteDefaults.System, MapPath("~/"), True)
    End Function
    Private Sub gvShipUnits_PreRender(sender As Object, e As EventArgs) Handles gvShipUnits.PreRender
        Try
            gvShipUnits.HeaderRow.TableSection = TableRowSection.TableHeader
        Catch ex As Exception
        End Try
    End Sub
    Private Sub btnClear_Click(sender As Object, e As EventArgs) Handles btnClear.Click
        _order = Session("Order")
        _order.SHIP_UNITS = New List(Of SHIP_UNIT)
        Session("Order") = _order
        fillGridView(_order)
    End Sub

    Private Sub _Default_Init(sender As Object, e As EventArgs) Handles Me.Init
        _env = CType(ConfigurationManager.AppSettings("Env"), Environment)
        Session("Env") = _env
    End Sub
End Class
