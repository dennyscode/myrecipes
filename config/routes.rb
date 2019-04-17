Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'pages#home'
  get 'pages/home', to: 'pages#home'
  get 'pages/about', to: 'pages#about'

  resources :recipes
  # get '/recipes', to: 'recipes#index'
  # get '/recipes/new', to: 'recipes#new', as: 'new_recipe'
  # get '/recipes/:id', to: 'recipes#show', as: 'recipe'
  # post '/recipes', to: 'recipes#create'
  get '/signup', to: "chefs#new"
  resources :chefs, except: [:new]
  resources :ingredients, except: [:destroy]
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

end
