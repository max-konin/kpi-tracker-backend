Rails.application.routes.draw do
  use_doorkeeper

  namespace :api do
    namespace :v1 do
      get '/users/me', to: 'users#me'

      resources :categories, only: %i[index show]
      resources :tasks, expect: %i[new edit]
      resources :users
    end
  end
end
