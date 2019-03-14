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
        redirect_back(fallback_location: root_path)
    end

    def destroy
        @booking = Booking.find(params[:id])
        @booking.destroy

        redirect_back(fallback_location: root_path)
    end

    private
    def booking_params
        params.require(:booking).permit(:id, :userid, :roomid, :date, :startTime, :endTime, :status)
    end
end
