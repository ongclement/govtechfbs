class BookingsController < ApplicationController
    def index
        if session[:username]=="admin"
            @bookings = Booking.order(:id)
        else
            @bookings = Booking.where(["username = ?", session[:username]])
        end
    end

    def show
        @booking = Booking.find(params[:id])
        @booking.save
        redirect_to(bookings_url)
    end

    def new
        @rooms = Room.all
        @bookings = Booking.where(["status = ?", "Confirmed"])
        @booking = Booking.new
    end
    def edit
        @booking = Booking.find(params[:id])
    end

    def editStatus
        @booking = Booking.find(params[:id])
        @booking.status = params[:status]
        if (@booking.status.downcase=='confirmed' or @booking.status.downcase=='rejected' or @booking.status.downcase=='pending')
            @booking.save
        else
            flash.now.alert = 'Invalid status, unable to be saved'
        end
        redirect_to(bookings_url)
    end

    def create
        @booking = Booking.new(booking_params)
        @bookings = Booking.where(["status = ?", "Confirmed"])
        @rooms = Room.all
        if @booking.roomname.empty?
            flash.now.alert  = 'Please try again and ensure the time slot has been selected.'
            render 'new'
        else
            @booking.username = session[:username]
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
        params.require(:booking).permit(:id, :username, :roomname, :date, :startTime, :endTime, :status)
    end
end
