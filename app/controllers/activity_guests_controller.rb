class ActivityGuestsController < ApplicationController

  def like
    # params look like=> {"controller"=>"activity_guests", "action"=>"update", "id"=>"1"}
    liked_AG = ActivityGuest.where(activity_id: params[:id], guest_id: current_user.id)[0]
    current_user.like_activity(liked_AG.activity)
    liked_AG.like!
    respond_to do |format|
      format.all { render :nothing => true, :status => 200 }
    end
  end

  def dislike
    disliked_AG = ActivityGuest.where(activity_id: params[:id], guest_id: current_user.id)[0]
    current_user.dislike_activity(disliked_AG.activity)
    disliked_AG.dislike!
    respond_to do |format|
      format.all { render :nothing => true, :status => 200 }
    end
  end

  def approve
    @activity_guest = ActivityGuest.find(params[:activity_guest_id])
    @activity_guest.approve!
    @activity = Activity.find(@activity_guest.activity_id)
    @guest = @activity_guest.guest
    source = request.env["HTTP_REFERER"].split("/")[3]

    if source == "users"
      respond_to do |format|
        format.js{render 'approve_from_users'}
        format.html{redirect_to user_path(@guest)}
      end
    elsif source == "mylist"
      respond_to do |format|
        format.js{render 'approve_from_my_list'}
        format.html{redirect_to mylist_path}
      end
    end

  end

  def deny
    @activity_guest = ActivityGuest.find(params[:activity_guest_id])
    @activity_guest.deny!
    @activity = Activity.find(@activity_guest.activity_id)
    @guest = @activity_guest.guest
    source = request.env["HTTP_REFERER"].split("/")[3]

    if source == "users"
      respond_to do |format|
        format.js{}
        format.html{redirect_to user_path(@guest)}
      end
    elsif source == "mylist"
      respond_to do |format|
        format.js{render 'approve_from_my_list'}
        format.html{redirect_to mylist_path}
      end
    end
  end


end
