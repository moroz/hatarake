Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :subscriptions
  get '/offers/poland', to: 'offers#poland'
  resources :offers do
    member do
      patch :publish
      patch :unpublish
      post :save
    end
    resources :applications
  end
  resources :resumes
  delete '/offer_saves', to: 'offer_saves#destroy', as: :destroy_offer_save
  get 'candidate/edit_skills', to: 'candidates#edit_skills'
  get 'candidate/edit_profile', to: "candidates#edit", as: :edit_candidate_profile
  resource :profile, only: :show
  resource :dashboard, only: :show
  resources :pages
  resources :education_items, except: [:new, :edit]
  resources :work_items, except: [:new, :edit]
  scope '/api' do
    get 'skills/(:term)' => 'autocomplete#skills', as: :autocomplete_skills
    get 'professions/(:term)' => 'autocomplete#professions', as: :autocomplete_professions
    get 'schools/(:term)' => 'autocomplete#schools', as: :autocomplete_schools
    get 'organizations/(:term)' => 'autocomplete#organizations', as: :autocomplete_organizations
    get 'provinces/(:country_id)' => 'provinces#index', as: :provinces
  end

  devise_for :candidates, controllers: { registrations: 'candidates/registrations', sessions: 'sessions' }
  devise_for :companies, controllers: { registrations: 'companies/registrations', sessions: 'sessions' }
  devise_for :users, controllers: { sessions: 'sessions' }, skip: :registrations, path: ''
  resources :candidates
  resources :companies, only: [:show,:index,:update,:edit] do
    resources :offers, only: [:index], controller: 'company_offers'
    member do
      post :vote
    end
  end
  resources :skill_items, path: 'skills', only: [:create, :destroy]
  resources :cv_items, path: 'cv_items', only: [:create, :destroy]
  get '/edit_avatar', to: 'avatars#new'
  get '/crop_avatar', to: 'avatars#crop'
  resource :avatar, only: [:create, :update]
  root to: 'home#home'
  get '/sign_up' => 'pages#sign_up'
end
