# frozen_string_literal: true

Rails.application.routes.draw do
  if Rails.env.development?
    require 'sidekiq/web'

    mount Sidekiq::Web => '/sidekiq'
  end

  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

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

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resource :auth, only: %i[create]

      resources :collections, except: %i[new edit]
      resources :contents, except: %i[new edit]

      resources :users, except: %i[index new edit update] do
        post :unlock, on: :member
      end
    end
  end

  namespace :manage do
    resource :profile, only: %i[edit show update]
    resource :site, only: %i[edit show update]

    resources :contents

    resources :users do
      get :reinvite, on: :member
      get :unlock, on: :member
    end

    root to: 'dashboards#show'
  end

  root to: 'homes#show'
end
