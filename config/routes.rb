Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'articles#index'

  get '/articles', to: 'articles#new'
  post '/articles', to: 'articles#create'
  get '/articles/:id', to: 'articles#show'
  delete '/articles/:id', to: 'articles#destroy'

  get '/login', to: 'auth#new'
  post '/login', to: 'auth#create'
  delete '/logout', to: 'auth#destroy'
end
