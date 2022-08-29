class PostController < ApplicationController
    layout 'homepages/master'

    before_action :set_locale

    def default_url_options
        {locale: I18n.locale}
    end

    def create
        render 'resources/posts/new'
    end

    def edit
        render 'resources/posts/edit'
    end

    def update
    end

    def destroy
    end

    def index
        render 'resources/posts/index'
    end

    def show
        render 'resources/posts/show'
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
