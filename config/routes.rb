Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :members

  resources :members, only: %i[index show] do
    resources :posts, only: %i[index show new create destroy] do
      resources :comments, only: %i[show create destroy]
      resources :likes, only: %i[create]
    end
  end

  root 'members#index'

  # routes for spec
  get '/members/index'
  get '/members/show'
  get '/posts/index'
  get '/posts/show'
  get '/comments/create'
  get '/likes/create'
  # resources :members, param: :_member_id
  post 'api/v1/auth/login', to: 'authentication#login'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :members, only: %i[index show] do
        resources :posts, only: %i[index show] do
          resources :comments, only: %i[index show create]
          resources :likes, only: %i[create destroy]
        end
      end
    end
  end
end
