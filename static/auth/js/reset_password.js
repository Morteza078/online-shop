// ajax for send to email a link reset password
$('#reset_password_form').on('submit', function (e) {
    let email = $('#id_email').val()
    e.preventDefault();
    $.ajax({
        type: "POST",
        url: 'http://127.0.0.1:8000/en/api/customer/request-reset-email/',
        data: JSON.stringify({
            email: email,
        }),
        success: function (data) {
            alert(data['success'])
            $('#non-field-error').html(' ')
        },
        error: function (xhr, errmsg, err) {
            console.log(xhr.responseText)
            $('#non-field-error').html(JSON.parse(xhr.responseText)['error'])
        },
        contentType: "application/json",
        dataType: 'json',
    });
});

// ajax for apply new password
$('#set_new_password_form').on('submit', function (e) {
    var form = $(this);
    var url = form.attr('action');
    console.log(url)
    let new_password = $('#id_new_password').val()
    let token = $('#token').val()
    let uidb64 = $('#uidb64').val()
    new XMLHttpRequest().open('PATCH', '/')
    e.preventDefault();
    $.ajax({
        type: "PATCH",
        url: url,
        data: JSON.stringify({
            'password': new_password,
            'token': token,
            'uidb64': uidb64
        }),
        success: function (data) {
            alert(data['message'])
            console.log(data['success'])
            $('#non-field-error').html(' ')
        },
        error: function (xhr, errmsg, err) {
            console.log('in error')
            console.log(xhr.responseText)
            $('#non-field-error').html(JSON.parse(xhr.responseText)['error'])
            $('#password_error').html(JSON.parse(xhr.responseText)['password'])
        },
        contentType: "application/json",
        dataType: 'json',
    });
});

