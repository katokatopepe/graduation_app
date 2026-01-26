Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  get    "/login",  to: "user_sessions#new"
  delete "/logout", to: "user_sessions#destroy"

  root "user_sessions#new"
  resource :user_session, only: %i[new create destroy]

  get "dashboard", to: "dashboards#show"

end
