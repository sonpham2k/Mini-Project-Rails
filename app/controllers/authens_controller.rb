class AuthensController < ApplicationController
  layout :resolve_layout

  skip_before_action :require_login, only: [:new, :create, :forgot_password, :change_forgot_password]

  # before_action :set_locale

  # def default_url_options
  #     {locale: I18n.locale}
  # end

  def new
  end

  def create
      user = User.find_by email: params[:authens][:email_address]
      if user && user.authenticate(params[:authens][:password])
          log_in user
          redirect_to user
      else
          flash[:danger] = "Invalid email/password combination"
          redirect_to login_path
      end
  end

  def destroy
      log_out
      flash[:success] = "You are logged out"
      redirect_to login_path
  end

  def forgot_password
      render '/authens/forgot_password'
  end

  def change_forgot_password
      render '/authens/change_forgot_password'
  end

  private
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
          when 'new', 'logout', 'register', 'forgot_password', 'change_forgot_password'
            'authen/master'
          else
            'homepages/master'
          end
      end
end
