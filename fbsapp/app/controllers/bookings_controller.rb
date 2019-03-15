class BookingsController < ApplicationController
    def index
        if session[:username]=="admin"
            @bookings = Booking.all
        else
            @bookings = Booking.where(["userid = ?", session[:user_id]])
        end
    end

    def show
        @booking = Booking.find(params[:id])
    end

    def new
        @booking = Booking.new
    end
    def edit
        @booking = Booking.find(params[:id])
    end

    def create
        @booking = Booking.new(booking_params)
        @bookings = Booking.where(["date = ?", @booking.date])
        overlap = false
        @bookings.each do |bk|
            if (bk.startTime...bk.endTime).overlaps?(@booking.startTime...@booking.endTime) and bk.roomid==@booking.roomid
                overlap = true
            end
        end
        if overlap
            flash.now.alert  = 'Booking timing overlaps with current booking, please select a new timeslot'
            render 'new'
        else
            @booking.userid = session[:user_id]
            @booking.status = "Confirmed"
            @booking.save
            redirect_to(bookings_url)
        end
    end

    def destroy
        @booking = Booking.find(params[:id])
        @booking.destroy

        redirect_to(bookings_url)
    end

    private
    def booking_params
        params.require(:booking).permit(:id, :userid, :roomid, :date, :startTime, :endTime, :status)
    end
end
