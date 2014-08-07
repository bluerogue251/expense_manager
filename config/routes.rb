Rails.application.routes.draw do
  root 'dashboard#show'
  resources :expenses, except: [:new, :show]
  resources :users, only: :edit
end
