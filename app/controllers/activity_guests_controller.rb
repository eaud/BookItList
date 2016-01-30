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

  private

end
