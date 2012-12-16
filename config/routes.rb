Smash::Application.routes.draw do

  resources "sitemap", :only => [:index]
  resources "markdown_parser", :only => [:create]

  devise_for :admins
  get "about/me", :as => "about_me"

  resources :posts

  root :to => 'posts#index'
end
