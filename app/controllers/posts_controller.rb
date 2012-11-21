class PostsController < ApplicationController
  respond_to :html, :json

  before_filter :load_post, :only => [:show]

  def index
    if current_admin.present?
      @posts = Post.all
    else
      @posts = Post.published
    end
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
