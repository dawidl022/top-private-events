Rails.application.routes.draw do
  get 'my-events', to: 'users#show', as: :my_events
  get 'events/user/:id', to: 'users#show', as: :user
  devise_for :users, controllers: { registrations: 'registrations' }
  root "events#index"
  resources :events
  post 'event_attendances', to: 'event_attendances#create'
  delete 'event_attendances', to: 'event_attendances#destroy'
end
