# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :games, only: %i[create index]
    resources :users, only: [:index]
  end

  get 'api/get_stats', to: 'api/users#show', defaults: { format: :json }
  get 'api/search', to: 'api/users#search', defaults: { format: :json }
  post 'api/gamble', to: 'api/users#gamble', defaults: { format: :json }
  post 'api/games/:id', to: 'api/games#update', defaults: { format: :json}
  root 'static_pages#root'
end
