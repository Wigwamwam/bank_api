# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :bank_accounts, only: [ :index, :new, :create, :update, :destroy]
    end
  end
  # Defines the root path route ("/")
  # root "articles#index"
end
