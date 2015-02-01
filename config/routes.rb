Rails.application.routes.draw do
  get 'auth/redbooth/callback', to: 'sessions#create'
  get '/sign_out', to: 'sessions#destroy'

  root 'welcome#index'
  resources :projects do
    resources :task_lists
  end
end
