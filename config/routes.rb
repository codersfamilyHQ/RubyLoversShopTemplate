Rails.application.routes.draw do
  devise_for :users

  namespace :admin do
    resources :products

    root to: 'products#index'
  end

  root to: "pages#home"
end
