Rails.application.routes.draw do
  devise_for :users
  resources :chatrooms, except: :index
  resources :messages, only: %i[ new create ]
  resources :profiles, only: :show do
    member do
      post :upload_avatar
      delete :purge_avatar
    end
  end
  namespace :admin do
    resources :messages, only: %i[ new create ]
    resources :homepagesses, except: :index
    resources :abouts, except: %i[ show new ]
    resources :user_lists, except: :show
    resources :products do
      collection do
        match 'search' => 'products#search', via: [:get, :post], as: :search
      end
      resources :comments do
        member do
          patch "like", to: "comments#like"
        end
      end
    end
    post 'faileds/removecart'
    post 'faileds/removebucket'
    post 'histories/add'
    post 'histories/remove'
    post 'faileds/add_cart'
    post 'faileds/add_bucket'
    post 'bucket/add'
    post 'bucket/remove'
    get 'failed', to: 'faileds#show'
    get 'bucket', to: 'bucket#show'
    get 'history', to: 'histories#show'
    get 'pages/dashboard'
    get 'pages/customer'
    get 'pages/adminlist'
    get 'pages/order'
    get 'pages/message'
    get 'pages/newadmin'
    get 'pages/chatroom/:chatroom_id', to: 'pages#chatroom', as: :chatroom
    get 'pages/chatbox', to: 'pages#chatbox', as: :chatbox
    patch "pages/adminlist/:id", to: "pages#add_admin"
    patch "products/stock/:id", to: "products#stock", as: :stock
    patch "products/preorder/:id", to: "products#preorder", as: :preorder
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
  post 'faileds/add'
  post 'cart/cart_update'
  post 'cart/addcart'
  post 'cart/add'
  post 'cart/removecart'
  post 'cart/remove'
  post 'cart/delete'
  get 'failed', to: 'faileds#show'
  get 'bucket', to: 'bucket#show'
  get 'history', to: 'histories#show'
  get 'cart', to: 'cart#show'
  get 'comments/comment'
  get 'pages/about'
  get 'pages/home'
  root 'pages#home'
  mount ActionCable.server, at: '/cable'
end
