Rails.application.routes.draw do

  resources :groups
  resources :competitions
  resources :goals
  resources :users, only: %i[index show new create edit update]
  resource :session, only: %i[new create destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
