Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      get '/locations', to: 'spots#index'
      get '/search/locations', to: 'search#index'
      get '/:spot_id/surf', to: 'surf#show'
    end
  end
end
