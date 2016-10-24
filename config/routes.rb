Rails.application.routes.draw do
  devise_for :users
  namespace :token do
    mount_devise_token_auth_for 'User', at: '/'
  end
  root 'pages#home'
end
