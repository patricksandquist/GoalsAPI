Rails.application.routes.draw do

  resources :goals
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]
  resources :users, only: [:show] do
    resources :user_comments, only: [:create, :destroy]
  end
end
