Rails.application.routes.draw do
  devise_for :users
  mount_devise_token_auth_for 'User', at: 'token'
  root 'pages#home'
end
