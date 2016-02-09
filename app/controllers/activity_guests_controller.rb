class ActivityGuestsController < ApplicationController

  def like
    # params look like=> {"controller"=>"activity_guests", "action"=>"update", "id"=>"1"}
    liked_AG = ActivityGuest.find_by(activity_id: params[:id], guest_id: current_user.id)
    current_user.like_activity(liked_AG.activity)
    liked_AG.like!
      if current_user.unseen_activity_guests.length < 5
        @new_ags = current_user.generate_activity_guests
        respond_to do |format|
            format.js {}
            format.html { render :nothing => true, :status => 200 }
          end
        else
          respond_to do |format|
            format.all { render :nothing => true, :status => 200 }
          end
      end
  end

  def dislike
    disliked_AG = ActivityGuest.find_by(activity_id: params[:id], guest_id: current_user.id)
    current_user.dislike_activity(disliked_AG.activity)
    disliked_AG.dislike!
    if current_user.unseen_activity_guests.length < 5
      @new_ags = current_user.generate_activity_guests
      respond_to do |format|
          format.js {render "like"}
          format.html { render :nothing => true, :status => 200 }
        end
      else
        respond_to do |format|
          format.all { render :nothing => true, :status => 200 }
        end
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

  def remove
     @activity_guest = ActivityGuest.find(params[:activity_guest_id])
     @activity_guest.remove!
     chat_user = @activity_guest.activity.chat.chat_users.where(user_id: @activity_guest.guest_id)[0]
     chat_user.destroy
     source = page_source(request)

     respond_to do |format|
       format.js{render js_to_render(source)}
       format.html{render :nothing => true, :status => 200}
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
    when "myguestlist"
      'remove_from_myguestlist'
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
