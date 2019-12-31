Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      get '/locations', to: 'spots#index'
      get '/search/locations', to: 'search#index'
    end
  end
end
