class UsersController < ApplicationController
  include UserRepository

  layout :resolve_layout

  skip_before_action :require_login, only: [:new, :create]

  def index
    # abort User.get_list_user(nil).inspect (Scope)
    @q = User.ransack(params[:q])
    @users = @q.result.paginate(page: params[:page], :per_page => 10)
  end

  def show
    @user = repo.find(User, params[:id])
  end

  def new
    @user = repo.new(User, nil)
  end

  def create
    begin
      @user = repo.new(register_params)
      @user.attributes = register_params
      if repo.save(@user)
        repo.attach_avatar(@user, register_params[:avatar])
        flash[:success] = "Register success"
        return redirect_to login_path
      end

      flash[:error] = "Register failed"
      render "new"
    rescue Exception => e
      logger.info e
    end
  end

  def edit
    @user = repo.find(User, params[:id])
  end

  def update
    begin
      @user = repo.find(User, params[:id])
      if repo.valid(@user)
        if register_params[:avatar]
          repo.attach_avatar(@user, register_params[:avatar])
        end
        @user.attributes = register_params
        repo.save(@user)
        flash[:success] = "Update profile success!"
        return redirect_to edit_user_path
      end
      flash[:error] = "Update profile fails!"
      render "edit"
    rescue Exception => e
      logger.info e
    end
  end

  def destroy
    begin
      @user = repo.find(User, params[:id])
      repo.delete(@user)
      flash[:success] = "Delete success!"
      redirect_to users_url
    rescue Exception => e
      logger.info e
    end
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

  def repo
    @repo ||= UserRepository.new
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
