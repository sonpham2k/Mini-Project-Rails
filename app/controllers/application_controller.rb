class ApplicationController < ActionController::Base
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
end
