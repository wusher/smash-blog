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
    if @post.update_attributes(post_params)
      Taggerator.new(@post).invoke(tags_params[:tags])
    end

    respond_with  @post
  end

  def new
    @post = Post.new
    respond_with @post
  end

  def create
    @post = Post.create post_params
    respond_with  @post
  end


  def index
    if current_admin.present?
      @posts = Post.scoped
    else
      @posts = Post.published
    end
    @posts.map!{ |x| PostPresentor.new x}
    respond_with @posts
  end

  def archives
    @posts = Post.published.group_by { |x| x.pubdate.beginning_of_month }
    respond_with @posts
  end

  def show
    @post = PostPresentor.new(@post)
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

  def post_params
    params.require("post").permit(:title, :pubdate, :published, :body)
  end

  def tags_params
    params.require("post").permit(:tags)
  end
end
