Rails.application.routes.draw do
  devise_for :users
  root to: "games#start_or_resume"

  resources :games, only: %i[new create update] do
    resources :rounds, only: %i[new create] do
      get 'adjectives', on: :collection
    end
  end
end
