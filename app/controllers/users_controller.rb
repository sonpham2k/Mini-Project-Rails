class UsersController < ApplicationController
  layout :resolve_layout

  skip_before_action :require_login, only: [:new, :create]

  def index
    @users = User.search(params[:search]).paginate(page: params[:page], :per_page => 10)
  end

  def new
    @user = User.new
  end

  def create
    begin
      @user = User.new register_params
      @user.attributes = register_params
      if @user.save
        @user.avatar.attach(register_params[:avatar])
        flash[:success] = "Register success"
        return redirect_to login_path
      end

      flash[:danger] = "Register failed"
      render "new"
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
      if @user.valid?
        if register_params[:avatar]
          @user.avatar.attach(register_params[:avatar])
        end
        @user.attributes = register_params
        @user.save
        flash[:success] = "Update profile success!"
        return redirect_to edit_user_path
      end
      flash[:danger] = "Update profile fails!"
      render "edit"
    rescue Exception => e
      logger.info e
    end
  end

  def destroy
    begin
      @user = User.find(params[:id])
      @user.destroy
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

  def register_params
    params.require(:user).permit :name, :email, :password, :password_confirmation, :avatar
  end

  def password_params
    params.require(:user).permit :current_password, :password, :password_confirmation
  end

  def resolve_layout
    @default = "homepages/master"
    case action_name
    when "new", "create"
      @default = "authen/master"
    end
    @default
  end
end
