Rails.application.routes.draw do
  devise_for :users

  root "homes#top"

  resource :mypage, only: [:show]

  namespace :users do
    post "guest_login", to: "guest_sessions#create"
  end
end
