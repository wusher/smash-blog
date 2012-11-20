class PostsController < ApplicationController
  respond_to :html, :json

  before_filter :load_post, :only => [:show]


  def index
    @posts = Post.all
    respond_with @posts
  end

  def show
    respond_with @post
  end

  private

  def load_post
    @post = Post.find_by_slug(params[:id])
    raise ActiveRecord::RecordNotFound unless @post
  end
end
