Rails.application.routes.draw do
  get 'auth/redbooth/callback', to: 'sessions#create'

  root 'welcome#index'
  resources :projects
end
