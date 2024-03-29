Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    namespace :v1, defaults: { format: 'json' } do
      # ==================================
      # Deposits
      # - POST      /deposits
      # ==================================
      resources :deposits, only: [:create]

      # ==================================
      # Withdrawal
      # - POST      /withdrawals
      # ==================================
      resources :withdrawals, only: [:create]
    end
  end

  # ==================================
  # API Docs
  #   - GET     /docs
  # ==================================
  resources :docs, only: [:index]
end
