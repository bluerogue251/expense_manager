Rails.application.routes.draw do
  root 'dashboard#readme'
  patch "/dashboard/change_month/:month", to: "dashboard#change_month", as: "change_dashboard_month"
  get "/dashboard", to: "dashboard#show"

  resources :expenses, except: [:new, :show] do
    collection { get :review }
    member { patch :approve, :reject, :pend }
  end
  resources :users, only: [:edit, :update]
  resources :exchange_rates, except: [:new, :show]
end
