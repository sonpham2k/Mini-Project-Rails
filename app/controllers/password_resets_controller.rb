class PasswordResetsController < ApplicationController
    layout 'authen/master'

    skip_before_action :require_login

    before_action :get_user, only: [:edit, :update]
    
    def new
      @user = User.new
    end
  
    def create
        begin
            @user = User.find_by(email: params[:user][:email])
            if @user
              @user.reset_digest = (0...8).map { (65 + rand(26)).chr }.join
              @user.save
              flash[:info] = "Email sent with password reset instructions"
              render 'success'
            end
            flash.now[:error] = "Email address not found"
            render 'new'
        rescue Exception => e
            logger.info e
        end
    end

    def change_password
        @reset_digest = params[:reset_digest]
        @user = User.find_by(reset_digest: @reset_digest)
        render 'edit'
    end
  
    def edit
    end
  
    def update
        begin
            @user = get_user
            @user.attributes = user_params
            if @user.save
              flash[:success] = 'Password change success!!'   
              return redirect_to login_path   
            end
            flash[:error] = 'Password change fails!!'   
            render 'edit'
        rescue Exception => e
            logger.info e
        end
    end

    def reset
      @user = User.find_by(reset_digest: params[:reset])
      if @user
        return render 'edit'
      end
      render 'wrong_reset'
    end
  private
      def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
      end
  
      def password_params
        params.permit(:password, :password_confirmation)
      end
  
      def get_user
        @user = User.find_by(email: params[:email])
      end
end
