Rails.application.routes.draw do
  get 'my-events', to: 'users#show', as: :my_events
  get 'events/user/:id', to: 'users#show'
  devise_for :users, controllers: { registrations: 'registrations' }
  root "events#index"
  resource :events
end
