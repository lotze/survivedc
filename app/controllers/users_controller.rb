class UsersController < ApplicationController
  include ApplicationHelper
  skip_before_filter :require_login, :only => [:new, :create]
  
  def new
    @user = User.new
    @random_password = random_code(5).downcase
  end

  def create
    redirect_here = params[:user].delete(:redirect_here)
    params[:user][:email] = params[:user][:email].downcase
    @user = User.new(params[:user].merge({:last_checkpoint_at => Time.now}))
    if @user.save
      auto_login(@user, should_remember=true)
      if redirect_here
        redirect_to redirect_here
      else
        redirect_back_or_to root_url
      end
    else
      @random_password = random_code(5).downcase
      @redirect_here = redirect_here
      render :new
    end
  end
  
  def authenticate
    @user = User.load_from_activation_token(token)
    @user.activate!
    @user.deliver_reset_password_instructions!
  end
  
  def password_reset
  end
  
  def activate
    @user = User.load_from_activation_token(params[:code])
    @user.activate!
    @place = 1 + User.count({:conditions => "checkpoint_num > #{@user.checkpoint_num} OR (checkpoint_num = #{@user.checkpoint_num} AND last_checkpoint_at < '#{(@user.last_checkpoint_at || @user.created_at).to_s(:db)}')"})
    render :action => 'status', :notice => 'Successfully activated!'
    @friends = []
  end
  
  def status
    @user = User.find(params[:id] || current_user.id)
    @place = 1 + User.count({:conditions => "checkpoint_num > #{@user.checkpoint_num} OR (checkpoint_num = #{@user.checkpoint_num} AND last_checkpoint_at < '#{(@user.last_checkpoint_at || @user.created_at).to_s(:db)}')"})
      
    @friends = @user.friends.includes(:checkins).sort_by {|f| f.username}
  end
  
  def main
    if (current_user.onboarding_level)
    end
  end
end
