Rails.application.routes.draw do
  get 'profile/edit_skills', to: 'profile#edit_skills'
  get 'profile/(:id)', to: 'profile#show', as: :profile

  devise_for :users, skip: :registrations
  devise_for :candidates, controllers: { registrations: 'candidates/registrations' }, skip: :sessions
  devise_for :companies, controllers: { registrations: 'companies/registrations' }, skip: :sessions
  resources :skill_items, path: 'skills', only: [:create, :destroy]
  root to: 'pages#home'
  get '/sign_up', to: 'pages#signup'
end
