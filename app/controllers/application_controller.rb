class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authorize_mini_profiler

  private

  def authorize_mini_profiler
    if current_admin.present? || Rails.env.development? || params[:minipro].present?
      Rack::MiniProfiler.authorize_request
    end
  end

end
