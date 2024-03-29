Rails.application.routes.draw do
  # これないと、devise_token_authのメソッド使えない
  # mount_devise_token_auth_for 'User', at: 'auth'
  
  namespace :api do
    namespace :v1 do
      # mount_devise_token_auth_for "User", at: "auth"
      resources :auth do
        collection do
          post :login
          delete :logout
          post :sign_up
        end
      end

      resources :users, only: %i[index show] do
        collection do
          get :me
        end
        post "follow", to: "user_relations#create"
        delete "follow", to: "user_relations#destroy"
        get "followings", to: "user_relations#followings"
        get "followers", to: "user_relations#followers"
      end

      put "users", to: "users#update" # idを受け取らない
      patch "users", to: "users#update"
      delete "users", to: "users#destroy"
      
      resources :posts do
        collection do
          delete :destroy_all
        end
      end

      resources :folders do
        collection do
          post "bookmarks", to: "folder_post_relations#create"
          delete "bookmarks/:id", to: "folder_post_relations#destroy"
        end
      end

      resources :metas, only: %i[index]
      resources :reply_comments, only: %i[create update destroy]
      
    end
end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
