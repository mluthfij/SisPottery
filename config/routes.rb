Rails.application.routes.draw do
  # get 'keep/show'
  # get 'histories/show'
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
    resources :user_lists, except: :show
    resources :products do
      resources :comments do
        member do
          patch "like", to: "comments#like"
        end
      end
    end
    # c
    get 'bucket', to: 'bucket#show'
    post 'bucket/add'
    post 'bucket/remove'
    # c
    # c
    get 'history', to: 'histories#show'
    post 'histories/add'
    post 'histories/remove'
    # c
    get 'pages/dashboard'
    get 'pages/customer'
    get 'pages/adminlist'
    get 'pages/order'
    get 'pages/message'
    get 'pages/newadmin'
    get 'pages/chatroom/:chatroom_id', to: 'pages#chatroom', as: :chatroom
    get 'pages/chatbox', to: 'pages#chatbox', as: :chatbox
    patch "pages/adminlist/:id", to: "pages#add_admin"
  end
  resources :products, only: %i[ show index ] do
      resources :comments do
        member do
          patch "like", to: "comments#like"
        end
      end
      member do
        patch "upvote", to: "products#upvote"
      end
  end
  get 'pages/about'
  get 'pages/home'
  root 'pages#home'
  # mount ActionCable.server => '/cable'
  mount ActionCable.server, at: '/cable'
end
