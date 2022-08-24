class AuthenController < ActionController::Base
    layout :resolve_layout

    before_action :set_locale

    def default_url_options
        {locale: I18n.locale}
    end

    def login
        render 'resources/authen/login'
    end

    def register
        render 'resources/authen/register'
    end

    def forgot_password
        render 'resources/authen/forgot_password'
    end

    def change_forgot_password
        render 'resources/authen/change_forgot_password'
    end

    private
        def set_locale
            I18n.locale = params[:locale] || I18n.default_locale
        end
    
        def set_locale
            locale = params[:locale].to_s.strip.to_sym
            I18n.locale = I18n.available_locales.include?(locale) ?
                locale : I18n.default_locale
        end

        def resolve_layout
            case action_name
            when 'login', 'logout', 'register', 'forgot_password', 'change_forgot_password'
              'authen/master'
            else
              'homepages/master'
            end
        end
end
