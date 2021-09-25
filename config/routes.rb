Rails.application.routes.draw do
  resources :tasks, only: [:index, :create]
  resources :users, only: [:index, :create, :update]
  post '/login', to: 'users#login'
  get '/profile', to: 'users#profile'
end
