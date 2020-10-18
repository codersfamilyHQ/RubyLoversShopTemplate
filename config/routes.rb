Rails.application.routes.draw do
  devise_for :admin_users, path: 'admin'
  devise_for :users, path: 'user'

  namespace :admin do
    root to: 'pages#dashboard'
  end

  root to: "pages#home"
end
