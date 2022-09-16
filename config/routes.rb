Rails.application.routes.draw do
  resources :products
  root 'home#page'
  # get 'home/page'
end
