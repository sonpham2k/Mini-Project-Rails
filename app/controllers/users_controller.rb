class UsersController < ApplicationController
    layout :resolve_layout

    skip_before_action :require_login, only: [:new, :create]


    def index
        @users = User.paginate(page: params[:page], :per_page => 10)
    end

    def new
        @user = User.new
    end

    def create
        begin
            @user = User.new register_params
            @user.attributes = register_params
            @messages = @user.valid_attributes?(:name, :email, :password)
            if @messages.none? && @user.save(:validate => false)
                flash[:success] = "Register success"
                return redirect_to users_path
            end
            flash[:danger] = "Register failed"
            return render 'new'
        rescue Exception => e
            logger.info e
        end
    end

    def edit
        @user = User.find_by id: params[:id]
    end

    def update
        begin
            @user = User.find(params[:id])
            if @user.id == current_user.id
                @user.attributes = register_params
                @messages = @user.valid_attributes?(:name, :email, :password)
                @user.add_error_current_password(User.find(params[:id]).authenticate(password_params[:current_password]))
            end
            @user.attributes = other_user_params
            @messages = @user.valid_attributes?(:name, :email)
            if @messages.none? && @user.save(:validate => false)
                flash[:success] = "Update profile success!"
                return redirect_to edit_user_path
            end
            flash[:danger] = "Update profile fails!"
            return render 'edit'
        rescue Exception => e
            logger.info e
        end
    end

    def destroy
        begin
            User.find(params[:id]).delete
            flash[:success] = "Delete success!"
            redirect_to users_url
        rescue Exception => e
            logger.info e
        end
    end
    
    def show
        @user = User.find_by id: params[:id]
    end

    private
    def user_params
        params.require(:user).permit :name, :email, :password
    end

    def other_user_params
        params.require(:user).permit :name, :email
    end

    def register_params
        params.require(:user).permit :name, :email, :password, :password_confirmation
    end

    def password_params
        params.require(:user).permit :current_password, :password, :confirm_password
    end

    def resolve_layout
        @default = 'homepages/master'
        case action_name
            when 'new', 'create'
                @default = 'authen/master'
            end
        @default
    end
end
