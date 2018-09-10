# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  namespace :admin do
    resources :orders do
      member do
        patch :mark_paid
      end
    end
    resources :avatars do
      member do
        get :crop
      end
    end
  end

  ActiveAdmin.routes(self)
  get '/jobs/abroad', to: 'offers#abroad'
  get '/jobs/poland', to: 'offers#poland'
  get '/jobs/outdated_offer', to: 'offers#no_offer_found'
  get '/premium', to: 'products#index'
  get '/subscribe', to: 'newsletter_subscriptions#new', as: :new_newsletter_subscription
  resource :newsletter_subscription, only: %i[create destroy], path: '/subscribe'
  get '/unsubscribe', to: 'newsletter_subscriptions#unsubscribe'
  get '/regulamin', to: 'pages#tos'
  get '/regulamin/zalacznik1', to: 'pages#appendix1'
  get '/rodo', to: 'pages#rodo'
  get '/contact', to: 'pages#contact'

  resources :offers, path: '/jobs', except: :index do
    member do
      patch :publish
      patch :unpublish
      get :promote
      patch :promote, to: 'offers#add_premium'
    end

    collection do
      patch :batch_action
    end
    resources :applications, only: :create
  end
  post '/jobs/favourite/:offer_id', to: 'offer_saves#create', as: :offer_save
  post '/jobs/send_emai/:offer_id', to: 'offer_saves#email', as: :offer_email
  delete '/unfavourite_offer', to: 'offer_saves#destroy', as: :destroy_offer_save

  resource :cart, only: %i[show destroy], controller: 'cart' do
    patch :finalize
  end
  resources :cart_items, only: %i[create edit update destroy]

  get '/orders/place', to: 'orders#place', as: :place_order

  resources :orders, only: %i[index create show destroy] do
    get :payment
    get :thank_you
  end

  get '/offers/:offer_id/apply', to: 'applications#new', as: :new_offer_application
  get '/my_offers', to: 'offers#my_offers'

  resources :resumes
  get 'candidate/edit_skills', to: 'candidates#edit_skills'
  get 'candidate/edit_profile', to: 'candidates#edit', as: :edit_candidate_profile
  resource :profile, only: :show
  resource :dashboard, only: :show
  resources :education_items, except: %i[new edit]
  resources :work_items, except: %i[new edit]

  scope '/api' do
    get 'skills/(:term)' => 'autocomplete#skills', as: :autocomplete_skills
    get 'professions/(:term)' => 'autocomplete#professions', as: :autocomplete_professions
    get 'schools/(:term)' => 'autocomplete#schools', as: :autocomplete_schools
    get 'organizations/(:term)' => 'autocomplete#organizations', as: :autocomplete_organizations
    get 'provinces/(:country_id)/(:element_id)' => 'provinces#index', as: :provinces
    scope '/dotpay' do
      post 'confirm_payment' => 'dotpay#confirm'
    end
    scope '/jooble' do
      get 'jobs_feed.xml', to: 'feed#jooble'
    end
    scope '/trovit' do
      get 'trovit_feed.xml', to: 'feed#trovit'
    end
    post '/confirm_lfw', to: 'candidates#confirm_lfw'
  end

  devise_scope :candidate do
    get '/sign_up', to: 'candidates/registrations#new'
  end

  devise_for :candidates, controllers: {
    omniauth_callbacks: 'candidates/omniauth_callbacks',
    registrations: 'candidates/registrations', sessions: 'sessions'
  }
  devise_for :companies, controllers: { registrations: 'companies/registrations', sessions: 'sessions' }
  devise_for :users, controllers: { sessions: 'sessions' }, skip: :registrations, path: ''
  resources :candidates do
    get :mailing_list, on: :collection
    resources :favourite_offers, only: [:index]
  end
  get 'favourite_offer/(:candidate_id)/(:offer_id)', to: 'favourite_offers#create', as: 'add_offer_to_favourites'

  resources :companies, only: %i[show index update edit] do
    get :mailing_list, on: :collection
    resources :offers, only: [:index], controller: 'company_offers'
    resources :blog_posts, only: %i[show index create new], path: '/blog'
    member do
      post :vote
    end
  end
  resources :blog_posts, path: '/blog', only: %i[show destroy edit update]
  resources :skill_items, path: 'skills', only: %i[create destroy]
  resources :cv_items, path: 'cv_items', only: %i[create destroy]
  get '/edit_avatar', to: 'avatars#new'
  get '/crop_avatar', to: 'avatars#crop'
  resource :avatar, only: %i[create update]
  root to: 'home#home'
  get '*path', to: 'application#error404'
end
