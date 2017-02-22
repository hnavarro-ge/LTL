Imports BOP.SSO
Imports BOP.OTM

Partial Class PalletsCrud
    Inherits System.Web.UI.Page

    Private mySSO As SSOInfo
    Private mySite As Site

    Private Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not IsPostBack Then
            mySSO = New SSOInfo(My.User.Name)
            'TODO: Change from testing...
            'userimage.ImageUrl = mySSO.URL_PICTURE
            'btnUser.Text = mySSO.DiplayName
            ' Testing/Documentation only
            userimage.ImageUrl = "http://localhost:24996/images/no-image.png"
            btnUser.Text = "Your Name (GE HelthCare)"
            trButton.Visible = False
            ddlSites.DataSource = BOP.OTM.Site.GetAllSites(MapPath("~/"), True)
            ddlSites.DataBind()
            ddlSites.SelectedIndex = 0
        End If
    End Sub
    Private Sub btnAdd_Click(sender As Object, e As EventArgs) Handles btnAdd.Click
        gvPallets.EditIndex = 0
        FillGrid(True)
    End Sub
    Private Sub FillGrid(Optional ForEdit As Boolean = False)
        trButton.Visible = False
        gvPallets.DataSource = Nothing
        If ddlSites.SelectedIndex > 0 Then
            mySite = New Site(ddlSites.SelectedValue, MapPath("~/"))
            lblName.Text = mySite.Name
            If ddlSystems.SelectedIndex > 0 Then
                Select Case ddlSystems.SelectedItem.Text
                    Case "Metric"
                        gvPallets.DataSource = PALLET.GetPalletsPerSiteUnitSystem(ddlSites.SelectedValue, UnitSystem.Metric, MapPath("~/"), ForEdit)
                        trButton.Visible = True
                    Case "English"
                        gvPallets.DataSource = PALLET.GetPalletsPerSiteUnitSystem(ddlSites.SelectedValue, UnitSystem.English, MapPath("~/"), ForEdit)
                        trButton.Visible = True
                End Select
            End If
        End If
        gvPallets.DataBind()
    End Sub
    Private Sub gvPallets_PreRender(sender As Object, e As EventArgs) Handles gvPallets.PreRender
        Try
            gvPallets.HeaderRow.TableSection = TableRowSection.TableHeader
        Catch ex As Exception
        End Try
    End Sub
    Protected Function FillUOMLen() As List(Of UOM)
        Select Case ddlSystems.SelectedItem.Text
            Case "Metric"
                Return UOM.LIST_BY_UNIT_SYSTEM(UOM.UOM_Type.LENGTH, UnitSystem.Metric, True)
            Case "English"
                Return UOM.LIST_BY_UNIT_SYSTEM(UOM.UOM_Type.LENGTH, UnitSystem.English, True)
            Case Else
                Return Nothing
        End Select
    End Function
    Private Sub gvPallets_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvPallets.RowCommand
        gvPallets.EditIndex = -1
        Select Case e.CommandName
            Case "Save"
                Dim system As UnitSystem = IIf(ddlSystems.SelectedIndex = 1, UnitSystem.Metric, UnitSystem.English)
                Dim gr As GridViewRow = e.CommandSource.NamingContainer
                Dim txtWidth As TextBox = gr.Cells(2).FindControl("txtWidth")
                Dim txtLength As TextBox = gr.Cells(3).FindControl("txtLength")
                Dim ddlUOM As DropDownList = gr.Cells(3).FindControl("ddlUOM")
                PALLET.InsertPallet(ddlSites.SelectedValue, system, MapPath("~/"), Decimal.Parse(txtWidth.Text), ddlUOM.SelectedValue, Decimal.Parse(txtLength.Text), ddlUOM.SelectedValue)
            Case "Remove"
                Dim system As UnitSystem = IIf(ddlSystems.SelectedIndex = 1, UnitSystem.Metric, UnitSystem.English)
                Dim gr As GridViewRow = e.CommandSource.NamingContainer
                Dim lblGID As Label = gr.Cells(1).FindControl("lblGID")
                PALLET.RemovePallet(ddlSites.SelectedValue, system, lblGID.Text, MapPath("~/"))
        End Select
        FillGrid(False)
    End Sub

    Public Sub SiteSelected(sender As Object, e As EventArgs)
        FillGrid()
    End Sub
End Class
