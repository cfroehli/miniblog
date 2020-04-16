# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, path: 'auth', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }
  resources :users, only: %i[index show] do
    post 'follows', to: 'follows#follow', on: :member
    delete 'follows', to: 'follows#unfollow', on: :member
  end
  resources :likes, only: %i[create]
  resources :posts do
    resources :comments, only: %i[create]
    get 'followed', on: :collection
    get 'liked', on: :collection
  end
  root to: 'posts#index'
end
