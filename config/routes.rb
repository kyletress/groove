Rails.application.routes.draw do
  root to: 'static_pages#home'

  delete '/logout', to: 'sessions#destroy'
  post '/login', to: 'sessions#create'
  get '/login', to: 'sessions#new'
  post '/signup', to: 'users#create'
  get  '/signup', to: 'users#new'
  get '/admin', to: 'admin#index'
  
  resources :users do 
    post :impersonate, on: :member
    post :stop_impersonating, on: :collection
  end

  namespace :admin do
    resources :users, only: [:index, :show]
  end
end
