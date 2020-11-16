Rails.application.routes.draw do
  devise_for :admin_users, path: 'admin'
  devise_for :users, path: 'user'

  resources :orders, only: [:create] do
    collection do
      post :callback
    end
  end

  get 'cart', to: 'pages#cart'

  namespace :admin do
    resources :products

    root to: 'pages#dashboard'
  end

  root to: "pages#home"
end
