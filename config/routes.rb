require "sidekiq/web"
require "sidekiq-scheduler/web"

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq" if Rails.env.development?

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "static_pages#top"
  resources :posts
  resources :search_tags, only: %i[index]
  resources :post_templates, only: %i[new create index show edit update destroy]
end
