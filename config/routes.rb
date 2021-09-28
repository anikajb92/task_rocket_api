Rails.application.routes.draw do
  resources :tasks
  resources :users, only: [:index, :create]
  post '/login', to: 'users#login'
  get '/profile', to: 'users#profile'
  get '/categories', to: 'tasks#categories'
end
