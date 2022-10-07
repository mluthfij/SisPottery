Rails.application.routes.draw do
  devise_for :users
  resources :chatrooms, except: :index
  resources :messages, only: %i[ new create ]
  resources :profiles, only: :show
  get 'cart', to: 'cart#show'
  post 'cart/addcart'
  post 'cart/add'
  post 'cart/removecart'
  post 'cart/remove'
  post 'cart/delete'
  get 'comments/comment'
  namespace :admin do
    resources :messages, only: %i[ new create ]
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

    get 'pages/chatroom/:chatroom_id', to: 'pages#chatroom', as: :chatroom
    get 'pages/chatbox', to: 'pages#chatbox', as: :chatbox
  
  end
  resources :products, only: %i[ show index ] do
      resources :comments
  end
  get 'pages/about'
  get 'pages/home'
  root 'pages#home'
  # mount ActionCable.server => '/cable'
  mount ActionCable.server, at: '/cable'
end
