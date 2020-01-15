function dojQueryAjax() {
    $.ajax({
        type: "GET",
        url: "comments/index",
        cache: false,

        success: function (data) {
            $('#comment_index').html(data);
        },
        error: function () {
            alert("Ajax通信エラー");
        }
    });
}

window.addEventListener('load', function () {
    setTimeout(dojQueryAjax, 3000);
});