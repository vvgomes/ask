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
    :as => 'my_questions',
    :via => :get

  match 'favorite',
    :to => 'questions#favorite',
    :as => 'favorite_questions',
    :via => :get

  resources :likes, :only => [:create, :destroy]

  root :to => 'application#index'
end
