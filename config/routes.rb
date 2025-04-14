Rails.application.routes.draw do
  resource :session, only: %i[new create destroy]
  resource :onboarding, only: %i[new create]

  resources :transactions, only: %i[index destroy]
  resources :expenses, only: %i[new edit create update]
  resources :categories, only: %i[index new edit create update]

  namespace :search do
    namespace :transactions do
      resources :suggestions, only: %i[index]
    end
  end

  resources :qr_code, only: :show

  get "join/:join_code", to: "settings/users#new", as: :join
  post "join/:join_code", to: "settings/users#create"

  resources :settings, only: %i[ index ] do
    collection do
      resources :users, module: :settings
      resource :join_codes, module: :settings, only: %i[ create ]
    end
  end

  scope :my, module: :settings do
    resource :profile, only: %i[ edit update ]
    resource :avatar, only: %i[ create destroy ]
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "transactions#index"
end
