Rails.application.routes.draw do
  resources :organizations, only: [:create, :show, :edit, :destroy, :new]
  resources :user_organizations, only: [:create, :destroy]
  resource :user, only: [:edit, :update]

  get 'logout', to: 'sessions#destroy', as: :destroy_session
  get 'auth/:provider/callback', to: 'sessions#create'
  root 'sessions#new'
end
