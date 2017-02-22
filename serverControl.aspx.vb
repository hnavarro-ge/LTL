Imports System.Web.Services
Imports BOP
Imports BOP.SSO
Partial Class serverControl
    Inherits System.Web.UI.Page

    Dim users_ As New Users()

    Dim _OPTION As String

    Dim userSSO As String
    Dim site_name As String
    Dim id_production_line As String
    Dim typeRender As String
    Dim tableName As String
    Dim stringArray As String
    Dim start_date As String
    Dim end_date As String
    Dim mySSO As SSOInfo

    Protected Sub Page_Error(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Error
        Dim ObjEmail As New BOP.Email()
        Dim errorMessage As String

        errorMessage = "REQUEST :</br>" + Request.FilePath + " </br></br>"
        errorMessage += "OPTION :</br>" + _OPTION + " </br></br>"
        errorMessage += "REMOTE_USER :</br>" + Request.ServerVariables.Get("REMOTE_USER") + " </br></br>"
        errorMessage += "ERROR  :</br>" + Server.GetLastError.ToString() + " </br></br>"

        'ObjEmail.sendEmailError(errorMessage)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            _REQUEST()
            If _OPTION = "getUserInfo" Then getUserInfo()
        End If
    End Sub

    Sub _REQUEST()
        _OPTION = Request("option")

        id_production_line = Request("id_production_line")
        site_name = Request("site_name")
        typeRender = Request("typeRender")
        tableName = Request("table_name")
        stringArray = Request("stringArray")
        start_date = Request("start_date")
        end_date = Request("end_date")

        Try
            userSSO = Right(My.User.Name, 9)
        Catch ex As Exception
            userSSO = "00000000"
        End Try

    End Sub

    Sub getUserInfo()
        'users_.loadUserInfo(userSSO)
        'Response.Write(users_.getLastQueryInArrayString)
        mySSO = New SSOInfo(userSSO)
        Response.Write(mySSO.ToStringRepresentation)
    End Sub
End Class
