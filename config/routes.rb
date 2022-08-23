Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    get '/login', to: 'authen#login'
    get '/register', to: 'authen#register'
    get '/forgot-password', to: 'authen#forgot_password'
    get '/change-password', to: 'authen#change_password'

    get '/homepage/welcome', to: 'homepage#dashboard'
  end
end
