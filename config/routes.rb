Rails.application.routes.draw do
  root 'dashboard#show'
  resources :expenses, except: [:new, :show] do
    collection { get :review }
    member { patch :approve, :reject, :pend }
  end
  resources :users, only: [:edit, :update]
end
