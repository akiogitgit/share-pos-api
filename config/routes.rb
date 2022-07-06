Rails.application.routes.draw do
  # これないと、devise_token_authのメソッド使えない
  mount_devise_token_auth_for 'User', at: 'auth'
  
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for "User", at: "auth"
      resources :users, only: %i[index show]
      resources :posts do
        collection do
          get :mypost
        end
      end
      resources :folders
      resources :folder_post_relations
    end
end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
