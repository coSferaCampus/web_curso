Rails.application.routes.draw do
  resources :subjects do
    resources :themes
  end

  resources :themes
end
