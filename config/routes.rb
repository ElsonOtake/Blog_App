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
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
