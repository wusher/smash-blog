class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authorize_miniprofiler
  
  private 
  
  def authorize_miniprofiler
    if current_admin.present? || params[:profiler].present?
      Rack::MiniProfiler.authorize_request
    end
  end
end
