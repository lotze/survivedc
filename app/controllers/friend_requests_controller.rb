require 'mail'
class FriendRequestsController < ApplicationController
  include ApplicationHelper
  
  skip_before_filter :require_login, :only => [:approve]

  def create
    if current_user.activation_state == 'pending'
      SurvivedcMailer.activation_needed_email(current_user)
      redirect_to :controller => :notice, :action => :show, :error => "You must authenticate your email first.  Check your email for an authentication link (with the subject 'Confirm your email for SurviveDC!')."
    else
      target_email = params[:email]
      begin
        if target_email !~ /@/
          raise Exception('no @ sign in email')
        end
        Mail::Address.new(target_email)
      rescue Mail::Field::ParseError => e
        redirect_to :controller => :notice, :action => :show, :error => "#{target_email} does not appear to be a valid email address."
      end
      
      # make sure this user hasn't already requested this friend
      friend_request = FriendRequest.find_by_requesting_id_and_target_email(current_user.id, target_email)
      
      if friend_request
        SurvivedcMailer.friend_request_email(friend_request, current_user)
        redirect_to :controller => :notice, :action => :show, :info => "Your request has been re-sent! If they accept, you will see their status in your status page and their icon on your map during the game."      
      else
        # generate code, make sure it's unique
        begin
          code = random_code(10)
        end while friend_request = FriendRequest.find_by_code(code)
        friend_request = FriendRequest.create!(:requesting_id => current_user.id, :target_email => target_email, :code => code)
        
        SurvivedcMailer.friend_request_email(friend_request, current_user)
        redirect_to :controller => :notice, :action => :show, :info => "Your request has been sent! If they accept, you will see their status in your status page and their icon on your map during the game."      
      end
    end
  end

  def approve
    @friend_request = FriendRequest.find_by_code(params[:code])
    
    if !@friend_request
      redirect_to :controller => :notice, :action => :show, :error => "That does not appear to be a valid friend request code."
    elsif @friend_request.approved
      redirect_to :controller => :notice, :action => :show, :info => "That friend request has already been accepted."
    elsif current_user
      if current_user.id == @friend_request.requester.id
        redirect_to :controller => :notice, :action => :show, :error => "You're still logged in; you have to first log out (by going to http://www.survivedc.com/logout) if you want your friend to use this computer."        
      else
        @friend_request.update_attributes!(:target_id => current_user.id, :approved => true)
        if current_user.activation_state == 'pending'
          current_user.activate!
        end
      end
    else
      @user = User.new(:email => @friend_request.target_email)
      @random_password = random_code(5).downcase
      @redirect_here = request.request_uri
      # provide form to sign up (extract and use as a partial, like password reset) or log in (button, with return here?)
    end
  end

  def delete
  end

end
