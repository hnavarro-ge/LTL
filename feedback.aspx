<%@ Page Language="VB" AutoEventWireup="false" CodeFile="feedback.aspx.vb" Inherits="feedback" %>

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

        .Star {
            background-image: url(images/Star.gif);
            height: 17px;
            width: 17px;
        }

        .WaitingStar {
            background-image: url(images/WaitingStar.gif);
            height: 17px;
            width: 17px;
        }

        .FilledStar {
            background-image: url(images/FilledStar.gif);
            height: 17px;
            width: 17px;
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
                    <%--                            <img id="userimage" runat="server" src="" alt="" class="img-circle" style="float: left; height: 48px; margin: 5px; margin-bottom: 0px;">--%>
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
                        <li class="inactive"><a href="PalletsCrud.aspx">Pallets</a></li>
                    </ul>
                    <div class="pull-right">
                        <ul class="nav navbar-nav">
                            <li class="active"><a href="feedback.aspx">Feedback</a></li>
                            <li class="inactive"><a href="~/help/help.aspx" target="_blank">Help</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </nav>
        <div class="container content">
            <asp:Table ID="Table1" runat="server" CellPadding="5" CellSpacing="5" Width="100%" CssClass="align-center">
                <asp:TableRow>
                    <asp:TableCell ColumnSpan="2"><b>FEEDBACK ON OTM MOBILE PROGRAM</b></asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell HorizontalAlign="Left">Please rate your experience with this program:</asp:TableCell>
                    <asp:TableCell CssClass="align-left">
                        <ajaxToolkit:Rating ID="ProgramRating" runat="server" CurrentRating="2" MaxRating="5" StarCssClass="Star" WaitingStarCssClass="WaitingStar" EmptyStarCssClass="Star" FilledStarCssClass="FilledStar"></ajaxToolkit:Rating>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell HorizontalAlign="Left">Please share your feedback with us:</asp:TableCell>
                    <asp:TableCell CssClass="align-left">
                        <asp:TextBox ID="txtFeed" runat="server" Width="200px" Rows="5" MaxLength="500"></asp:TextBox>
                        <ajaxToolkit:TextBoxWatermarkExtender runat="server" BehaviorID="txtFeed_TextBoxWatermarkExtender" TargetControlID="txtFeed" ID="txtFeed_TextBoxWatermarkExtender" WatermarkText="What do you like? How can we improve?"></ajaxToolkit:TextBoxWatermarkExtender>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </div>
    </form>
</body>
</html>
