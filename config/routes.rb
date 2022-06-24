Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  resources :posts do
    collection do
      get :mypost
    end
  end
  resources :users
  namespace :v1 do
    mount_devise_token_auth_for "User", at: "auth"
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
