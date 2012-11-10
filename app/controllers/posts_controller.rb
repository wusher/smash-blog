class PostsController < ApplicationController

  before_filter :load_post, :only => [:show]


  def index
    @posts = Post.all

  end

  def show

  end

  private

  def load_post
    @post = Post.find_by_slug(params[:id])
    raise ActiveRecord::RecordNotFound unless @post
  end


end
