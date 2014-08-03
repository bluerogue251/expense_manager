Rails.application.routes.draw do
  root 'dashboard#show'
  resources :expenses, except: [:new, :show]
end
