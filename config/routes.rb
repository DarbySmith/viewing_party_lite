# frozen_string_literal: true

Rails.application.routes.draw do
  root 'landing#index'

  resources :users, only: [:new, :create] 
  resources :register, only: [:new, :create], controller: "users"
  get '/dashboard', to: 'users#show'

  resources :movies, only: [:index, :show] do
    resources :viewing_parties, only: [:new, :create]
  end

  get '/discover', to: 'discover#index'
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end