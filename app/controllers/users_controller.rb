class UsersController < ApplicationController
    layout :resolve_layout
    # before_action :set_locale

    # def default_url_options
    #     {locale: I18n.locale}
    # end

    skip_before_action :require_login, only: [:new, :create]

    def new
        @user = User.new
    end

    def create
        @user = User.new user_params
        if @user.save
            flash[:success] = "Register success"
            redirect_to users_path
        else
            flash[:success] = "Register failed"
            render :new
        end
    end

    def edit
        @user = User.find_by id: params[:id]
    end

    def update
    end

    def destroy
        # abort User.find(params[:id]).inspect
        User.find(params[:id]).delete
        redirect_to user_url
    end

    def index
        @users = User.all
    end
    
    def show
        @user = User.find_by id: params[:id]
    end

    def change_password
        render 'resources/users/change_password'
    end

    private
        def user_params
            params.require(:user).permit :name, :email, :password, :password_confirmation
        end

        # def set_locale
        #     I18n.locale = params[:locale] || I18n.default_locale
        # end
    
        # def set_locale
        #     locale = params[:locale].to_s.strip.to_sym
        #     I18n.locale = I18n.available_locales.include?(locale) ?
        #         locale : I18n.default_locale
        # end
        def resolve_layout
            case action_name
            when 'new'
              'authen/master'
            else
              'homepages/master'
            end
        end
end
