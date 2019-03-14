class SessionsController < ApplicationController

    def new
    end

    def create
        user = User.find_by(username: params[:session][:username].downcase)
        if user && user.password==params[:session][:password]
            log_in user
            redirect_to(welcome_index_url)
        else
            if params[:session][:username].empty? or params[:session][:password].empty?
                flash.now.alert  = 'Username/password cannot be empty'
            else
                flash.now.alert  = 'Invalid email/password combination'
            end
            render 'new'
        end
    end

    def destroy
        log_out
        redirect_to root_url
    end
end
