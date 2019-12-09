Rails.application.routes.draw do
  devise_for :users, path: 'auth', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }
  resources :users, :only => [:index, :show]
  resources :posts
  root to: "posts#index"
end
