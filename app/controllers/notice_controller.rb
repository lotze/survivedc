class NoticeController < ApplicationController
  skip_before_filter :require_login, :only => [:show]
  
  def show
    @error = params[:error]
    @info = params[:info]
  end

end
