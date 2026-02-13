Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root "user_sessions#new"

  resource :user_session, only: %i[new create destroy]
  get "/logout", to: redirect("/")

  get    "/login",  to: "user_sessions#new"
  delete "/logout", to: "user_sessions#destroy"

  resources :users, only: %i[new create]

  resource :dashboard, only: :show

  resources :games, only: %i[new create show edit update destroy]

end
