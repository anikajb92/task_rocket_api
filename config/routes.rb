Rails.application.routes.draw do
  resources :categories, only: [:index, :create]
  resources :users, only: [:index, :create]
  post '/login', to: 'users#login'
  get '/profile', to: 'users#profile'
end
