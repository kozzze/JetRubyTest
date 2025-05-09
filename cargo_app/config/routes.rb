Rails.application.routes.draw do
  root "orders#new"

  resources :orders, only: [:new, :create, :show, :index]

  devise_for :admin_users
  ActiveAdmin.routes(self)  
end