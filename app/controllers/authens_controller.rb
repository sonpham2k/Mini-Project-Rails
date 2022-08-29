class AuthensController < ApplicationController
    layout :resolve_layout

    skip_before_action :require_login, only: [:new, :create]

    def new
    end

    def create
        begin
            user = User.find_by email: params[:authens][:email_address]
        rescue Exception => e
            logger.info e
        end

        if user && user.authenticate(params[:authens][:password])
            log_in user
            return redirect_to user
        end
        flash[:danger] = "Invalid email/password combination"
        redirect_to login_path
    end

    def destroy
        log_out
        flash[:success] = "You are logged out"
        redirect_to login_path
    end

    private

        def resolve_layout
            @default = 'homepages/master'
            case action_name
                when 'new', 'logout', 'register', 'forgot_password', 'change_forgot_password'
                    @default = 'authen/master'
                end
            @default
        end
end
