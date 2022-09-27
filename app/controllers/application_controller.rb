class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied, with: :cancan_access_denied
  rescue_from ActiveRecord::RecordNotFound, with: :active_record_record_not_found
  protect_from_forgery with: :exception
  include AuthensHelper
  before_action :require_login, :use_params, :set_locale

  def require_login
    unless logged_in?
      redirect_to login_path
    end
  end

  def use_params
    $params = params
  end

  def set_locale
    locale = params[:locale].to_s.strip.to_sym
    I18n.locale = I18n.available_locales.include?(locale) ?
      locale : I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  private

  def cancan_access_denied
    flash[:danger] = "You are not authorized to access this page."
    redirect_to root_url
  end

  def active_record_record_not_found
    flash[:danger] = "Couldn't find resource."
    redirect_to root_url
  end
end
