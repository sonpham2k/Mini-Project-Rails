Rails.application.routes.draw do
  scope '(:locale)', locale: /en|vi/ do
    get '/login', to: 'authen#login'
    get '/register', to: 'authen#register'
    get '/forgot-password', to: 'authen#forgot_password'
    get '/change-password', to: 'authen#change_forgot_password'

    scope(:path => '/homepages') do
      get '/dashboard', to: 'homepage#dashboard'

      scope(:path => '/posts') do
        get '/index', to: 'post#index'
        get '/new', to: 'post#create'
        get '/edit', to: 'post#edit'
        get '/show', to: 'post#show'
      end

      scope(:path => '/users') do
        get '/index', to: 'user#index'
        get '/new', to: 'user#create'
        get '/edit', to: 'user#edit'
        get '/show', to: 'user#show'
        get '/change-password', to: 'user#change_password'
      end

    end
  end
end
