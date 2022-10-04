Rails.application.routes.draw do
  get 'cart', to: 'cart#show'
  post 'cart/addcart'
  post 'cart/add'
  post 'cart/removecart'
  post 'cart/remove'
  post 'cart/delete'
  get 'comments/comment'
  resources :profiles, only: :show
  namespace :admin do
    resources :homepagesses, except: :index
    resources :abouts, except: :show
    resources :products do
      resources :comments
    end
    get 'pages/dashboard'
    get 'pages/customer'
    get 'pages/adminlist'
    get 'pages/order'
    get 'pages/message'
    get 'pages/newadmin'
  end
  devise_for :users
  resources :products, only: %i[ show index ] do
      resources :comments
  end
  get 'pages/about'
  get 'pages/home'
  root 'pages#home'
end
