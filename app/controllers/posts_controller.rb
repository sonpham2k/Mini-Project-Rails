class PostsController < ApplicationController
    layout 'homepages/master'

    def create
        render '/posts/new'
    end

    def edit
        render '/posts/edit'
    end

    def update
    end

    def destroy
    end

    def index
        render '/posts/index'
    end

    def show
        render '/posts/show'
    end

end
