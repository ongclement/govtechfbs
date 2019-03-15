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
        @room= Room.find(params[:id])
    end

    def create
        @room= Room.new(booking_params)

        if Room.exists?(name: @room.name.strip())
            @room.errors.add(:base, "Duplicate room name, please enter a new name.")
        end

        if @room.errors.empty?
            @room.save
            redirect_to(rooms_url)
        else
            render 'new'
        end
    end

    def destroy
        @room= Room.find(params[:id])
        @room.destroy

        redirect_to(rooms_url)
    end

    private
    def booking_params
        params.require(:room).permit(:id, :name, :description)
    end
end
