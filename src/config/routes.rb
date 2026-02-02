Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root "user_sessions#new"

  resource :user_session, only: %i[new create destroy]
  get    "/login",  to: "user_sessions#new"
  delete "/logout", to: "user_sessions#destroy"

  get "dashboard", to: "dashboards#show"

  resources :users, only: %i[new create]

end
