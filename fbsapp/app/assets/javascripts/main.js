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

    $('#first-next').click(function() {
        const bookings = $('#bookings-all').data('bookings');
        const rooms = $('#rooms-all').data('rooms');
        const date = new Date($('#new-booking-date').val());
        const allToday = [];

        $('#date-placeholder').empty();
        $('#date-placeholder').append(date.toDateString());

        const todayDate = new Date();
        todayDate.setHours(0,0,0,0);

        if (date < todayDate) {
            alert('Please select a future date.');
        } else if ($('#new-booking-date').val()) {
            for (let i=0; i<bookings.length; i++) {
                const b = bookings[i];
                const bDate = new Date(b.date);
                if (bDate.getFullYear()==date.getFullYear() && bDate.getMonth()==date.getMonth() && bDate.getDate()==date.getDate()) {
                    const room = rooms.filter(obj => {
                        return obj.name === b.roomname
                    })
                    b.roomID = room[0].id;
                    allToday.push(b);
                }
            }
            for (let a=0; a<allToday.length; a++) {
                const booking = allToday[a];
                const duration = (parseInt(booking.endTime) - parseInt(booking.startTime))/100;
                let startTime = parseInt(booking.startTime);
                for (let j=0; j<duration; j++) {
                    $('#room_'+booking.roomID+'_'+startTime.toString()).css('background-color', 'red');
                    $('#room_'+booking.roomID+'_'+startTime.toString()).removeClass('unselected-cell');
                    startTime+=100;
                }
            }

            $('#new-booking-1').hide();
            $('#new-booking-2').show();
        } else {
            alert("Date cannot be empty.")
        }
    });

    $('#second-prev').click(function() {
        $('#new-booking-1').show();
        $('#new-booking-2').hide();

        const rooms = $('#rooms-all').data('rooms');
        for (let a=0; a<rooms.length; a++) {
            const room = rooms[a];
            for (let i=800; i<=1800; i+=100) {
                const cellClass = '#room_'+room.id+'_'+i.toString();
                $(cellClass).css('background-color', '');
            }
        }
        $('#booking_startTime').val('');
        $('#booking_endTime').val('');
        $('#booking_roomname').val('');
    });

    $('#room-table-body').on('click', '.unselected-cell', function() {
        const room = $(this).siblings('.room-row').text();
        const currentSelection = $('#booking_roomname').val();
        const startTime = parseInt($(this).attr('id').split('_')[2]);
        const endTime = startTime+100;
        const currentStart = parseInt($('#booking_startTime').val());
        const currentEnd = parseInt($('#booking_endTime').val());
        const date = new Date($('#new-booking-date').val());

        let currentHour = new Date().getHours().toString();
        let currentMinute = new Date().getMinutes().toString();
        currentHour = currentHour.length==1?'0'+currentHour:currentHour;
        currentMinute = currentMinute.length==1?'0'+currentMinute:currentHour;
        const currentTime = parseInt(currentHour+currentMinute);
        const todayDate = new Date();

        if (date.getDate()==todayDate.getDate() && date.getMonth()==todayDate.getMonth() && date.getFullYear()==todayDate.getFullYear() && startTime<=currentTime) {
            alert('The timeslot you have selected is over, please select a future timeslot.');
        } else if (currentEnd-currentStart==200) {
            alert('You are only allowed to book 2 hours per booking.');
        } else if ((currentSelection==room || currentSelection.length==0) && (!currentStart || currentStart==endTime || currentEnd==startTime)) {
            $(this).removeClass('unselected-cell');
            $(this).addClass('selected-cell');
            $(this).css('background-color', '#28a745');

            if (currentSelection.length==0) {
                $('#booking_roomname').val(room);
                $('#booking_startTime').val(startTime);
                $('#booking_endTime').val(endTime);
            } else {
                if (currentStart==endTime) {
                    $('#booking_startTime').val(startTime);
                } else if (currentEnd == startTime) {
                    $('#booking_endTime').val(endTime);
                }
            }
        } else {
            alert('You are allowed to make booking for 1 room at a time. Please deselect your current options first!');
        }
    });

    $('#room-table-body').on('click', '.selected-cell', function() {
        $(this).removeClass('selected-cell');
        $(this).addClass('unselected-cell');
        $(this).css('background-color', '');

        const currentStart = parseInt($('#booking_startTime').val());
        const currentEnd = parseInt($('#booking_endTime').val());
        const startTime = parseInt($(this).attr('id').split('_')[2]);
        const endTime = startTime+100;

        if (currentEnd-currentStart==200) {
            if (startTime==currentStart) {
                $('#booking_startTime').val(startTime+100);
            } else if (endTime==currentEnd) {
                $('#booking_endTime').val(endTime-100);
            }
        } else {
            $('#booking_startTime').val('');
            $('#booking_endTime').val('');
            $('#booking_roomname').val('');
        }
    });

});