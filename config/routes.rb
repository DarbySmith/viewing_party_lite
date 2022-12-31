# frozen_string_literal: true

Rails.application.routes.draw do
  root 'landing#index'

  resources :users, only: [:new, :create] 
    # resources :discover, only: [:index]
    resources :movies, only: [:index, :show] do
      resources :viewing_parties, only: [:new, :create]
    end
  # end

  resources :register, only: [:new, :create], controller: "users"
  get '/dashboard', to: 'users#show'
  
  get '/discover', to: 'discover#index'

  # get '/movies', to: 'movies#index'
  # get '/movies/:id', to: 'movies#show'
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  # get '/movies/:id/viewing_parties/new', to: 'viewing_parties#new'
  # post '/movies/:id/viewing_parties', to: 'viewing_parties#create'
end