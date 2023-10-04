Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"

  get '/weather/:zip_code', to: 'weather#index'
  get '/weather/interactions/:zip_code', to: 'weather#with_interactions'

end
