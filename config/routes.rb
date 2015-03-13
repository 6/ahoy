Rails.application.routes.draw do
  resource :organization, only: [:create, :update, :edit, :new]
  resource :user, only: [:edit, :update]
  resources :customers, path: 'conversations', only: [:index, :show, :update]
  resources :outbound_messages, only: [:create]

  post 'webhooks/:organization_token/inbound_messages', to: 'inbound_messages#create', as: :inbound_message
  post 'webhooks/:organization_token/message_delivery_statuses', to: 'message_delivery_statuses#create', as: :message_delivery_status

  get 'logout', to: 'sessions#destroy', as: :destroy_session
  get 'auth/:provider/callback', to: 'sessions#create'
  root 'sessions#new'
end
