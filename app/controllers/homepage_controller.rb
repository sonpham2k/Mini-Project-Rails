class HomepageController < ActionController::Base
    layout "homepage/master"

    before_action :set_locale

    def default_url_options
        {locale: I18n.locale}
    end

    def dashboard
        render 'resources/homepage/welcome'
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
end
