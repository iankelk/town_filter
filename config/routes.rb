TownFilter::Application.routes.draw do
  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"},
              		 controllers: {omniauth_callbacks: "omniauth_callbacks"}
  resources :users
end