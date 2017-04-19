Rails.application.routes.draw do
  resources :offers
  get 'profile/edit_skills', to: 'candidates#edit_skills'
  get 'profile/edit_education', to: 'candidates#edit_education'
  get 'profile/edit_work', to: 'candidates#edit_work'
  get 'profile/(:id)', to: 'candidates#show', as: :profile
  get '/company', to: 'companies#show', as: :company_profile

  devise_for :users, skip: :registrations
  devise_for :candidates, controllers: { registrations: 'candidates/registrations' }, skip: :sessions
  devise_for :companies, controllers: { registrations: 'companies/registrations' }, skip: :sessions
  resources :skill_items, path: 'skills', only: [:create, :destroy]
  resources :cv_items, path: 'cv_items', only: [:create, :destroy]
  resource :avatar, only: [:new, :create]
  root to: 'pages#home'
  get '/sign_up', to: 'pages#show', params: { permalink: 'sign_up' }
end
