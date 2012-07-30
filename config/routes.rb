SimpleTaskManager::Application.routes.draw do

  resources :users
  resources :sessions, :only => [:new, :create, :destroy]
  resources :projects
  resources :stories
  resources :comments, :only => [:new, :create]
  resources :relationships, :only => [:create, :destroy]

  root :to => 'pages#home'

  match '/story_change_state', :to => 'stories#change_state'

  match '/contact', :to => 'pages#contact'
  match '/about',   :to => 'pages#about'
  match '/help',    :to => 'pages#help'

  match '/signup',  :to => 'users#new'
  match '/signin',  :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'

  resources :projects do
    member do
      get :members
    end
  end

  resources :users do
    member do
      get :works
    end
  end

end
