var DATE_TIME = {};

function getFiscalDateTime() {
    var serializedData = {};
    serializedData.option = "getFiscalDateTime"

    $.ajax({
        type: "POST",
        url: "serverControl.aspx",
        cache: false,
        data: serializedData,
        async: false,
        success: function (data) {
            array_values = ConvertStringToArray(data, "}", "]")
            DATE_TIME.date = array_values[0][1];
            DATE_TIME.time = array_values[1][1];
            DATE_TIME.dd = array_values[2][1];
            DATE_TIME.hh = array_values[3][1];
            DATE_TIME.mi = array_values[4][1];

            DATE_TIME.date_yd = array_values[5][1];
            DATE_TIME.dd_yd = array_values[6][1];

            DATE_TIME.f_yy = array_values[7][1];
            DATE_TIME.f_qq = array_values[8][1];
            DATE_TIME.f_mm = array_values[9][1];
            DATE_TIME.f_wk = array_values[10][1];          

            DATE_TIME.f_yy_range = {}; DATE_TIME.f_yy_range.start_date = array_values[11][1]; DATE_TIME.f_yy_range.end_date = array_values[11][2];
            DATE_TIME.f_qq_range = {}; DATE_TIME.f_qq_range.start_date = array_values[12][1]; DATE_TIME.f_qq_range.end_date = array_values[12][2];
            DATE_TIME.f_mm_range = {}; DATE_TIME.f_mm_range.start_date = array_values[13][1]; DATE_TIME.f_mm_range.end_date = array_values[13][2];
            DATE_TIME.f_wk_range = {}; DATE_TIME.f_wk_range.start_date = array_values[14][1]; DATE_TIME.f_wk_range.end_date = array_values[14][2];

            DATE_TIME
        },
        error: function (jqXHR, textStatus, errorThrown) {
            alert(serializedData.option + ':' + textStatus + errorThrown);
        }
    });
}


getFiscalDateTime();
