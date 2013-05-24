Postit::Application.routes.draw do
  root to: 'posts#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :posts, except: [:destroy] do
    member do
      post 'vote'
    end

    resources :comments, only: [:index, :new, :create] do
      member do
        post 'vote'
      end
    end
  end

  resources :users, only: [:new, :create]
end
