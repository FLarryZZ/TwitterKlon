Rails.application.routes.draw do
devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :tweeets
  root "tweeets#index"

  resources :users do
    resources :relationships, only: [:create]

  end
  resources :relationships , only:[:destroy]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
