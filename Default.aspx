<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="_Default" %>

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
    <form id="Form1" runat="server">
<%--        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>--%>
                <nav class="navbar  navbar-default" role="navigation">
                    <div class="container">
                        <div class="navbar-header">
                            <a class="navbar-brand">
                                <span class="ge-logo"></span>
                                <span>OTM Mobile <asp:Label ID="lblEnv" runat="server"></asp:Label><small>GE Healthcare</small></span>
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
                                <li class="active"><a href="Default.aspx">Shipments</a></li>
                                <li class="inactive"><a href="PalletsCrud.aspx">Org Setup</a></li>
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
                    <asp:Table ID="Table1" runat="server" Width="100%" HorizontalAlign="Center">
                        <asp:TableRow>
                            <asp:TableCell>
                                <asp:Table ID="tblScreen" runat="server" CellPadding="5" CellSpacing="5">
                                    <asp:TableRow runat="server" VerticalAlign="Top">
                                        <asp:TableCell HorizontalAlign="Right" VerticalAlign="Top">
                                            <asp:Label ID="Label1" runat="server" Text="Delivery - Order Release: " Width="200px" Height="23px" BackColor="White"></asp:Label>
                                        </asp:TableCell>
                                        <asp:TableCell VerticalAlign="Top">
                                            <asp:TextBox ID="txtOrder" runat="server" Width="200px" TabIndex="0"></asp:TextBox><br />
                                            <asp:RequiredFieldValidator ID="rfvOrder" runat="server" ErrorMessage="Delivery not provided!!" ControlToValidate="txtOrder" Display="Dynamic"></asp:RequiredFieldValidator>
                                            <asp:CustomValidator ID="cuvOrder" runat="server" ErrorMessage="Delivery not found!" ControlToValidate="txtOrder" Display="Dynamic" ValidationGroup="Order" Visible="False"></asp:CustomValidator>
                                        </asp:TableCell>
                                        <asp:TableCell VerticalAlign="Top">
                                            <asp:Button ID="btnGet" runat="server" Text="Get" CssClass="btn btn-info" CausesValidation="true" ValidationGroup="Order" Height="23px" Width="50px" TabIndex="1" />
                                        </asp:TableCell>
                                        <asp:TableCell Width="100px"></asp:TableCell>
                                        <asp:TableCell>
                                            <asp:Label ID="Label3" runat="server" Text="Status: " Width="50px" Height="23px" BackColor="White"></asp:Label>
                                            <asp:Label ID="lblStatus" runat="server" Text="" Width="300px" BackColor="White" ForeColor="Red"></asp:Label></asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow><asp:TableCell ColumnSpan="3"> </asp:TableCell></asp:TableRow>
                                </asp:Table>
                                <asp:Table ID="tblAddress" runat="server" CellPadding="5" CellSpacing="5">
                                    <asp:TableRow>
                                        <asp:TableCell>
                                            <asp:Label ID="Label2" runat="server" Text="Origin: " Width="100px" BackColor="White"></asp:Label>
                                        </asp:TableCell>
                                        <asp:TableCell></asp:TableCell>
                                        <asp:TableCell>
                                            <asp:Label ID="Label5" runat="server" Text="Destination: " Width="100px" BackColor="White"></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>
                                            <asp:Label ID="lblOrigin" runat="server" Width="300px" BackColor="White" ForeColor="Red"></asp:Label>
                                        </asp:TableCell>
                                        <asp:TableCell></asp:TableCell>
                                        <asp:TableCell>
                                            <asp:Label ID="lblDest" runat="server" Width="300px" BackColor="White" ForeColor="Red"></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell ColumnSpan="3">&nbsp;</asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow runat="server">
                                        <asp:TableCell HorizontalAlign="Left">
                                            <asp:Label ID="Label6" runat="server" Font-Bold="true">Ship Units:</asp:Label>
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="Center">
                                            <asp:Button ID="btnClear" runat="server" Text="Clear All SU" CssClass="btn btn-danger" OnClientClick="return confirm('This will remove all Ship Units on the order and cannot be undone!!... Are you sure');" />
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="Right">
                                            <asp:Button ID="btnAdd" runat="server" Text="Add Ship Unit" CssClass="btn btn-info" />
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow runat="server">
                                        <asp:TableCell ColumnSpan="3" HorizontalAlign="center">
                                            <asp:GridView ID="gvShipUnits" runat="server" EmptyDataText="No ship units to show on this order, please add one." DataKeyNames="XID" AutoGenerateColumns="False" CssClass="table table-hover table-striped" GridLines="None" UseAccessibleHeader="true">
                                                <HeaderStyle BackColor="Black" ForeColor="White" />
                                                <AlternatingRowStyle BackColor="#d4d4d4" />
                                                <Columns>
                                                    <asp:TemplateField HeaderText="SHIP UNIT" HeaderStyle-CssClass="align-center">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblXID" runat="server" Text='<%# Eval("XID") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <asp:Label ID="lblXID" runat="server" Text='<%# Eval("XID") %>'></asp:Label>
                                                        </EditItemTemplate>
                                                        <ItemStyle CssClass="align-left" Width="150px" VerticalAlign="Top" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="DIMENSION (WxLxH)" HeaderStyle-CssClass="align-center">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblGID" runat="server" Text='<%# Eval("UNIT_DIMENSION") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <asp:Table ID="Table2" runat="server" Width="200px">
                                                                <asp:TableRow>
                                                                    <asp:TableCell ColumnSpan="4">Select pallet size or enter dimensions:</asp:TableCell>
                                                                </asp:TableRow>
                                                                <asp:TableRow>
                                                                    <asp:TableCell ColumnSpan="2">
                                                                        <asp:Label ID="lblGID" runat="server" Text='<%# Eval("PALLET_GID") %>' Visible="false"></asp:Label>
                                                                        <asp:DropDownList ID="ddlPallets" runat="server" Width="150px" DataTextField="PALLETGID" DataValueField="PALLETGID" DataSource='<%# fillPallets() %>' OnSelectedIndexChanged="PalletSelected" AutoPostBack="true"></asp:DropDownList><br />
                                                                    </asp:TableCell>
                                                                    <asp:TableCell>UOM:</asp:TableCell>
                                                                    <asp:TableCell>
                                                                        <asp:Label ID="lblUOM1" runat="server" Text='<%# Eval("WIDTH_UOM_CODE") %>' Visible="false"></asp:Label>
                                                                        <asp:DropDownList ID="ddlUOM1" runat="server" Width="70px" DataTextField="SHORT_DESCRIPTION" DataValueField="CODE" DataSource="<%# FillUOMLen()  %>" OnSelectedIndexChanged="UOM_Selected" AutoPostBack="true"></asp:DropDownList>
                                                                    </asp:TableCell>
                                                                </asp:TableRow>
                                                                <asp:TableRow>
                                                                    <asp:TableCell>WIDTH:</asp:TableCell>
                                                                    <asp:TableCell ColumnSpan="3">
                                                                        <asp:TextBox ID="txtWidth" runat="server" Text='<%# Eval("WIDTH") %>' OnTextChanged="Dimension_Changed" AutoPostBack="true">
                                                                        </asp:TextBox>
                                                                        <asp:RangeValidator ID="valWidth" runat="server" ControlToValidate="txtWidth" MaximumValue="10000" MinimumValue="1" Type="Double" ValidationGroup="Row" Display="Dynamic" Text="*" ErrorMessage="Invalid value"></asp:RangeValidator>
                                                                    </asp:TableCell>
                                                                </asp:TableRow>
                                                                <asp:TableRow>
                                                                    <asp:TableCell>LENGTH:</asp:TableCell>
                                                                    <asp:TableCell ColumnSpan="3">
                                                                        <asp:TextBox ID="txtLength" runat="server" Text='<%# Eval("LENGTH") %>' OnTextChanged="Dimension_Changed" AutoPostBack="true"></asp:TextBox>
                                                                        <asp:RangeValidator ID="valLength" runat="server" ControlToValidate="txtLength" MaximumValue="10000" MinimumValue="1" Type="Double" ValidationGroup="Row" Display="Dynamic" Text="*" ErrorMessage="Invalid value"></asp:RangeValidator>
                                                                    </asp:TableCell>
                                                                </asp:TableRow>
                                                                <asp:TableRow>
                                                                    <asp:TableCell>HEIGHT:</asp:TableCell>
                                                                    <asp:TableCell ColumnSpan="3">
                                                                        <asp:TextBox ID="txtHeight" runat="server" Text='<%# Eval("HEIGHT") %>' OnTextChanged="Dimension_Changed" AutoPostBack="true"></asp:TextBox>
                                                                        <asp:RangeValidator ID="valHeight" runat="server" ControlToValidate="txtHeight" MaximumValue="10000" MinimumValue="1" Type="Double" ValidationGroup="Row" Display="Dynamic" Text="*" ErrorMessage="Invalid value"></asp:RangeValidator>
                                                                    </asp:TableCell>
                                                                </asp:TableRow>
                                                                <asp:TableRow>
                                                                    <asp:TableCell>VOLUME:</asp:TableCell>
                                                                    <asp:TableCell>
                                                                        <asp:TextBox ID="txtVolume" runat="server" Text='<%# Eval("VOLUME") %>' ReadOnly="true"></asp:TextBox>
                                                                    </asp:TableCell>
                                                                    <asp:TableCell>UOM:</asp:TableCell>
                                                                    <asp:TableCell>
                                                                        <asp:Label ID="lbl5" runat="server" Text='<%# Eval("VOLUME_UOM_CODE") %>' Visible="false"></asp:Label>
                                                                        <asp:DropDownList ID="ddlUOM5" runat="server" Width="70px" DataSource="<%# FillUOMVol()  %>" DataTextField="SHORT_DESCRIPTION" DataValueField="CODE" Enabled="false"></asp:DropDownList>
                                                                    </asp:TableCell>
                                                                </asp:TableRow>
                                                            </asp:Table>
                                                        </EditItemTemplate>
                                                        <ItemStyle CssClass="align-center" Width="200px" VerticalAlign="Top" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="WEIGHT" HeaderStyle-CssClass="align-right">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblWeight" runat="server" Text='<%# Eval("WEIGHT", "{0:n2}") %>'></asp:Label>&nbsp;&nbsp;
                                                            <asp:Label ID="lblWeightUOM" runat="server" Text='<%# Eval("WEIGHT_UOM_CODE", "{0}") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <asp:Table ID="Table3" runat="server" Width="200px" CellSpacing="5">
                                                                <asp:TableRow>
                                                                    <asp:TableCell>Enter the pallet weight:</asp:TableCell>
                                                                </asp:TableRow>
                                                                <asp:TableRow>
                                                                    <asp:TableCell>
                                                                        <asp:Label ID="lblUOM4" runat="server" Text='<%# Eval("WEIGHT_UOM_CODE") %>' Visible="false"></asp:Label>
                                                                        <asp:TextBox ID="txtWeight" runat="server" Text='<%# Eval("WEIGHT") %>'></asp:TextBox>
                                                                    </asp:TableCell>
                                                                    <asp:TableCell>
                                                                        <asp:DropDownList ID="ddlUOM4" runat="server" Width="70px" DataSource="<%# FillUOMWgt()  %>" DataTextField="SHORT_DESCRIPTION" DataValueField="CODE"></asp:DropDownList>
                                                                    </asp:TableCell>
                                                                </asp:TableRow>
                                                            </asp:Table>
                                                        </EditItemTemplate>
                                                        <ItemStyle CssClass="align-right" Width="200px" VerticalAlign="Top" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="ACTION" HeaderStyle-CssClass="align-center">
                                                        <ItemTemplate>
                                                            <asp:Button ID="btnEdit" runat="server" Text="Edit" CausesValidation="false" CssClass="btn btn-info btn-xs" CommandName="Modify" CommandArgument='<%# Eval("GID") %>' />&nbsp;
                                                            <asp:Button ID="btnDelete" runat="server" Text="Remove" CausesValidation="false" CssClass="btn btn-danger btn-xs" CommandName="Remove" CommandArgument='<%# Eval("GID") %>' OnClientClick="return confirm('Are you sure to remove this Ship Unit? It cannot be undone!');" />
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <asp:Button ID="btnNo" runat="server" Text="Cancel" CausesValidation="false" CssClass="btn btn-danger btn-xs" CommandName="Cancelar" CommandArgument='<%# Eval("GID") %>' />&nbsp;
                                                            <asp:Button ID="btnYes" runat="server" Text="Update" CausesValidation="true" CssClass="btn btn-info btn-xs" CommandName="Save" CommandArgument='<%# Eval("GID") %>' />
                                                        </EditItemTemplate>
                                                        <ItemStyle CssClass="align-center" Width="150px" VerticalAlign="Top" />
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell ColumnSpan="2" HorizontalAlign="Right">
                                            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-danger" CausesValidation="false" />&nbsp;&nbsp;
                                            <asp:Button ID="btnUpdate" runat="server" Text="Submit" CssClass="btn btn-info" />
                                        </asp:TableCell>
                                    </asp:TableRow>
                                </asp:Table>
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </div>
                <asp:HiddenField ID="hdAdding" runat="server" Value="False" />
<%--            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:UpdateProgress ID="UpdateProgress1" runat="server" DisplayAfter="100" AssociatedUpdatePanelID="UpdatePanel1">
            <ProgressTemplate>
                <div class="center">
                    <img src="loading.gif" style="height: 30px; width: 60px;" />
                </div>
            </ProgressTemplate>
        </asp:UpdateProgress>--%>
    </form>
</body>
</html>
