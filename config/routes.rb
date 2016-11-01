Rails.application.routes.draw do
  devise_for :users
  root 'pages#home'

  resources :groups, except: [:destroy] do
    member do
      put :reset_tokens
    end
  end
end
