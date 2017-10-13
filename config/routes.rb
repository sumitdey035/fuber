Rails.application.routes.draw do
  resources :cars, only: [:index]
  resources :customers, only: [:index, :show]
  root 'dashboard#index'

  namespace 'api', constraints: { format: :json } do
    namespace 'v1' do
      resources :customers, only: [] do
        resources :rides, except: [:new, :edit, :update]
      end
    end
  end
end
