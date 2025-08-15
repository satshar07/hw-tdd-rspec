Rottenpotatoes::Application.routes.draw do
  resources :movies
  root :to => 'movies#index'

  get 'movies/:id/same_director', to: 'movies#same_director', as: 'same_director'
end
