class RoomsController < ApplicationController
    def index
        @rooms = Room.all
    end

    def show
        @room= Room.find(params[:id])
    end

    def new
        @room= Room.new
    end

    def edit
        @room = Room.find(params[:id])
    end

    def create
        @room= Room.new(booking_params)
        @room.save
        redirect_to rooms_url
    end

    def destroy
        @room= Room.find(params[:id])
        @room.destroy

        redirect_to(rooms_url)
    end

    def save_room_details
        @room= Room.find(params[:id])
        if @room
            @room.name = params[:name]
            @room.description = params[:desc]

            @room.save
        end
        redirect_to rooms_url
    end

    private
    def booking_params
        params.require(:room).permit(:id, :name, :description, :room_image)
    end
end
