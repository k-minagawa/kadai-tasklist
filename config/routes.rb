Rails.application.routes.draw do
  root to: 'toppages#index'

  resources :tasks
  
  resources :users, only: [:new, :create, :destroy]
  get 'signup', to: 'users#new'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
end
