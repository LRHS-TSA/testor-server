Rails.application.routes.draw do
  devise_for :users
  root 'pages#home'

  resources :groups, except: [:destroy] do
    member do
      put :reset_tokens
    end
    resources :members, only: [:index, :show, :destroy]
  end

  post '/join_group', to: 'members#join_group'
end
