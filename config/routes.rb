Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: redirect('/tasks')
  resources :tasks do
    get 'toggle_completed', on: :member
    get 'search', on: :collection
  end
  resources :tags, param: :name
  get '/welcome', to: 'application#welcome'
end
