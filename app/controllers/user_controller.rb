class UserController < ActionController::Base
    layout 'homepages/master'

    before_action :set_locale

    def default_url_options
        {locale: I18n.locale}
    end

    def create
        render 'resources/users/new'
    end

    def edit
        render 'resources/users/edit'
    end

    def update
    end

    def destroy
    end

    def index
        render 'resources/users/index'
    end

    def show
        render 'resources/users/show'
    end

    def change_password
        render 'resources/users/change_password'
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
