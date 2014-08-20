Rails.application.routes.draw do
  root 'dashboard#show'
  patch "/dashboard/change_month/:month", to: "dashboard#change_month", as: "change_dashboard_month"
  get   "/dashboard/readme", to: "dashboard#readme", as: "readme"
  resources :expenses, except: [:new, :show] do
    collection { get :review }
    member { patch :approve, :reject, :pend }
  end
  resources :users, only: [:edit, :update]
end
