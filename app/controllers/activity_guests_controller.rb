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
    source = page_source(request)

    if old_chat = Chat.find_by(activity: @activity)
      old_chat.users << @guest
    else
      chat = Chat.new(name: @activity.name, activity: @activity)
      chat.save
      chat.users << [@guest, current_user]
      ChatUser.find_by(chat: chat, user: current_user).update(host: true)
    end

    respond_to do |format|
      format.js{render js_to_render(source)}
      format.html{redirect_to html_to_render(source)}
    end

  end

  def deny
    @activity_guest = ActivityGuest.find(params[:activity_guest_id])
    @activity_guest.deny!
    @activity = Activity.find(@activity_guest.activity_id)
    @guest = @activity_guest.guest
    source = page_source(request)

    respond_to do |format|
      format.js{render js_to_render(source)}
      format.html{redirect_to html_to_render(source)}
    end
  end

  def page_source(request)
    request.env["HTTP_REFERER"].split("/")[3]
  end

  def js_to_render(source)
    case  source
    when "users"
      'approve_from_users'
    when "mylist"
      'approve_from_my_list'
    when "activities"
      'approve_from_activities'
    end
  end

  def html_to_render(source)
    case  source
    when "users"
      user_path(@guest)
    when "mylist"
      mylist_path
    when "activities"
      activity_path(@activity)
    end
  end

end
