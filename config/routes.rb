# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users,
             module: :devise,
             controllers: {
               invitations: 'auth/invitations',
               registrations: 'auth/registrations',
               sessions: 'auth/sessions'
             },
             path: '',
             path_prefix: :manage,
             skip: %i[omniauth_callbacks],
             path_names: {
               sign_in: 'login',
               sign_out: 'logout',
               sign_up: 'register',
               password: 'password',
               confirmation: 'verification',
               unlock: 'unlock'
             }

  if Rails.env.development?
    require 'sidekiq/web'

    mount Sidekiq::Web => '/sidekiq'
  end

  namespace :manage do
    resource :profile, only: %i[edit show update]
    resource :site, only: %i[edit show update]

    resources :pages

    resources :users do
      get :reinvite, on: :member
      get :unlock, on: :member
    end

    root to: 'dashboards#show'
  end

  root to: 'pages#show'
end
