GistCommentEmailer::Application.routes.draw do
  match 'auth/github/callback', to: 'sessions#create'
  match 'auth/failure', to: 'static_pages#home'
  
  root to: 'static_pages#home'

  resources :github_users, only: [:edit, :update, :destroy]
end
