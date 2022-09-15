class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include AuthensHelper
  before_action :require_login, :use_params

  def require_login
    unless logged_in?
      redirect_to login_path
    end
  end

  def use_params
    $params = params
  end
end
