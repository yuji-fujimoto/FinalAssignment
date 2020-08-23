Rails.application.routes.draw do
  root to: 'toppages#index'
  
  # ログイン
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  # users
  get 'signup', to: 'users#new'
  resources :users, only: [:show, :create, :edit, :update, :destroy]
  
  # items
  resources :items
  
  # outfits
  resources :outfits

end