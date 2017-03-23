Rails.application.routes.draw do
  resources :pins do
    resource :donation, only: [:new]
  end
  resources :users, controllers: "users"
  resources :sessions

  root :to => "pins#index"

  # get "auth/:provider/callback" => "sessions#create_from_omniauth", :as => "fb_sign_in"
  # get "auth/failure" => "pins#index"

  delete "/sign_out" => "sessions#destroy", :as => "sign_out"
  get "/sign_in" => "sessions#new", :as => "sign_in"
  post "/sign_in" => "sessions#create"
  get "/sign_up" => "users#new", :as => "sign_up"
  post "/sign_up" => "users#create"
  get 'donations/new'

  post "/pins/:pin_id/donations/checkout" => 'donations#checkout', as: "checkout"


end
