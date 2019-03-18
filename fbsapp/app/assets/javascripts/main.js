document.addEventListener("turbolinks:load", function() {

    $('#rooms-data').on('click', '#edit-room', function() {
        const name = $(this).data('name');
        const desc = $(this).data('description');
        const id = $(this).data('id');

        $('#edit-room-id').val(id);
        $('#edit-room-name').val(name);
        $('#edit-room-desc').val(desc);

        $('.edit-room-popup').show();
        $('.grey-screen').show();
    });

    $('#edit-room-save').click(function() {
        $('.edit-room-popup').hide();
        $('.grey-screen').hide();
    })

    $('#edit-rooms-close').click(function() {
        $('.edit-room-popup').hide();
        $('.grey-screen').hide();
    });

});