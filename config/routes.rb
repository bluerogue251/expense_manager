Rails.application.routes.draw do
  root 'dashboard#show'
  patch "/dashboard/change_month/:month", to: "dashboard#change_month", as: "change_dashboard_month"
  get   "/dashboard/readme", to: "dashboard#readme", as: "readme"
  resources :users, only: [:edit, :update]
  resources :exchange_rates, except: [:new, :show]
  resources :expenses, only: :index do
    collection { get :review }
  end


  namespace :api do
    namespace :v1 do
      resources :expenses, except: [:new, :show] do
        collection { get :review }
        member { patch :approve, :reject, :pend }
      end
    end
  end

  get '*path', to: 'dashboard#readme'
end
