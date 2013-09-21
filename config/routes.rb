Smash::Application.routes.draw do

  resources "sitemap", :only => [:index]
  resources "markdown_parser", :only => [:create]

  devise_for :admins
  get "about/me", :as => "about_me"

  get 'archives', :to => "posts#archives", :as => "posts_archives"

  resources :posts do
    collection do
      get 'archives'
    end
  end

  root :to => 'posts#index'
end
