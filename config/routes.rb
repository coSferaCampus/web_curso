Rails.application.routes.draw do
  root to: 'main#index'

  resources :subjects do
    resources :themes
  end

  resources :themes
end
