Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  namespace :admin do
    resources :orders
  end
  ActiveAdmin.routes(self)
  get '/jobs/abroad', to: 'offers#abroad'
  get '/jobs/poland', to: 'offers#poland'
  get '/premium', to: 'products#index'
  get '/subscribe', to: 'newsletter_subscriptions#new', as: :new_newsletter_subscription
  resource :newsletter_subscription, only: [:create, :destroy], path: '/subscribe'
  get '/unsubscribe', to: 'newsletter_subscriptions#unsubscribe'

  resources :offers, path: '/jobs', except: :index do
    member do
      patch :publish
      patch :unpublish
      post :save
    end

    collection do
      patch :update_many
    end
    resources :applications, only: :create
  end

  resource :cart, only: [:show, :destroy], controller: 'cart' do
    patch :finalize
  end
  resources :cart_items, only: [:create, :edit, :update, :destroy]

  get '/orders/place', to: 'orders#place', as: :place_order

  resources :orders, only: [:index, :create, :show] do
    get :payment
    get :thank_you
  end

  get '/offers/:offer_id/apply', to: 'applications#new', as: :new_offer_application
  get '/my_offers', to: 'offers#my_offers'

  resources :resumes
  #delete '/offer_saves', to: 'offer_saves#destroy', as: :destroy_offer_save
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
