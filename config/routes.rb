Rails.application.routes.draw do

  root 'home#index'

  get '/about' => 'home#about'

  resources :events do
    member do
      get 'history/:player_name', to: 'events#history', as: :history
    end
  end
  resources :rounds do
    member do
      get :result, as: :result
    end
  end
  resources :matches

  namespace :admin do
    root 'pages#index', as: 'root'
    resources :events do
      member do
        get 'history/:player_name', to: 'events#history', as: :history
      end
    end
    resources :contributors
    resources :rounds do
      member do
        get :result, as: :result
      end
    end
    resources :matches
  end

  get  '/auth/:provider/callback', to: 'sessions#callback'
  post '/auth/:provider/callback', to: 'sessions#callback'
  get  '/logout' => 'sessions#destroy', as: :logout

  if Rails.env.development?
    get  '/fake_session' => 'sessions#fake_session'
  end

  namespace :api, format: :json do
    namespace :v1 do
      get '/events'     => 'events#index'
      get '/events/:id' => 'events#show'

      get '/rounds/:id' => 'rounds#show'
    end
    match '*path', to: 'preflight#preflight', via: :options
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
