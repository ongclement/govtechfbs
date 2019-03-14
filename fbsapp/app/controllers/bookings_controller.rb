class BookingsController < ApplicationController
    def index
        @bookings = Booking.all
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
        @booking.save
        redirect_to(bookings_url)
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
