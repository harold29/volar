Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  root to: "home#index"

  post 'profiles', to: 'profiles#create'
  get 'profile', to: 'profiles#show'
  put 'profile', to: 'profiles#update'
  patch 'profile', to: 'profiles#update'
  resource :profile, only: [:new, :edit]

  # resources :profiles, only: [:new, :create, :edit, :update]
end
