class ApplicationController < ActionController::Base
  include ApplicationHelper

  protect_from_forgery
  before_filter :require_login
  
  # Overwrite the method sorcery calls when it
  # detects a non-authenticated request.
  private
  def not_authenticated
    redirect_to root_path
  end  
end
