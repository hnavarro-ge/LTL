<%@ Page Language="VB" AutoEventWireup="false" CodeFile="PalletsCrud.aspx.vb" Inherits="PalletsCrud" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>OTM Mobile</title>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="shortcut icon" href="~/images/otm.png" />

    <link href="css/iids-blessed1.css" rel="stylesheet" />
    <link href="css/iids.css" rel="stylesheet" />
    <link href="css/font-awesome.min.css" rel="stylesheet" />
    <link href="css/declarative-visualizations.css" rel="stylesheet" />
    <link href="css/datepicker.css" rel="stylesheet" />

    <script src="js/plugins/jquery-1.11.3.min.js"></script>
    <script src="js/plugins/bootstrap.min.js"></script>
    <script src="js/plugins/datepicker.js"></script>
    <script src="js/plugins/cookies.js"></script>
    <script src="js/plugins/jquery-ui-1.10.2.custom.min.js"></script>
    <script src="js/table.js"></script>

    <style type="text/css">
        body {
            margin: 0;
            padding: 0;
            font-family: Arial;
        }

        .modal {
            position: fixed;
            z-index: 999;
            height: 100%;
            width: 100%;
            top: 0;
            background-color: Black;
            filter: alpha(opacity=60);
            opacity: 0.6;
            -moz-opacity: 0.8;
        }

        .center {
            position: fixed;
            z-index: 1000;
            margin: -35px 400px;
            padding: 10px;
            width: 23px;
            height: 23px;
            border-radius: 10px;
            filter: alpha(opacity=100);
            opacity: 1;
        }

            .center img {
                height: 50px;
                width: 50px;
            }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <nav class="navbar  navbar-default" role="navigation">
            <div class="container">
                <div class="navbar-header">
                    <a class="navbar-brand">
                        <span class="ge-logo"></span>
                        <span>OTM Mobile <small>GE Healthcare</small></span>
                    </a>
                </div>
                <div class="pull-right">
                    <asp:Image ID="userimage" runat="server" CssClass="img-circle" Style="float: left; height: 48px; margin: 5px; margin-bottom: 0px;" />
                    <div class="btn-toolbar pull-left">
                        <div class="btn-group">
                            <asp:Button ID="btnUser" runat="server" CssClass="btn btn-inverse" Text="User Logged" Style="color: #eee" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="primary-navbar nav-collapse">
                <div class="container">
                    <ul class="nav navbar-nav">
                        <li class="inactive"><a href="Default.aspx">Shipments</a></li>
                        <li class="active"><a href="PalletsCrud.aspx">Org Setup</a></li>
                    </ul>
                    <div class="pull-right">
                        <ul class="nav navbar-nav">
                            <li class="inactive"><a href="~/help/help.aspx" target="_blank">Help</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </nav>
        <asp:HiddenField ID="hfSystem" runat="server" />
        <div class="container content">
            <asp:Table ID="Table1" runat="server" CellPadding="5" CellSpacing="5" HorizontalAlign="Left">
                <asp:TableRow>
                    <asp:TableCell HorizontalAlign="Right">Select Site:</asp:TableCell>
                    <asp:TableCell>
                        <asp:DropDownList ID="ddlSites" runat="server" Width="300px" AutoPostBack="true" OnSelectedIndexChanged="SiteSelected" DataTextField="ORGANIZATION_NAME" DataValueField="ORGANIZATION_CODE">
                        </asp:DropDownList>
                        <asp:Label ID="lblName" runat="server"></asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell HorizontalAlign="Right">Select Unit System:</asp:TableCell>
                    <asp:TableCell>
                        <asp:DropDownList ID="ddlSystems" runat="server" Width="150px" AutoPostBack="true" OnSelectedIndexChanged="SiteSelected">
                            <asp:ListItem Value="0">Select</asp:ListItem>
                            <asp:ListItem Value="1">Metric</asp:ListItem>
                            <asp:ListItem Value="2">English</asp:ListItem>
                        </asp:DropDownList>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow runat="server" ID="trButton">
                    <asp:TableCell HorizontalAlign="Left">
                        <asp:Label ID="Label6" runat="server" Font-Bold="true">Pallet Sizes:</asp:Label>
                    </asp:TableCell>
                    <asp:TableCell HorizontalAlign="Right">
                        <asp:Button ID="btnAdd" runat="server" Text="Add Pallet Size" CssClass="btn btn-info" />
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell ColumnSpan="2">
                        <asp:GridView ID="gvPallets" runat="server" EmptyDataText="No pallet sizes to show on this screen, please select an unit system." DataKeyNames="PalletGID" AutoGenerateColumns="False" CssClass="table table-hover table-striped table-bordered" GridLines="Both" UseAccessibleHeader="true">
                            <HeaderStyle BackColor="Black" ForeColor="White" />
                            <AlternatingRowStyle BackColor="#d4d4d4" />
                            <Columns>
                                <asp:TemplateField HeaderText="PALLET SIZE (WxL)">
                                    <ItemTemplate>
                                        <asp:Label ID="lblGID" runat="server" Text='<%# Eval("PalletGID") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:Label ID="lblGID" runat="server" Text='Enter Width, Length and UOM ==>'></asp:Label>
                                    </EditItemTemplate>
                                    <ItemStyle CssClass="align-center" Width="150px" />
                                    <HeaderStyle CssClass="align-center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="  WIDTH">
                                    <ItemTemplate>
                                        <asp:Label ID="lblWidth" runat="server" Text='<%# Eval("Width", "{0:n4}") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtWidth" runat="server" Width="80px" Text='<%# Bind("Width") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <HeaderStyle CssClass="align-right" />
                                    <ItemStyle Width="80px" HorizontalAlign="Right" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="  LENGTH">
                                    <ItemTemplate>
                                        <asp:Label ID="lblLength" runat="server" Text='<%# Eval("Length", "{0:n4}") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtLength" runat="server" Width="80px" Text='<%# Bind("Length") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <HeaderStyle CssClass="align-right" />
                                    <ItemStyle Width="80px" HorizontalAlign="Right" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="UOM">
                                    <ItemTemplate>
                                        <asp:Label ID="lblUOM" runat="server" Text='<%# Eval("WidthUOM") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:Label ID="lblUOM" runat="server" Text='<%# Eval("WidthUOM") %>' Visible="false"></asp:Label>
                                        <asp:DropDownList ID="ddlUOM" runat="server" Width="70px" DataTextField="SHORT_DESCRIPTION" DataValueField="CODE" DataSource="<%# FillUOMLen()  %>" Value='<%# Eval("WidthUOM") %>'></asp:DropDownList>
                                    </EditItemTemplate>
                                    <HeaderStyle CssClass="align-center" />
                                    <ItemStyle Width="60px" HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="ACTION" HeaderStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Button ID="btnDelete" runat="server" Text="Remove" CausesValidation="false" CssClass="btn btn-danger" CommandName="Remove" CommandArgument='<%# Eval("PalletGID") %>' OnClientClick="return confirm('Are you sure to remove this Pallet Size? It cannot be undone!');" />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:Button ID="btnNo" runat="server" Text="Cancel" CausesValidation="false" CssClass="btn btn-danger" CommandName="Cancelar" />&nbsp;
                                        <asp:Button ID="btnYes" runat="server" Text="Update" CausesValidation="true" CssClass="btn btn-info" CommandName="Save" />
                                    </EditItemTemplate>
                                    <ItemStyle CssClass="align-center" Width="150px" VerticalAlign="Top" />
                                    <HeaderStyle CssClass="align-center" />
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </div>
        <div id="DataSources">
        </div>
    </form>
</body>
</html>
