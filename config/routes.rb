Rails.application.routes.draw do
  resources :rights
  resources :languages
  resources :items
  resources :events
  resources :comments
  resources :users
  #get "up" => "rails/health#show", as: :rails_health_check
  resource :session
  resource :password_reset
  resource :password
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'import_user', to: 'admin#import_user'
  root "main#index"
end
