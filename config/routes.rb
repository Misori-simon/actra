Rails.application.routes.draw do

  root 'goals#index'
  resources :groups, except: %i[destroy]
  resources :competitions, except: %i[destroy]
  resources :goals, only: %i[index new create]
  resources :users, except: %i[index destroy]
  resource :session, only: %i[new create destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
