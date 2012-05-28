class CheckinController < ApplicationController
  def create
    if game_on
      code = params[:code]
      if code
        code = code.downcase
      end
      @checkpoint = Checkpoint.find_by_secret_code(code)
      if (@checkpoint.nil?)
        redirect_to :controller => 'checkin', :action => 'new', :bad_code => params[:code]
      else
        begin
          @checkin = Checkin.create!(:checkpoint_id => @checkpoint.id, :user_id => current_user.id, :user_agent => request.user_agent, :ip_address => request.remote_ip, :checkpoint_num => current_user.checkpoint_num + 1, :longitude => params[:long], :latitude => params[:lat], :accuracy => params[:accuracy], :method => params[:method])
          current_user.checkpoint_num += 1
          current_user.last_checkpoint_at = Time.now
          current_user.save!
          @checkpoint.update_attributes!(:num_players => @checkpoint.num_players + 1)
          redirect_to :controller => 'users', :action => 'current_status', :id => current_user.id
        rescue Exception => e
          # maybe they're just trying to log in again
          if (e.to_s =~ /^Mysql2::Error: Duplicate entry/)
            redirect_to :controller => 'users', :action => 'current_status', :id => current_user.id
          else
            redirect_to :controller => "notice", :action => "show", :error => "Error creating checkin...I'm very sorry, but there's probably nothing to be done right now. Keep running."
          end
        end
      end
    else
      redirect_to :controller => 'checkin', :action => 'new', :bad_code => "What, really? The game hasn't even started."
    end
  end

  def new
    @bad_code = params[:bad_code]
    @checkpoint_data = Checkpoint.all.map {|c| [c.secret_code.capitalize, c.latitude, c.longitude]}
  end
end
