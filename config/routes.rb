Rails.application.routes.draw do
  devise_for :users, path: 'auth', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }
  resources :users, :only => [:index, :show]
  resources :follows, :only => [:create, :destroy]
  resources :posts do
    get 'followed', :on => :collection
  end
  root to: "posts#index"
end
