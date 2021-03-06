Rails.application.routes.draw do
  root 'welcome#index'
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]
  resources :listings, controller: "listings" 
  # do
  #   resources :reservations
  # end

  resources :users, controller: "users", only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  resources :reservations, controller: "reservations"

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "users#new", as: "sign_up"
  get "/create_listings" => "listings#new", as: "create_listings"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/auth/:provider/callback" => "sessions#create_from_omniauth" 
  post "/listings/verify" => "listings#verify", as: "verify_listings"
  # get "/listings" => "listings#verify", as: "verified_listings"
  post "/listings/show/:id" => "listings#navigate", as: "navigate_listings" 
  # get "/listing/:id" => "listings#navigate", as: "navigate_listings" 

end
