Rails.application.routes.draw do
  devise_for :users

  root to: 'courses#index'

  resources :users, only: :show
  resources :courses, only: %i(index show)
  resources :votes, only: %i(create destroy)

  namespace :admin do
    root to: 'courses#index'
    resources :courses
  end
end
