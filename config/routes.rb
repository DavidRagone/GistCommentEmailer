GistCommentEmailer::Application.routes.draw do
  match 'auth/github/callback', to: 'sessions#create'
  match 'signout', :to => 'sessions#destroy', as: 'signout'
  match 'auth/failure', to: 'static_pages#home'
  
  root to: 'static_pages#home'
  get 'about' => 'static_pages#about', as: 'about'
  get 'contact' => 'static_pages#contact', as: 'contact'

  resources :github_users, only: [:edit, :update, :destroy]
end
