Rails.application.routes.draw do
  root 'static_pages#top'

  get 'static_pages/top'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy', as: 'logout'

  resources :users do
    member do
      resource :guidelines, only: [:create]
      resources :tags, only: [:create, :update, :destroy]
        scope module: :tags do
          resource :base_tags, only: [:update]
          resource :page_transitions, only: [:show], as: :tags_transitions
        end
      resource :target, only: [:create, :update, :destroy]
        scope module: :targets do
          resource :page_transitions, only: [:show], as: :targets_transitions
        end
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
