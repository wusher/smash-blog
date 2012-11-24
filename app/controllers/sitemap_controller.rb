class SitemapController < ApplicationController
  respond_to :xml
  def index
    @posts = Post.published
    respond_with @posts
  end
end
