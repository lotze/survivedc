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
    @user = params[:code] ? User.find_by_share_code(params[:code]) : current_user
    @user.update_attributes!(:share_code => random_code(10)) unless @user.share_code?
    @place = 1 + User.count({:conditions => "checkpoint_num > #{@user.checkpoint_num} OR (checkpoint_num = #{@user.checkpoint_num} AND last_checkpoint_at < '#{(@user.last_checkpoint_at || @user.created_at).to_s(:db)}')"})
      
    @friends = @user.friends.includes(:checkins).sort_by {|f| f.username}
  end
  
  def history
    @user = params[:code] ? User.find_by_share_code(params[:code]) : current_user
    @user.update_attributes!(:share_code => random_code(10)) unless @user.share_code?
    @location_updates = @user.location_updates#.where("created_at BETWEEN '#{release_time.to_s(:db)}' AND '#{over_time.to_s(:db)}'")
    @checkins = @user.checkins.includes(:checkpoint)
    @places = @checkins.map {|c| [c.created_at, c.latitude || c.checkpoint.latitude, c.longitude || c.checkpoint.longitude]}.concat(@location_updates.map {|l| [l.created_at, l.latitude, l.longitude]})
    puts @places.inspect
    @places = @places.sort_by {|p| p[0]}
  end
  
  def main
    if (current_user.onboarding_level)
    end
  end
end
