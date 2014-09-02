Rails.application.routes.draw do
  root 'dashboard#show'
  patch "/dashboard/change_month/:month", to: "dashboard#change_month", as: "change_dashboard_month"
  get   "/dashboard/readme", to: "dashboard#readme", as: "readme"

  resources :expenses, only: :index do
    collection { get :review }
    member { patch :approve, :reject, :pend }
  end

  resources :users, only: [:edit, :update]

  namespace :user do
    resources :expenses, except: :show
  end

  resources :exchange_rates, except: [:new, :show]
end
