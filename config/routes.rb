Rails.application.routes.draw do
  devise_for :users, controllers: {sessions: 'sessions', confirmations: 'confirmations'}

  root to: 'main#index'

  resources :users
  put "/profile" => 'users#update'

  resources :subjects do
    resources :themes
  end

  resources :themes
  resources :file_resources
end
