Rails.application.routes.draw do
  get 'my-events', to: 'users#show', as: :my_events
  get 'events/user/:id', to: 'users#show', as: :user
  devise_for :users, controllers: { registrations: 'registrations' }
  root "events#index"
  resources :events
end
