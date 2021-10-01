// ajax for apply discount code
$('#discount_code_form').on('submit', function (e) {
    var form = $(this);
    var url ='http://127.0.0.1:8000/en/api/orders/discount-code'
    let discount_code = $('#discount_code').val()
    let user_id = $('#user_id').val()
    e.preventDefault();
    $.ajax({
        type: "POST",
        url: url,
        data: JSON.stringify({
            'code': discount_code,
            'user_id': user_id,
        }),
        success: function (data) {
            $("#final_price").html(data['final_price'])
            $("#discount").html(data['discount'])
            $("#discount").append('%')

        },
        error: function (xhr, errmsg, err) {
         if(languege_code==='fa'){
              $("#error_text").html('کد تخفیف موردنظر نامعتبر است')
         }
         else {
                 $("#error_text").html('discount code is not valid')
         }
        },
        contentType: "application/json",
        dataType: 'json',
    });
});