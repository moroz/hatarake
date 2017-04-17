Rails.application.routes.draw do
  get 'profile/edit_skills', to: 'profile#edit_skills'
  get 'profile/edit_education', to: 'profile#edit_education'
  get 'profile/edit_work', to: 'profile#edit_work'
  get 'profile/(:id)', to: 'profile#show', as: :profile

  devise_for :users, skip: :registrations
  devise_for :candidates, controllers: { registrations: 'candidates/registrations' }, skip: :sessions
  devise_for :companies, controllers: { registrations: 'companies/registrations' }, skip: :sessions
  resources :skill_items, path: 'skills', only: [:create, :destroy]
  resources :cv_items, path: 'cv_items', only: [:create, :destroy]
  resource :avatar, only: [:new, :create]
  root to: 'pages#home'
  get '/sign_up', to: 'pages#signup'
end
