Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'train_searches#new'

  resources :train_searches, only: %i[new create]
end
