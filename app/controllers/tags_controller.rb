class TagsController < ApplicationController
  respond_to :html, :json

  def index
    @tags = Tag.active.order(:name)
    respond_with @tags
  end

  def show
    @tag = Tag.find_by_name(params[:id]).as_presenter
    respond_with @tag
  end


end
