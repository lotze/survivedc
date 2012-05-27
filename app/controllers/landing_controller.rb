class LandingController < ApplicationController
  skip_before_filter :require_login

  def index
    if current_user
      redirect_to homescreen_path
    end
  end
end
