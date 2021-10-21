Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :projects, only: %i[create]
      resources :currency_rates, only: %i[index show]
    end
  end
end
