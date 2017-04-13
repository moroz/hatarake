Rails.application.routes.draw do
  devise_for :users
  resources :companies
  resources :candidates
  root to: 'pages#home'
  get '/sign_up', to: 'pages#signup'
end
