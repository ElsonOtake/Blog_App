Rails.application.routes.draw do
  get 'analytics/index', as: 'analytics'
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :members, controllers: { omniauth_callbacks: 'members/omniauth_callbacks',
                                      sessions: "members/sessions",
                                      registrations: "members/registrations" }
  resources :members, only: %i[index show] do
    resources :posts do
      resources :comments
    end
  end

  root 'members#index'

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
