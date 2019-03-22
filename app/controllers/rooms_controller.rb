class RoomsController < ApplicationController
    protect_from_forgery with: :null_session

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
        @room= Room.new(room_params.except('room_image'))
        @room.save

        photo = params['room']['room_image']

        if photo
            name = photo.original_filename
            extname = name.partition('.').last
            directory = "public/images"
            path = File.join(directory, 'rooms_' + @room.id.to_s + '.'+ extname)

            File.open(path, "wb") do |file|
                file.write(photo.read)
            end
        end
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

    def change_image
        @room= Room.find(params[:id])
        if @room
            File.delete('public/images/rooms_'+@room.id.to_s+'.jpg') if File.exists?('public/images/rooms_'+@room.id.to_s+'.jpg')
            File.delete('public/images/rooms_'+@room.id.to_s+'.jpeg') if File.exists?('public/images/rooms_'+@room.id.to_s+'.jpeg')
            File.delete('public/images/rooms_'+@room.id.to_s+'.png') if File.exists?('public/images/rooms_'+@room.id.to_s+'.png')

            photo = params[:room_image]

            if photo
                name = photo.original_filename
                extname = name.partition('.').last
                directory = "public/images"
                path = File.join(directory, 'rooms_' + @room.id.to_s + '.'+ extname)

                File.open(path, "wb") do |file|
                    file.write(photo.read)
                end
            end
        end
        redirect_to rooms_url
    end

    private
    def room_params
        params.require(:room).permit(:id, :name, :description, :room_image)
    end
end
