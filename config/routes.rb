# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace :v1, defaults: { format: :json } do
    resources :bank_accounts, only: %i[index create destroy]
  end
  # Defines the root path route ("/")
  # root "articles#index"
end
