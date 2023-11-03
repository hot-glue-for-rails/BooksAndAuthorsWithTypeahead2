Rails.application.routes.draw do
  resources :books
  resources :authors
  resources :authors_typeahead, only: [:index]
  root to: "welcome#index"
end
