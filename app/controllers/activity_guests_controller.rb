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
    @activity_guest = ActivityGuest.find(params[:activity_guest_id])
    # @activity_guest.approve!
    @activity = Activity.find(@activity_guest.activity_id)
    @guest = @activity_guest.guest
    source = request.env["HTTP_REFERER"].split("/")[3]

    if source == "users"
      respond_to do |format|
        format.js{render 'approve_from_users'}
        format.html{}
      end
    elsif source == "mylist"
      respond_to do |format|
        format.js{render 'approve_from_my_list'}
        format.html{}
      end
    end

  end

  def deny
    binding.pry
    @activity_guest = ActivityGuest.find(params[:activity_guest_id])
    # @activity_guest.deny!
    @activity = Activity.find(@activity_guest.activity_id)
    @guest = @activity_guest.guest
    source = request.env["HTTP_REFERER"].split("/")[3]
    source = request.env["HTTP_REFERER"].split("/")[3]

    if source == "users"
      respond_to do |format|
        format.js{}
        format.html{}
      end
    elsif source == "mylist"
      respond_to do |format|
        format.js{render 'approve_from_my_list'}
        format.html{}
      end
    end
  end


end
