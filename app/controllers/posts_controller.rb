class PostsController < ApplicationController
  respond_to :html, :json

  before_filter :authenticate_admin!, :only => [:new, :create, :edit, :update, :destroy]
  before_filter :load_post, :only => [:show, :edit, :update, :destroy]

  def destroy
    @post.destroy
    respond_with @post
  end

  def edit
    respond_with @post
  end

  def update
    @post.update_attributes(params[:post])
    respond_with  @post
  end

  def new
    @post = Post.new
    respond_with @post
  end

  def create
    @post = Post.create params[:post]
    respond_with  @post
  end

  def index
    if current_admin.present?
      @posts = Post.scoped
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
    if @post.nil? && current_admin.present? && params[:id].to_i > 0
      @post = Post.find params[:id]
    end
    raise ActiveRecord::RecordNotFound unless @post
  end
end
