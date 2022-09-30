Rails.application.routes.draw do
  devise_for :users

  resources :users, only: %i[index show] do
    resources :posts, only: %i[index show new create delete] do
      resources :comments, only: %i[create delete]
      resources :likes, only: %i[create]
    end
  end

  root 'users#index'

  delete '/users/:user_id/posts/:id', to: 'posts#destroy'
  get '/users/:user_id/posts/:post_id/comments/:id', to: 'comments#show', as: 'user_post_comment'
  delete '/users/:user_id/posts/:post_id/comments/:id', to: 'comments#destroy'

  resources :users, param: :_user_id
  post 'api/v1/auth/login', to: 'authentication#login'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: %i[index show] do
        resources :posts, only: %i[index show] do
          resources :comments, only: %i[index show create]
        end
      end
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
