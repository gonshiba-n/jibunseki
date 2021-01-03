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
          resource :target_transitions, only: [:show], as: :targets_transitions
        end
      resource :company
        scope module: :companies do
          resources :company_transitions, only: [:show], as: :company_transitions
          resources :company_seraches, only: [:index, :show], as: :company_serach
        end
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
