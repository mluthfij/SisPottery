Rails.application.routes.draw do
  namespace :admin do
    resources :homepagesses, except: :index
    resources :products
    # get 'pages/home'
    get 'pages/about'
    get 'pages/dashboard'
    get 'pages/customer'
    get 'pages/adminlist'
    get 'pages/order'
    get 'pages/message'
    get 'pages/newadmin'
  end
  devise_for :users
  resources :products, only: %i[ show index ]
  get 'pages/dashboard'
  get 'pages/about'
  root 'pages#home'
end
