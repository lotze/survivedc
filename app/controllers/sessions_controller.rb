class SessionsController < ApplicationController
  skip_before_filter :require_login, :only => [:new, :create]

  def new
  end

  def create
    puts "Attempting to log in #{params[:email]}, #{params[:password]}"
    user = login(params[:email], params[:password])
    if user
      remember_me!
      redirect_back_or_to root_url
    else
      @error_notice = 'Email or password was invalid.'
      render :action => 'new'
    end
  end
  
  def destroy
    logout
    redirect_to root_url
  end
end
