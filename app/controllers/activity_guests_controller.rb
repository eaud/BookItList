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
    @activity_guest.approve!
    @activity = Activity.find(@activity_guest.activity_id)
    @guest = @activity_guest.guest
    source = request.env["HTTP_REFERER"].split("/")[3]

    if old_chat = Chat.find_by(activity: @activity)
      old_chat.users << @guest
    else
      chat = Chat.new(name: @activity.name, activity: @activity)
      chat.save
      chat.users << [@guest, current_user]
    end

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
