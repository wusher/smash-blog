Smash::Application.routes.draw do

  devise_for :admins

  resources :posts

  root :to => 'posts#index'

end
