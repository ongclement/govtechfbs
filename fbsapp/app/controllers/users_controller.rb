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
        if @user.username.empty?
            @user.errors.add(:base, "Username field cannot be empty")
        end

        if @user.password.empty?
            @user.errors.add(:base, "Password field cannot be empty")
        end

        if User.exists?(username: @user.username.strip())
            @user.errors.add(:base, "Duplicate username, please enter a new username.")
        end

        if @user.errors.empty?
            @user.save
            redirect_to(users_url)
        else
            render 'new'
        end
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
