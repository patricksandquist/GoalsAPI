Rails.application.routes.draw do

  resources :goals
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]
end
