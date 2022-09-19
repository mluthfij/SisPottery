Rails.application.routes.draw do
  devise_for :users
  resources :products, only: %i[ show index ]
  namespace :admin do
    resources :products
    get 'pages/home'
    get 'pages/about'
    get 'pages/dashboard'
  end


  root 'pages#home'
  get 'pages/dashboard'
  get 'pages/about'
end
