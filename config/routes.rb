Rails.application.routes.draw do
  devise_for :users

  root to: "projects#index"

  resources :projects do
    get 'join'
    post 'create_comment'
  end

  resources :comments, only: [:new, :create]
  resources :replies, only: [:new, :create]
end
