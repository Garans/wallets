Rails.application.routes.draw do
  get '/transaction/new_withdraw', to: 'transaction#new_withdraw'
  resources :transaction
  resources :wallet do
    get 'transactions', to: 'transaction#index'
    get 'balance', to: 'wallet#balance'
  end
  devise_for :users, controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations',
  }

  # devise_for :users
  root to: 'wallet#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
