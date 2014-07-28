Rails.application.routes.draw do
  root to: "static_pages#root"
  
  resources :users
  resource :session
  
  get '/current_user', to: 'users#currentuser'
  
  namespace :api, defaults: { format: :json } do
    resources :jobs, except: [:new, :edit]
    resources :tasks, except: [:new]
    resources :users, only: [:show] do
      collection do
        post 'charge', to: 'users#charge'
      end
    end
  end
end
