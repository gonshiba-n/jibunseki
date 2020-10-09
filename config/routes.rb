Rails.application.routes.draw do
  root 'static_pages#top'
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  get 'static_pages/top'
  get 'static_pages/signup'
  get 'static_pages/login'
  post 'static_pages/top' => 'users#create', as: "signup"
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
