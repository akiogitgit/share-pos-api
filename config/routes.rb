Rails.application.routes.draw do
  # これないと、devise_token_authのメソッド使えない
  mount_devise_token_auth_for 'User', at: 'auth'
  
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for "User", at: "auth"
      resources :users, only: %i[index show]
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
      resources :scrapings, only: %i[create]
    end
end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
