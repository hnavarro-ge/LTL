Imports Microsoft.VisualBasic
Imports System.IO
Imports BOP.OTM

Public Module Utils
    Dim fileReader As StreamReader
    Public Function AlreadyModified(ships As List(Of SHIP_UNIT), OTM_USER As String) As Boolean
        AlreadyModified = False
        If ships.Count > 0 Then
            Return ships.ElementAt(0).INSERT_USER = OTM_USER
        End If
    End Function
End Module
