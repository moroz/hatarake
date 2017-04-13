Rails.application.routes.draw do
  devise_for :users
  devise_for :candidates, controllers: { registrations: 'candidates/registrations' }
  devise_for :companies, controllers: { registrations: 'companies/registrations' }
  resources :companies, except: [:new, :create]
  resources :candidates, except: [:new, :create]
  root to: 'pages#home'
  get '/sign_up', to: 'pages#signup'
end
