Rails.application.routes.draw do
  get 'users/profile'
  resources :images
  resources :albums
  resources :albums do
    resources :images do
    end
  end
  root 'home#index'
  devise_for :users
  get '/profile' => "users#profile", :as => :profile
  devise_scope :user do
    get '/sign-in' => "devise/sessions#new", :as => :login
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
