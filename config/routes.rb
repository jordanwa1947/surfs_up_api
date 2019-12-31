Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      get '/locations', to: 'spots#index'
    end
  end
end
