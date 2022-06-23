Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  post "login", to: 'sessions#login'
  delete "logout", to: 'sessions#logout'
  resources :posts
  resources :users
  namespace :v1 do
    mount_devise_token_auth_for "User", at: "auth"
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
