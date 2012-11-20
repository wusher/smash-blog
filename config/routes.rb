Smash::Application.routes.draw do

  get "about/me", :as => "about_me"

  devise_for :admins

  resources :posts

  root :to => 'posts#index'

end
