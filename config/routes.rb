Rails.application.routes.draw do
  match 'auth/:provider/callback',
    :to => 'sessions#create',
    :via => [:get, :post]

  match 'signout',
    :to => 'sessions#destroy',
    :as => 'signout',
    :via => [:get, :post]

  resources :users
  resources :questions
  root :to => 'application#index'
end
