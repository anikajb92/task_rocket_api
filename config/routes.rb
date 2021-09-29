Rails.application.routes.draw do
  resources :tasks
  resources :users, only: [:index, :create]
  post '/login', to: 'users#login'
  get '/profile', to: 'users#profile'
  get '/allinfo', to: 'users#allinfo'
  get '/stats', to: 'users#stats'
  get '/categories', to: 'tasks#categories'
end
