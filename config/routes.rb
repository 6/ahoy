Rails.application.routes.draw do
  resource :organization, only: [:create, :update, :edit, :new]
  resource :user, only: [:edit, :update]

  get 'logout', to: 'sessions#destroy', as: :destroy_session
  get 'auth/:provider/callback', to: 'sessions#create'
  root 'sessions#new'
end
