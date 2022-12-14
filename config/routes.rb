Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :items do
        get '/merchant', to: 'merchants#show'
        collection do
          get :find_all
        end
      end
      resources :merchants do
        get '/items', to: 'items#index'
        collection do
          get :find
        end
      end
    end
  end
end
