class LocationController < ApplicationController
  def record
    l = LocationUpdate.create!(:user_id => current_user.id, :is_chaser => current_user.is_chaser, :longitude => params[:long], :latitude => params[:lat], :accuracy => params[:acc])
    render :nothing => true
  end
end