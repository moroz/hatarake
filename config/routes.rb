Rails.application.routes.draw do
  resources :offers do
    member do
      patch :publish
      patch :unpublish
    end
    resources :applications
    resources :offer_saves, only: [:create]
  end
  delete '/offer_saves', to: 'offer_saves#destroy', as: :destroy_offer_save
  get 'profile/edit_skills', to: 'candidates#edit_skills'
  get 'profile/step2', to: "candidates#step2", as: :candidate_step2
  get 'profile', to: 'profile#profile'
  get 'candidates/dashboard', to: 'candidates/dashboard#show', as: 'candidate_dashboard'
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
  resource :avatar, only: [:new, :create]
  root to: 'home#home'
  get '/sign_up', controller: :pages, action: :show, id: 'sign_up'
end
