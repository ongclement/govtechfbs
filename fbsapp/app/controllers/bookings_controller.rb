class BookingsController < ApplicationController
    def create
        @booking = Booking.new(booking_params)
        @booking.save
        redirect_back(fallback_location: root_path)
    end
    private
    def booking_params
        params.require(:booking).permit(:userid, :roomid, :date, :startTime, :endTime, :status)
    end
end
