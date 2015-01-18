Rails.application.routes.draw do
  devise_for :users, controllers: {sessions: 'sessions'}

  root to: 'main#index'

  resources :users
  put "/profile" => 'users#update'

  resources :subjects do
    resources :themes
  end

  resources :themes
end
