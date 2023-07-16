Rails.application.routes.draw do
  devise_for :users
  root to: "games#new"

  resources :games, only: %i[create] do
    resources :rounds, only: %i[new create]
  end
end
