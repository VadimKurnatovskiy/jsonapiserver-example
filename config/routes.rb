Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :publishers, only: [:index, :show]
      resources :books, only: [:index, :show, :create]
    end
  end
end
