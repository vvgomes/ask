Rails.application.routes.draw do
  resources :users
  resources :questions
  root :to => 'application#index'
end
