Rails.application.routes.draw do
  resources :user_stocks, only: :create
  delete 'user_stocks/:user/:stock_tracked', to: 'user_stocks#destroy', as: 'user_stock'
  devise_for :users
  root 'welcome#index'
  get 'my_portfolio', to: 'users#my_portfolio'
  get 'search_stock', to: 'stocks#search'
end

