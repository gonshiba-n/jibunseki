Rails.application.routes.draw do
  root 'static_pages#top'

  get 'static_pages/top'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy', as: 'logout'
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
