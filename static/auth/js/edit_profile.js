console.log(("#id_image").val)
function readURL(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();

        reader.onload = function (e) {
            $('#preview').attr('src', e.target.result);
        }
        reader.readAsDataURL(input.files[0]);
    }
}

$("#id_image").change(function () {
    readURL(this);
});

$('#edit_profile_form').on('click', function () {
    $(".errors").html(' ')
});
// var fileInput = document.getElementById('#image_input');
//
// var reader = new FileReader();
// reader.readAsDataURL(fileInput.files[0]);
//
// reader.onload = function () {
//     console.log(reader.result);//base64encoded string
// };
// reader.onerror = function (error) {
//     console.log('Error: ', error);
// };
//
// // var img=$("#image_input")
// //
// // img.crossOrigin='Anonymous';
// // img.onload =function () {
// //     var canvas =document.createElement('canvas');
// //     var ctx= canvas.getContext('2d');
// //     canvas.height=this.naturalHeight;
// //     canvas.width=this.naturalWidth;
// //     ctx.drawImage(this,0,0);
// //     var data =canvas.toDataURL()
// // }
//
//
// $('#edit_profile_form').on('submit', function (e) {
//     let username = $('#id_username').val()
//     let old_username = $('#username_js').val()
//     let old_email = $('#email_js').val()
//     let email = $('#id_email').val()
//     let image = $('#image_input')
//     let firs_name = $('#id_first_name').val()
//     let last_name = $('#id_last_name').val()
//     var data = JSON.stringify({
//         'username': username,
//         'old_username': old_username,
//         'old_email': old_email,
//         'email': email,
//         'image': image,
//         'firs_name': firs_name,
//         'last_name': last_name,
//     })
//     var form = $(this);
//     var url = form.attr('action');
//     console.log(data)
//     // new XMLHttpRequest().open('PUT', '/')
//     e.preventDefault();
//     $.ajax({
//         type: 'PUT',
//         url: url,
//         data: data,
//         success: function (data) {
//             alert(data['message'])
//             console.log(data['status'])
//             $('#non-field-error').html(' ')
//         },
//         error: function (xhr, errmsg, err) {
//             console.log('in error')
//             console.log(xhr.responseText)
//         },
//         contentType: "application/json",
//         dataType: 'json',
//     });
// });
