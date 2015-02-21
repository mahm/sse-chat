Rails.application.routes.draw do
  resources :rooms do
    get :subscribe
    resources :messages
  end
  root to: 'rooms#index'
end
