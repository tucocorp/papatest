# frozen_string_literal: true
Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  root 'welcome#status'

  namespace :api do
    namespace :v1 do
      resources :stores
      resources :products
      resources :orders
    end
  end
end
