Rails.application.routes.draw do
  # scope '(:locale)', locale: /en|vi/ do

    get '/login', to: 'authens#new'
    post '/login', to: 'authens#create'
    delete '/logout', to: 'authens#destroy'
    get '/forgot-password', to: 'authens#forgot_password'
    get '/change-password', to: 'authens#change_forgot_password'

    resources :users
    resources :posts

      # get '/change-password', to: 'user#change_password'
    # end
    
    # scope(:path => '/homepages') do
    #   get '/dashboard', to: 'homepage#dashboard'

    #   scope(:path => '/posts') do
    #     get '/index', to: 'post#index'
    #     get '/new', to: 'post#create'
    #     get '/edit', to: 'post#edit'
    #     get '/show', to: 'post#show'
    #   end

    #   scope(:path => '/users') do
    #     get '/index', to: 'user#index'
    #     get '/edit', to: 'user#edit'
    #     get '/show', to: 'user#show'
    #     get '/change-password', to: 'user#change_password'
    #   end

    # end
  # end
end
