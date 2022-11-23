Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :members

  resources :members, only: %i[index show] do
    resources :posts, only: %i[index show new create delete] do
      resources :comments, only: %i[create delete]
      resources :likes, only: %i[create]
    end
  end

  root 'members#index'

  delete '/members/:member_id/posts/:id', to: 'posts#destroy'
  get '/members/:member_id/posts/:post_id/comments/:id', to: 'comments#show', as: 'member_post_comment'
  delete '/members/:member_id/posts/:post_id/comments/:id', to: 'comments#destroy'

  # routes for spec
  get '/members/index'
  get '/members/show'
  get '/posts/index'
  get '/posts/show'
  get '/comments/create'
  get '/likes/create'
  resources :members, param: :_member_id
  post 'api/v1/auth/login', to: 'authentication#login'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :members, only: %i[index show] do
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
