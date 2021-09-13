Rails.application.routes.draw do
  resources :users, only: [:index, :create]
  post '/login', to: 'users#login'
end
