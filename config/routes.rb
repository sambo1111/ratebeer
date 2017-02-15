Rails.application.routes.draw do
  resources :memberships
  resources :beer_clubs
  resources :users
  resources :beers
  resources :breweries
  root 'breweries#index'
  #get 'ratings', to: 'ratings#index'
  #get 'ratings/new', to:'ratings#new'
  #post 'ratings', to: 'ratings#create'
  resources :ratings, only: [:index, :new, :create, :destroy] #Same as above 3
  get 'signup', to: 'users#new'

  resource :session, only: [:new, :create, :destroy]
  get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'

  resources :places, only:[:index, :show]
  get 'places', to: 'places#index'
  post 'places', to: 'places#search'

end
