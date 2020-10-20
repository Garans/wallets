Rails.application.routes.draw do
  get '/transaction/new_withdraw', to: 'transaction#new_withdraw'
  resources :transaction
  resources :wallet do
    get 'transactions', to: 'transaction#index'
  end
  devise_for :users
  root to: 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
