Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :contacts, only: [:index, :show]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.


  resources :contacts #Esta línea crea rutas RESTful para el recurso contacts. Esto genera automáticamente las siguientes rutas:
  # GET /contacts  -index
  # GET /contacts/:id  -show
  # GET /contacts/new  -new
  # POST /contacts  -create
  # GET /contacts/:id/edit  -edit
  # PATCH/PUT /contacts/:id -update
  # DELETE /contacts/:id  -destroy


  get "search", to: "contacts#search"
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
