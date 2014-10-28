Rails.application.routes.draw do
  root "dashboard#readme"
  patch "/dashboard/change_month/:month", to: "dashboard#change_month", as: "change_dashboard_month"
  get "/dashboard", to: "dashboard#show"

  resources :expenses, only: :index do
    member { patch :approve, :reject, :pend }
  end

  resources :users, only: [:edit, :update]
  resources :exchange_rates, except: [:new, :show]

  namespace :current_user do
    resources :expenses, only: [:index, :create, :edit, :update, :destroy]
  end

  # In case this was linked to before the readme became the root_path
  get "/dashboard/readme", to: "dashboard#readme"
end
