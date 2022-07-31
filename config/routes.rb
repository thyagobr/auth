Rails.application.routes.draw do
  namespace :api do
    post "/login", to: "sessions#create", format: :json
  end
end
