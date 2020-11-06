Rails.application.routes.draw do
  root 'static_pages#top'

  get 'static_pages/top'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy', as: 'logout'
  resources :users do
    member do
      post 'tag_new' => 'tags#create'
      post 'tag_edit' => 'tags#update'
      delete 'tag_delete' => 'tags#destroy'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
