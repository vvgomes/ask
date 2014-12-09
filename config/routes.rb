Rails.application.routes.draw do
  match 'auth/:provider/callback',
    :to => 'sessions#create',
    :via => [:get, :post]

  match 'signout',
    :to => 'sessions#destroy',
    :as => 'signout',
    :via => [:get, :post]

  resources :questions

  match 'mine',
    :to => 'questions#mine',
    :via => :get

  match 'favorite',
    :to => 'questions#favorite',
    :via => :get

  root :to => 'application#index'
end
