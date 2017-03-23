Rails.application.routes.draw do
  resources :pins
  resources :users, controllers: "users"
  resources :sessions

  root :to => "pins#index"

  post "auth/:provider/callback" => "sessions#create"
  get "auth/failure" => "pins#index"

  delete "/sign_out" => "sessions#destroy", :as => "sign_out"
  get "/sign_in" => "sessions#new", :as => "sign_in"
  post "/sign_in" => "sessions#create"
  get "/sign_up" => "users#new", :as => "sign_up"
  post "/sign_up" => "users#create"
end
