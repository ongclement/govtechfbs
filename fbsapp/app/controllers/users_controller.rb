class UsersController < ApplicationController
    def index
        @users = User.all
    end

    def show
        @user= User.find(params[:id])
    end

    def new
        @user= User.new
    end
    def edit
        @user= User.find(params[:id])
    end

    def create
        @user= User.new(booking_params)
        @user.save
        redirect_to(users_url)
    end

    def destroy
        @user= User.find(params[:id])
        @user.destroy

        redirect_to(users_url)
    end

    private
    def booking_params
        params.require(:user).permit(:id, :username, :password)
    end
end
