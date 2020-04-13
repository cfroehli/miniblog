# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, path: 'auth', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }
  resources :users, only: %i[index show]
  resources :follows, only: %i[create destroy]
  resources :likes, only: [:create]
  resources :posts do
    resources :comments, only: [:create]
    get 'followed', on: :collection
    get 'liked', on: :collection
  end
  root to: 'posts#index'
end
