# frozen_string_literal: true

Rails.application.routes.draw do
  resources :payment_terms
  resources :flight_offers
  resources :carriers
  resources :flight_searches, only: %i[index show new create]

  # get 'flights_search', to: 'flights_search#search'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  root to: 'home#index'

  post 'profiles', to: 'profiles#create'
  get 'profile', to: 'profiles#show'
  put 'profile', to: 'profiles#update'
  patch 'profile', to: 'profiles#update'
  resource :profile, only: %i[new edit]

  devise_for :users, path: '/users', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  # resources :profiles, only: [:new, :create, :edit, :update]
end
