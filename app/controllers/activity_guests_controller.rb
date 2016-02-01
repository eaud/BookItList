class ActivityGuestsController < ApplicationController

  def like
    # params look like=> {"controller"=>"activity_guests", "action"=>"update", "id"=>"1"}
    liked_activity = ActivityGuest.where(activity_id: params[:id], guest_id: current_user.id)
    liked_activity[0].like!
  end

  def dislike
    disliked_activity = ActivityGuest.where(activity_id: params[:id], guest_id: current_user.id)
    disliked_activity[0].dislike!
  end

  def approve
    approved_activity = ActivityGuest.where(activity_id: params[:activity_id], guest_id: params[:guest_id])
    approved_activity[0].approve!
    @activity = Activity.find(params[:activity_id])

    respond_to do |format|
      format.js{}
      format.html{}
    end

  end

  def deny
    denied_activity = ActivityGuest.where(activity_id: params[:activity_id], guest_id: params[:guest_id])
    denied_activity[0].deny!
  end

end
