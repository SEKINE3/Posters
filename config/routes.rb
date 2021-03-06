Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to => 'posts#index'
  get 'post/search' => 'posts#search'

  resources :users
  resources :posts, only: [:index, :show, :create, :destroy] do
    resource :comments, only: [:create]
  end
  resources :comments, only: [:destroy]
  resources :relationships
  resources :favorites, only: [:create, :destroy]
  resources :notifications, only: [:index, :create, :destroy]
end
