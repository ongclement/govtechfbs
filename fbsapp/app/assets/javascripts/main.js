document.addEventListener("turbolinks:load", function() {

    $('#rooms-data').on('click', '#edit-room', function() {
        const name = $(this).data('name');
        const desc = $(this).data('description');
        const id = $(this).data('id');

        $('#edit-room-id').val(id);
        $('#edit-room-name').val(name);
        $('#edit-room-desc').val(desc);

        $('#edit-room-popup').show();
        $('.grey-screen').show();
    });

    $('#edit-room-save').click(function() {
        $('#edit-room-popup').hide();
        $('.grey-screen').hide();
    })

    $('#edit-rooms-close').click(function() {
        $('#edit-room-popup').hide();
        $('.grey-screen').hide();
    });

    $('#users-data').on('click', '#edit-user', function() {
        const name = $(this).data('username');
        const password = $(this).data('password');
        const id = $(this).data('id');

        $('#edit-user-id').val(id);
        $('#edit-user-name').val(name);
        $('#edit-user-pw').val(password);

        if (name=='admin') {
            $('#edit-user-name').attr("disabled",true);
        } else {
            $('#edit-user-name').attr("disabled",false);
        }

        $('#edit-user-popup').show();
        $('.grey-screen').show();
    });

    $('#edit-user-save').click(function() {
        $('#edit-user-popup').hide();
        $('.grey-screen').hide();
    })

    $('#edit-users-close').click(function() {
        $('#edit-user-popup').hide();
        $('.grey-screen').hide();
    });

    $('#rooms-data').on('click', '.change-image', function() {
        const id = $(this).data('id');
        $('#change-image-id').val(id);

        $('#change-image-popup').show();
        $('.grey-screen').show();
    })

    $('#change-image-close').click(function() {
        $('#change-image-file').val('');
        $('#change-image-popup').hide();
        $('.grey-screen').hide();
    });
});