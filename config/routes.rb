Rails.application.routes.draw do
  get '/offers/poland', to: 'offers#poland'
  get '/offers/abroad', to: 'offers#index'
  resources :offers, except: :index do
    member do
      patch :publish
      patch :unpublish
    end
    resources :applications
    resources :offer_saves, only: [:create]
  end
  resources :resumes
  delete '/offer_saves', to: 'offer_saves#destroy', as: :destroy_offer_save
  get 'candidate/edit_skills', to: 'candidates#edit_skills'
  get 'candidate/edit_profile', to: "candidates#edit", as: :edit_candidate_profile
  resource :profile, only: :show
  resource :dashboard, only: :show
  resources :pages
  resources :education_items
  resources :work_items
  scope '/api' do
    get 'skills/(:term)' => 'autocomplete#skills', as: :autocomplete_skills
    get 'professions/(:term)' => 'autocomplete#professions', as: :autocomplete_professions
    get 'provinces/(:country_id)' => 'provinces#index', as: :provinces
  end

  devise_for :candidates, controllers: { registrations: 'candidates/registrations', sessions: 'sessions' }
  devise_for :companies, controllers: { registrations: 'companies/registrations', sessions: 'sessions' }
  devise_for :users, controllers: { sessions: 'sessions' }, skip: :registrations, path: ''
  resources :candidates
  resources :companies, only: [:show,:index,:update,:edit]
  resources :skill_items, path: 'skills', only: [:create, :destroy]
  resources :cv_items, path: 'cv_items', only: [:create, :destroy]
  get '/edit_avatar', to: 'avatars#new'
  resource :avatar, only: :create
  root to: 'home#home'
  get '/sign_up', controller: :pages, action: :show, id: 'sign_up'
end
