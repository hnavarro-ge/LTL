var UserInfo;

function getUserInfo() {
    var serializedData = {};
    serializedData.option = "getUserInfo";

    $.ajax({
        type: "POST",
        url: "serverControl.aspx/getUserInfo",
        cache: false,
        data: serializedData,
        async: false,
        success: function (data) {
            UserInfo = ConvertStringToArray(data, ",", ";")
        },
        error: function (jqXHR, textStatus, errorThrown) {
            alert("op:" + serializedData.option + ' - ' + textStatus + ' - ' + errorThrown);
        }
    });
}

$(document).ready(function () {
    getUserInfo();
    if (typeof UserInfo !== undefined || UserInfo !== 'undefined' || UserInfo !== null) {
        $("#user-name").html(UserInfo[0][0]);
        $("#user-image").attr('src', UserInfo[0][1]);
    }
   
});