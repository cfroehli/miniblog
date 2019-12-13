Rails.application.routes.draw do
  devise_for :users, path: 'auth', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }
  resources :users, only: [:index, :show]
  resources :follows, only: [:create, :destroy]
  resources :likes, only: [:create]
  resources :posts do
    resources :comments, only: [:create]
    get 'followed', on: :collection
    get 'liked', on: :collection
  end
  root to: "posts#index"
end
