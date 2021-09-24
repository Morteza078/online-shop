$('#change_password_form').on('submit', function (e) {
    var form = $(this);
    var url = form.attr('action');
    console.log(url)
    let old_password = $('#id_old_password').val()
    let new_password1 = $('#id_new_password1').val()
    let new_password2 = $('#id_new_password2').val()
    let username = $('#username_js').val()
    let token = $('#token').val()
    new XMLHttpRequest().open('PATCH', '/')
    e.preventDefault();
    $.ajax({
        type: 'PATCH',
        url: url,
        data: JSON.stringify({
            'username': username,
            'old_password': old_password,
            'new_password1': new_password1,
            'new_password2': new_password2
        }),
        success: function (data) {
            alert(data['message'])
            console.log(data['status'])
            $('#non-field-error').html(' ')
        },
        error: function (xhr, errmsg, err) {
            console.log('in error')
            console.log(xhr.responseText)
            $('#old_password_error').html(JSON.parse(xhr.responseText)['old_password'])
            $('#non_field_error').html(JSON.parse(xhr.responseText)['matching'])
            $('#new_password1_error').html(JSON.parse(xhr.responseText)['new_password1'])
            $('#new_password2_error').html(JSON.parse(xhr.responseText)['new_password2'])
            $('#change_password_form').click(function () {
                $('#old_password_error').html('');
                $('#new_password1_error').html('');
                $('#new_password2_error').html('');
            });
        },
        contentType: "application/json",
        dataType: 'json',
    });
});
