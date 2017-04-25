Rails.application.routes.draw do
  resources :offers
  get 'profile/edit_skills', to: 'candidates#edit_skills'
  get 'profile/step2', to: "candidates#step2", as: :step2
  get 'profile', to: 'candidates#show', as: :profile
  get '/company', to: 'companies#show', as: :company_profile
  resources :pages
  resources :candidates
  resources :education_items
  resources :work_items
  scope '/api' do
    get 'skills/(:term)' => 'autocomplete#skills', as: :autocomplete_skills
  end

  devise_for :users, skip: :registrations
  devise_for :candidates, controllers: { registrations: 'candidates/registrations' }, skip: :sessions
  devise_for :companies, controllers: { registrations: 'companies/registrations' }, skip: :sessions
  resources :skill_items, path: 'skills', only: [:create, :destroy]
  resources :cv_items, path: 'cv_items', only: [:create, :destroy]
  resource :avatar, only: [:new, :create]
  root to: 'pages#show', id: "home"
  get '/sign_up', controller: :pages, action: :show, id: 'sign_up'
end
