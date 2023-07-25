Rails.application.routes.draw do
  devise_for :users
  root to: "games#new"

  resources :games, only: %i[create update] do
    resources :rounds, only: %i[new create] do
      get 'adjectives', on: :collection
    end
  end
end
