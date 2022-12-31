# frozen_string_literal: true

Rails.application.routes.draw do
  root 'landing#index'

  resources :users, only: [:new, :create] do
    resources :discover, only: [:index]
    resources :movies, only: [:index, :show] do
      resources :viewing_parties, only: [:new, :create]
    end
  end

  resources :register, only: [:new, :create], controller: "users"
  
  get '/dashboard', to: 'users#show'
  get '/login', to: 'sessions#new' #change to sessions controller new action
  post '/login', to: 'sessions#create' #change to sessions controller create action
  delete '/logout', to: 'sessions#destroy' #change to sessions controller destroy action
  # resources :sessions, only: [:new, :create, :destroy]
end