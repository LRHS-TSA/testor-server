Rails.application.routes.draw do
  devise_for :users
  root 'pages#home'

  resources :groups, except: [:destroy] do
    member do
      put :reset_tokens
    end
    resources :members, only: [:index, :show, :destroy]
    resources :assignments do
      resources :sessions, except: [:new, :destroy] do
        member do
          get :load_questions
        end
        resources :scores, except: [:new, :edit]
        resources :text_answers, except: [:new, :edit, :destroy]
        resources :multiple_choice_answers, except: [:new, :edit, :destroy]
        resources :matching_pair_answers, except: [:new, :edit, :destroy]
      end
    end
  end

  resources :tests do
    resources :questions, except: [:show, :new, :edit] do
      resources :multiple_choice_options, only: [:create, :update, :destroy]
      resources :matching_pairs, only: [:create, :update, :destroy]
    end
  end

  post '/join_group', to: 'members#join_group'
end
