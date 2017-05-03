Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root "restaurants#index"
  resources :restaurants do
    resources :reviews
  end
end
