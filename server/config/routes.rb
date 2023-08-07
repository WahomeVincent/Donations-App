Rails.application.routes.draw do

# Donors Routes
  get 'donors', to: "charities#show_donors"
  get "charities", to: "charities#index"
  post "charities", to: "charities#create"
  get 'total/:id', to: "charities#show_total_donations"
  get 'anonymous' ,to: "charities#anonymous_donations"
  get 'beneficiaries', to: "charities#show_beneficiaries"
  put 'approve', to: "charities#approve"
  delete'reject', to: "charities#reject"
  # For details on the DSL available within this file, see https://guides.rubyonrails


  # Donations Routes
  post 'donate/:id/:charity_id', to: 'donors#donate'
  post "donors/:user_id", to: "donors#create"
  put 'set_donation_recurring', to: 'donors#set_donation_recurring'
  put 'set_donation_anonymous', to: 'donors#set_donation_anonymous'
  get 'beneficiary_stories', to: 'donors#show_beneficiary_stories'

  # User Authentication Routes
  get "/users/:id", to: "users#show", as: "user"
  post "/register", to: "users#create"
  post "/login", to: "users#authenticate"
  delete "/logout", to: "users#destroy"
  get "/check_login", to: "users#check_login"

  # Account Routes
  resources :accounts, only: [:create, :update, :destroy, :show], param: :id
  get "/userprofile/:user_id", to: "accounts#index"
  put "/userprofile/:user_id/:id", to: "accounts#update"
  delete "/accounts/:user_id/:id", to: "accounts#destroy"
  post "/accounts/:user_id", to: "accounts#create"
  delete "/accounts/:id", to: "accounts#destroy"
end
