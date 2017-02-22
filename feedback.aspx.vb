Imports BOP.SSO

Partial Class feedback
    Inherits System.Web.UI.Page
    Private mySSO As SSOInfo
    Private Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not IsPostBack Then
            mySSO = New SSOInfo(My.User.Name)
            userimage.ImageUrl = mySSO.URL_PICTURE
            btnUser.Text = mySSO.DiplayName
        End If
    End Sub

End Class
