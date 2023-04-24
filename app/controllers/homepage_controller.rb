class HomepageController < ActionController::Base
    layout 'homepages/master'

    before_action :set_locale

    def default_url_options
        {locale: I18n.locale}
    end

    def dashboard
        render 'resources/homepages/dashboard'
    end
end
