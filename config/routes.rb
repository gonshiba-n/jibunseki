Rails.application.routes.draw do
  root 'static_pages#top'
  get 'static_pages/top'
  get 'static_pages/login'
  post 'static_pages/login' => 'sessions#create', as: 'login'
  get 'static_pages/signup'
  post 'static_pages/signup' => 'users#create', as: 'signup'
  delete '/logout' => 'sessions#destroy', as: 'logout'
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
