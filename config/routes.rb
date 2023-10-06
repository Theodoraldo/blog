Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :users, only: [] do
        resources :posts, only: [:index] do
         resources :comments, only: [:index, :create]
        end
      end    
    end
  end
  # Defines the root path route ("/")
  root "users#index"

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show]
  end

  resources :posts, only: [:new, :create, :destroy]
  resources :comments, only: [:destroy]

  post '/posts/:post_id/comments', to: 'comments#create', as: 'post_comments'
  post '/posts/:post_id/likes', to: 'likes#create', as: 'post_likes'
end
