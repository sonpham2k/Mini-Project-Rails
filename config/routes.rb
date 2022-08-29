Rails.application.routes.draw do
  # scope '(:locale)', locale: /en|vi/ do
    get '/login', to: 'authens#new'
    post '/login', to: 'authens#create'
    delete '/logout', to: 'authens#destroy'

    get 'password_resets/new'
    post 'password_resets/create'
    post 'password_resets/update'

    get 'password_resets/change_password'
    get 'password_resets/reset'


    resources :users, :posts
end
