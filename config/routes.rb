# frozen_string_literal: true

Rails.application.routes.draw do
  get 'api/get_stats', to: 'api/users#show', defaults: { format: :json }
  root 'static_pages#root'
end
