Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :subscriptions
  resources :payments, only: [:create, :show]
  post '/dotpay_payment/:token' => 'dotpay#payment', as: :dotpay_payment
  get '/jobs/abroad', to: 'offers#abroad'
  get '/jobs/poland', to: 'offers#poland'
  get '/premium', to: 'subscriptions#index'

  resources :offers, path: '/jobs' do
    member do
      patch :publish
      patch :unpublish
      post :save
    end
    resources :applications, except: :new
  end
  get '/offers/:offer_id/apply', to: 'applications#new', as: :new_offer_application
  get '/my_offers', to: 'offers#my_offers'
  get '/my_offer_applications', to: 'applications#my_offer_applications'
  resources :applications, only: :show
  resources :resumes
  delete '/offer_saves', to: 'offer_saves#destroy', as: :destroy_offer_save
  get 'candidate/edit_skills', to: 'candidates#edit_skills'
  get 'candidate/edit_profile', to: "candidates#edit", as: :edit_candidate_profile
  resource :profile, only: :show
  resource :dashboard, only: :show
  resources :education_items, except: [:new, :edit]
  resources :work_items, except: [:new, :edit]
  scope '/api' do
    get 'skills/(:term)' => 'autocomplete#skills', as: :autocomplete_skills
    get 'professions/(:term)' => 'autocomplete#professions', as: :autocomplete_professions
    get 'schools/(:term)' => 'autocomplete#schools', as: :autocomplete_schools
    get 'organizations/(:term)' => 'autocomplete#organizations', as: :autocomplete_organizations
    get 'provinces/(:country_id)' => 'provinces#index', as: :provinces
    scope '/dotpay' do
      post 'confirm_payment' => 'dotpay#confirm'
    end
    scope '/jooble' do
      get 'jobs_feed.xml', to: 'jooble#feed'
    end
  end

  devise_scope :candidate do
    get '/sign_up', to: 'candidates/registrations#new'
  end

  devise_for :candidates, controllers: { registrations: 'candidates/registrations', sessions: 'sessions' }
  devise_for :companies, controllers: { registrations: 'companies/registrations', sessions: 'sessions' }
  devise_for :users, controllers: { sessions: 'sessions' }, skip: :registrations, path: ''
  resources :candidates
  resources :companies, only: [:show,:index,:update,:edit] do
    resources :offers, only: [:index], controller: 'company_offers'
    resources :blog_posts, only: [:show, :index, :create, :new], path: '/blog'
    member do
      post :vote
    end
  end
  resources :blog_posts, path: '/blog', only: [:show, :destroy, :edit, :update]
  resources :skill_items, path: 'skills', only: [:create, :destroy]
  resources :cv_items, path: 'cv_items', only: [:create, :destroy]
  get '/edit_avatar', to: 'avatars#new'
  get '/crop_avatar', to: 'avatars#crop'
  resource :avatar, only: [:create, :update]
  root to: 'home#home'
end
