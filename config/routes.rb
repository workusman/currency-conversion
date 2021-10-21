require 'sidekiq/web'
require 'sidekiq-scheduler/web'

# Configure Sidekiq-specific session middleware
Sidekiq::Web.use ActionDispatch::Cookies
Sidekiq::Web.use ActionDispatch::Session::CookieStore, key: "_interslice_session"

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :projects, only: %i[create]
      resources :currency_rates, only: %i[index show]
      get 'currency/conversion', to: 'currency_rates#conversion'
    end
  end
end
