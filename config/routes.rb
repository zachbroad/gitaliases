Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Public home page showing all aliases
  get "/" => "home#index", as: :home
  root "home#index"

  # User profile routes
  get "profiles" => "profiles#list", as: :profiles
  get "profile/:username" => "profiles#show", as: :profile
  get "profile/:username/aliases" => "profiles#aliases", as: :profile_aliases
  get "me/aliases" => "aliases#index", as: :my_aliases
  get "me" => "profiles#me", as: :me

  # Authenticated user's alias management
  resources :aliases do
    member do
      post :vote
    end
  end
end
