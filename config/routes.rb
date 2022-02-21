# frozen_string_literal: true

Rails.application.routes.draw do
  concern :repositionable do
    post :reposition, on: :collection
  end

  concern :restoreable do
    post :restore, on: :member
  end

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

      resources :contents, except: %i[new edit] do
        post :restore
      end

      resources :users, except: %i[index new edit update] do
        post :unlock, on: :member
      end
    end
  end

  namespace :manage do
    resource :profile, only: %i[edit show update] do
      post :retoken, on: :member
    end

    resource :site, only: %i[edit show update]

    resources :collections, concerns: %i[restoreable] do
      resources :collection_entries, controller: 'collections/collection_entries',
                                     concerns: %i[restoreable repositionable]
    end

    resources :contents, concerns: %i[restoreable]

    resources :sites, only: [] do
      get :switch, on: :member
    end

    resources :users do
      get :reinvite, on: :member
      post :retoken, on: :member
      get :unlock, on: :member
    end

    root to: 'dashboards#show'
  end

  root to: 'homes#show'
end
