var isSelectRowTable = false;
var selectedMultipleRows = false;


function InitTablePaginate(id, width, height, currentPage, sizePage, clickPageEvent) {
    if (!$('#' + id).length) return 0;
    var headTable = $('#HT' + id);
    var bodyTable = $('#BT' + id);
    var table = $('#' + id);
    var cssObj = { 'width': width - 18, 'height': height - parseInt(headTable.css('height').substr(0, 2)) };

    headTable.css('width', width - 16);
    bodyTable.css('width', width);

    $('.viewport', bodyTable).css(cssObj);
    $(bodyTable).hover(
        function () {
            //$('.scrollbar',bodyTable).css({'visibility':'visible'});
            $('.scrollbar', bodyTable).fadeIn("slow");
        }, function () {
            //$('.scrollbar',bodyTable).css({'visibility':'hidden'});
            $('.scrollbar', bodyTable).fadeOut("slow");
        });

    $(document).keydown(function (e) {
        if (e.keyCode == '17') { // CTRL key
            isSelectRowTable = true;
        }
    });

    $(document).keyup(function (e) {
        if (e.keyCode == '17') {// CTRL key
            isSelectRowTable = false;
        }
    });

    HiddenColumnsTable(headTable, bodyTable);
    RenderCheckColumnsTable(headTable, bodyTable);
    RenderTextColumnsTable(headTable, bodyTable);
    AddDefaultEvents(headTable, bodyTable);
    bodyTable.tinyscrollbar();
    table.tablesorter();
    setUpPaginate(id, currentPage, sizePage, clickPageEvent);
    HerachyEventClick(headTable, bodyTable);
    FixWidthHeaderTable(headTable, table);
    table.css('top', '-' + headTable.css('height'));
}

function InitTable(id, width, height) {
    if (!$('#' + id).length) return 0;
    var headTable = $('#HT' + id);
    var bodyTable = $('#BT' + id);
    var table = $('#' + id);
    var cssObj = { 'width': width - 18, 'height': height - parseInt(headTable.css('height').substr(0, 2)) };
    headTable.css('width', width - 16);
    bodyTable.css('width', width);

    $('.viewport', bodyTable).css(cssObj);
    $(bodyTable).hover(
        function () {
            //$('.scrollbar',bodyTable).css({'visibility':'visible'});
            $('.scrollbar', bodyTable).fadeIn("slow");
        }, function () {
            //$('.scrollbar',bodyTable).css({'visibility':'hidden'});
            $('.scrollbar', bodyTable).fadeOut("slow");
        });
    HiddenColumnsTable(headTable, bodyTable);
    RenderCheckColumnsTable(headTable, bodyTable);
    RenderTextColumnsTable(headTable, bodyTable);
    FixWidthHeaderTable(headTable, bodyTable);
    AddDefaultEvents(headTable, bodyTable);
    bodyTable.tinyscrollbar();
    table.tablesorter();
}

function InitTablePaginateHideOP(id, width, height, currentPage, sizePage, clickPageEvent) {
    if (!$('#' + id).length) return 0;
    var headTable = $('#HT' + id);
    var bodyTable = $('#BT' + id);
    var table = $('#' + id);
    var cssObj = { 'width': width - 18, 'height': height - parseInt(headTable.css('height').substr(0, 2)) };

    headTable.css('width', width - 16);
    bodyTable.css('width', width);

    $('.viewport', bodyTable).css(cssObj);

    $(document).keydown(function (e) {
        if (e.keyCode == '17') { // CTRL key
            isSelectRowTable = true;
        }
    });

    $(document).keyup(function (e) {
        if (e.keyCode == '17') {// CTRL key
            isSelectRowTable = false;
        }
    });

    HiddenColumnsTable(headTable, bodyTable);
    RenderCheckColumnsTable(headTable, bodyTable);
    RenderTextColumnsTable(headTable, bodyTable);
    AddDefaultEvents(headTable, bodyTable);
    bodyTable.tinyscrollbar();
    table.tablesorter();
    setUpPaginate(id, currentPage, sizePage, clickPageEvent);
    HerachyEventClick(headTable, bodyTable);
    FixWidthHeaderTable(headTable, table);
    table.css('top', '-' + headTable.css('height'));


    $('#OT' + id).hide();
    $('#PT' + id).hide();
}

function InitSimpleTable(id, width, height) {
    if (!$('#' + id).length) return 0;

    var bodyTable = $('#BT' + id);
    bodyTable.css('width', width);

    HiddenColumnsTable(bodyTable, bodyTable);
    RenderCheckColumnsTable(bodyTable, bodyTable);
    RenderTextColumnsTable(bodyTable, bodyTable);
    AddDefaultEvents(headTable, bodyTable);
}

function InitTableComments(id, width, height) {
    var bodyTable = $('#' + id);
    var cssObj = { 'width': width - 18, 'height': height };
    bodyTable.css('width', width);
    $('.viewport', bodyTable).css(cssObj);
    bodyTable.tinyscrollbar();
}


function HiddenColumnsTable(headTable, bodyTable) {
    var arrayHidenColumns = new Array();
    var index = 0;
    $.each($('.cH', headTable), function (key, value) {
        if ($(this).attr("g").indexOf('H_') == 0) {
            arrayHidenColumns[index++] = $(this).html();
            $(this).hide();
        }
    });
    $.each($('.cH', bodyTable), function (key, value) {
        if ($(this).attr("g").indexOf('H_') == 0) {
            $(this).hide();
        }
    });
    for (index = 0 ; index < arrayHidenColumns.length; index++)
        if (arrayHidenColumns.length > 0)
            $.each($('.cT[g="' + arrayHidenColumns[index] + '"]', bodyTable), function (key, val) {
                $(this).hide();
            });

}

function RenderCheckColumnsTable(headTable, bodyTable) {
    var arrayCheckColumns = new Array();
    var index = 0;
    $.each($('.cH', headTable), function (key, value) {
        if ($(this).attr("g").indexOf('C_') >= 0) {
            arrayCheckColumns[index++] = $(this).html();
        }
    });
    for (index = 0 ; index < arrayCheckColumns.length; index++)
        if (arrayCheckColumns.length > 0)
            $.each($('.cT[g="' + arrayCheckColumns[index] + '"]', bodyTable), function (key, val) {
                if ($(this).text() == '1')
                    $(this).html('<input g="' + arrayCheckColumns[index] + '" type="checkbox" class="cTCheck" checked />');
                else
                    $(this).html('<input g="' + arrayCheckColumns[index] + '" type="checkbox" class="cTCheck" />');
            });

}

function RenderTextColumnsTable(headTable, bodyTable) {
    var arrayTextColumns = new Array();
    var index = 0;
    $.each($('.cH', headTable), function (key, value) {
        if ($(this).attr("g").indexOf('T_') == 0) {
            arrayTextColumns[index++] = $(this).html();
        }
    });
    for (index = 0 ; index < arrayTextColumns.length; index++)
        if (arrayTextColumns.length > 0)
            $.each($('.cT[g="' + arrayTextColumns[index] + '"]', bodyTable), function (key, val) {
                $(this).html('<input g="' + arrayTextColumns[index] + '" type="text" class="cTText" value="' + $(this).text() + '" />');
            });

}

function AddDefaultEvents(headTable, bodyTable) {
    $.each($('tr', bodyTable), function (key, value) {
        $(this).click(function (value) {

            if (isSelectRowTable == false && $(this).attr('selectedRow') != "true") {
                $.each($('[orig_class]', bodyTable), function (key, value) {
                    $(this).removeClass($(this).attr('class')).addClass($(this).attr('orig_class'));
                });
                $.each($('[selectedRow]', bodyTable), function (key, value) {
                    $(this).attr('selectedRow', "false");
                });
                selectedMultipleRows = false;
            } else {
                selectedMultipleRows = true;
            }
            if ($(this).attr('selectedRow') == "true") {
                if (value.isTrigger == undefined) {
                    $(this).removeClass($(this).attr('class')).addClass($(this).attr('orig_class'));
                    $(this).attr('selectedRow', "false");
                }
            } else {
                $(this).attr('orig_class', $(this).attr('class'));
                $(this).removeClass($(this).attr('class')).addClass("rT-selected");
                $(this).attr('selectedRow', "true");
            }
        })
    });
}

function FixWidthHeaderTable(headTable, bodyTable) {
    var index = 0;
    var width = new Array();
    var width2 = new Array();
    var row = $('[iR=0]', bodyTable);
    $.each($('td', row), function (key, value) {
        width[index++] = parseInt($(this).css('width'));
    });
    index = 0;
    row = $('.rH', headTable);
    $.each($('.cH', row), function (key, value) {
        $(this).css('width', width[index++]);
    });
}

function HerachyEventClick(headTable, bodyTable) {
    var index = 0;
    var width = new Array();
    var row = $('[iR=0]', bodyTable);

    row = $('.rH', headTable);
    $.each($('.cH', row), function (key, value) {

        $(this).click(function () {
            $("[g='" + $(this).html() + "']", $('.rH', bodyTable)).click();
        });
    });
}

function HideOptionsTable(id) {
    $('#OT' + id).hide();
    $('#PT' + id).hide();
}


function HtmlTableToArray(tableName) {
    var array = new Array();
    var row = 0;
    var column = 0;
    var table = $('tbody', $('#' + tableName));
    $.each($('tr', table), function (key, val) {
        array[row] = new Array();
        $.each($('td', $(this)), function (key, val) {
            if ($(this).attr("g").indexOf('C_') >= 0) {
                if ($('input', $(this)).is(':checked'))
                    array[row][column] = '1' + splitColumn;
                else
                    array[row][column] = '0' + splitColumn;
            } if ($(this).attr("g").indexOf('T_') >= 0) {
                array += $.trim($('input', $(this)).val()) + splitColumn;
            } else {
                array[row][column] = ($(this).text() != "-" ? $(this).text() : "");
            }
            column++;
        });
        column = 0;
        row++;
    });
    return array;
}

function HtmlTableToString(tableName, splitRow, splitColumn) {
    var array = "";
    var table = $('tbody', $('#' + tableName));
    $.each($('tr', table), function (key, val) {
        $.each($('td', $(this)), function (key, val) {
            if ($(this).attr("g").indexOf('C_') >= 0) {
                if ($('input', $(this)).is(':checked'))
                    array += '1' + splitColumn;
                else
                    array += '0' + splitColumn;
            } if ($(this).attr("g").indexOf('T_') >= 0) {
                array += $.trim($('input', $(this)).val()) + splitColumn;
            } else {
                array += ($(this).text() != "-" ? $(this).text() : "") + splitColumn;
            }
        });
        array += splitRow;
    });
    return array;
}

function setUpPaginate(tableName, currentPage, sizePage, clickPageEvent) {
    if (!$('#PT' + tableName).length) return 0;
    $.each($('.PTelem', $('#PT' + tableName)), function () {
        if ($(this).attr("page") == currentPage)
            $(this).removeClass($(this).attr('class')).addClass("PTelemCurrent").show();
        if ($(this).attr("page") != currentPage)
            $(this).click(function () {
                clickPageEvent($(this).attr("page"), sizePage);
            });
    });
}

function ConvertArrayToHTMLTable(tableName, tableArray, NameColumns) {
    var header = "";
    var body = "";
    var html = "";
    var row = 0;
    var column = 0;
    //-----------------------------------------------------------------------------------------------

    html += '<table id="HT' + tableName + '" border="0" cellpadding="2" cellspacing="0" class = "headTable" > ';
    html += '<thead>';
    html += '<tr class = "rH">';
    for (column = 0; column <= NameColumns.length - 1; column++) {
        html += '<th class = "cH" g="' + NameColumns[column] + '">' + NameColumns[column] + '</th>';
    }
    html += '</tr>';
    html += "</thead>";
    html += "</table>";

    //-----------------------------------------------------------------------------------------------

    html += '<div id="BT' + tableName + '" class = "bodyTableContent">'
    html += '<div class = "scrollbar"><div class="track"><div class="thumb"><div class="end"></div></div></div></div>';
    html += '<div class="viewport">'
    html += '<div class="overview">'

    html += '<table id= "' + tableName + '" border="0" cellpadding="2" cellspacing="0"  class = "bodyTable" > ';
    html += '<thead class= "headerBodyTable">'
    html += '<tr class = "rH">';
    for (column = 0; column <= NameColumns.length - 1; column++) {
        html += '<th class = "cH" g="' + NameColumns[column] + '">' + NameColumns[column] + '</th>';
    }
    html += '</tr>';
    html += "</thead>"
    html += "<tbody>"
    for (row = 0; row <= tableArray.length - 2; row++) {
        html += '<tr class = "rT" iR="' + row + '" isDelete = "false" >';
        for (column = 0; column <= NameColumns.length - 1; column++) {
            html += '<td class = "cT" g="' + NameColumns[column] + '">' + tableArray[row][column] + '</td>';
        }
        html += '</tr>';
    }
    html += "</tbody>"
    html += "</table>"
    html += "</div></div>"
    html += "</div>"
    return html;
}

function ConvertArrayToSingleHTMLTable(tableName, tableArray, NameColumns) {
    var header = "";
    var body = "";
    var html = "";
    var row = 0;
    var column = 0;

    html += '<table id= "' + tableName + '" border="0" cellpadding="2" cellspacing="0"  class = "bodyTable" > ';

    html += '<thead class= "headerBodyTable">'
    html += '<tr class = "rH">';
    for (column = 0; column <= NameColumns.length - 1; column++) {
        html += '<th class = "cH">' + NameColumns[column] + '</th>';
    }
    html += '</tr>';
    html += "</thead>"

    html += "<tbody>"

    for (row = 0; row <= tableArray.length - 2; row++) {
        html += '<tr class = "rT" iR="' + row + '" isDelete = "false" >';
        for (column = 0; column <= NameColumns.length - 1; column++) {
            html += '<td class = "cT" g="' + NameColumns[column] + '">' + tableArray[row][column] + '</td>';
        }
        html += '</tr>';
    }

    html += "</tbody>"

    html += "</table>"
    return html;
}

function ConvertStringToArray(value, ColumSplit, RowSplit) {
    var auxTable = new Array();
    var rows = value.split(RowSplit);
    auxTable = rows;
    $.each(rows, function (index, row) {
        auxTable[index] = row.split(ColumSplit);
    });
    return auxTable;
}



//--------------------------------------------------------------------------------------
//--------------------------------- CONTEX MENU ----------------------------------------
//--------------------------------------------------------------------------------------


var hideContextMenu = false;
var RowActiveContextMenu = '';

$(document).ready(function () {
    $('#menuContext').mouseenter(function () { hideContextMenu = false; });
    $('#menuContext').mouseleave(function () { hideContextMenu = true; });
});

$(document).click(function (e) {
    if (e.button == 0 && hideContextMenu) {
        $('#menuContext').hide();
    }
});

$(document).keydown(function (e) {
    if (e.keyCode == 27) {
        $('#menuContext').hide();
    }
});

jQuery.fn.contextMenu = function (id_ContexMenu, only) {
    if (only == undefined) only = "";
    this.each(function () {
        $(this).bind('contextmenu', function (e) {
            e.preventDefault();
            RowActiveContextMenu = $(this);
            $('#' + id_ContexMenu).css({ 'left': e.pageX, 'top': e.pageY });
            $('#' + id_ContexMenu).show();
            $('#' + id_ContexMenu).show(function () {
                $.each($('[isOnly=true]', $(this)), function (key, val) {
                    if (only.search($(this).attr("only")) > -1)
                        $(this).show();
                    else
                        $(this).hide();
                });
            });
            RowActiveContextMenu.click();
        });
    });
};

