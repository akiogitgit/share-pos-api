Rails.application.routes.draw do
  post "login", to: 'sessions#login'
  delete "logout", to: 'sessions#logout'
  resources :posts
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
