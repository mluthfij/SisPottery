Rails.application.routes.draw do
  devise_for :users
  resources :products, only: %i[ show index ]
  namespace :admin do
    resources :products
  end

  root 'pages#home'
  get 'pages/about'
end
