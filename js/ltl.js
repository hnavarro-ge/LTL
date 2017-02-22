function setUpLoadLTL() {
    SetEventsForDOMElements();
}

function SetEventsForDOMElements() {
    var url = location.href.substring(0, location.href.lastIndexOf("/"))
    

    $("#btnPalletWeightDims").click(function () {
        url = url + "/EnterPalletWeightDimensions.aspx";
        location.href = url;
    });

    $("#btnPalletWeight").click(function () {
        url = url + "/EnterPalletWeight.aspx";
        location.href = url;
    });

    $("#btnPalletDims").click(function () {
        url = url + "/EnterDimensions.aspx";
        location.href = url;
    });

    disableFields();

    $("#searchDelivery").click(function () {
        if ($("#textDeliveryValue").text !== "") {
            getDeliveryInfo($("#textDeliveryValue").text);
        }
    });
}

function getDeliveryInfo(delivery) {
    ableFields();
}

function disableFields() {
    $("#textPalletIDW").attr('disabled', true);
    $("#textWeightW").attr('disabled', true);

    $("#textPalletIDWD").attr('disabled', true);
    $("#textWeightWD").attr('disabled', true);
    $("#slctPalletSizeWD").attr('disabled', true);
    $("#textHeightWD").attr('disabled', true);

    $("#textPalletIDD").attr('disabled', true);
    $("#slctContainerSize").attr('disabled', true);
    $("#textHeightD").attr('disabled', true);
}

function ableFields() {
    $("#textPalletIDW").attr('disabled', false);
    $("#textWeightW").attr('disabled', false);

    $("#textPalletIDWD").attr('disabled', false);
    $("#textWeightWD").attr('disabled', false);
    $("#slctPalletSizeWD").attr('disabled', false);
    $("#textHeightWD").attr('disabled', false);

    $("#textPalletIDD").attr('disabled', false);
    $("#slctContainerSize").attr('disabled', false);
    $("#textHeightD").attr('disabled', false);
}

function renderPage() {

    // TEST1467286979085-001

    //$("#searchDelivery").click(function () {
    //    $.ajax({
    //        type: "POST",
    //        url: "http://otm-dev.cloud.gehealthcare.com/GC3/glog.integration.servlet.WMServlet",
    //        data: "",
    //        headers : {
    //            'Content-Type' : 'application/x-www-form-urlencoded'
    //        },
    //        success: function (data, testStatus, jqXHR) {
    //            alert(data);

    //        }
    //    });
    //});
}





