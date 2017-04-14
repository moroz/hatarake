Rails.application.routes.draw do
  get 'profile/edit_skills', to: 'profile#edit_skills'
  get 'profile/(:id)', to: 'profile#show', as: :profile

  devise_for :users
  devise_for :candidates, controllers: { registrations: 'candidates/registrations' }
  devise_for :companies, controllers: { registrations: 'companies/registrations' }
  resources :companies, except: [:new, :create]
  resources :candidates, except: [:new, :create]
  resources :skills, only: [:create, :update]
  root to: 'pages#home'
  get '/sign_up', to: 'pages#signup'
end
