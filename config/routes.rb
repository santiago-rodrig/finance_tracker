Rails.application.routes.draw do
  resources :user_stocks, only: :create
  delete 'user_stocks/:user/:stock_tracked', to: 'user_stocks#destroy', as: 'user_stock'
  devise_for :users
  root 'welcome#index'
  get 'my_portfolio', to: 'users#my_portfolio'
  get 'my_friends', to: 'users#my_friends'
  get 'search_stock', to: 'stocks#search'
  get 'search_friend', to: 'users#search_friend'
  post 'friendships', to: 'friendships#create'
  get 'friendships', to: 'friendships#index'
  delete 'friendship', to: 'friendships#destroy'
  resources :users, only: :show
  mount ActionCable.server, at: '/cable'
end

