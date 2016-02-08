class ActivitiesController < ApplicationController

  def index
    if user_signed_in?
      if current_user.unseen_activity_guests.length < 5
        current_user.generate_activity_guests
      end
      @fresh_activities = current_user.fresh_activities
    end
  end

  def myindex
    if user_signed_in?
      @open_activities = Activity.where(host_id: current_user.id, aasm_state: "open").sort_by do |activity| activity.updated_at end.reverse!
      @closed_activities = Activity.where(host_id: current_user.id, aasm_state: "closed").sort_by do |activity| activity.updated_at end.reverse!
    else
      redirect_to root_path #EVENTUALLY THIS WILL NEED TO BE JS TO SUGGEST LOGGING IN
    end
  end

  def myguestindex
    @approved_activities = current_user.approved_activities
    
  end

  def new
    if user_signed_in?
      @activity = Activity.new
      respond_to do |format|
        format.js{}
        format.html{}
      end
    else
      redirect_to root_path #EVENTUALLY THIS WILL NEED TO BE JS TO SUGGEST LOGGING IN
    end
  end

  def create
    @activity = Activity.new(activity_params)
    @activity.host = current_user
    if @activity.save
      @request = request.env["HTTP_REFERER"].split("/")[3]
        respond_to do |format|
          format.js {}
          format.html {redirect_to mylist_path}
        end
    else
      render "new"
    end
  end

  def show
    @activity = Activity.find(params[:id])
    @chat = @activity.chat || Chat.create(name: @activity.name, activity: @activity)
    @message = Message.new
  end

  def edit
    @activity = Activity.find(params[:id])
  end

  def update
    @activity = Activity.find(params[:id])
    if @activity.update(activity_params)
      redirect_to activity_path(@activity)
    else
      render "edit"
    end
  end

  def destroy
    @activity = Activity.find(params[:id])
    if current_user.id != @activity.host_id
      redirect_to mylist_path
    else
      @activity.soft_delete!
      redirect_to mylist_path
    end
  end

  def close
    @activity = Activity.find(params[:id])
    if current_user.id != @activity.host_id
      redirect_to mylist_path
    else
      @activity.close!
      redirect_to mylist_path
    end
  end

  def open
    @activity = Activity.find(params[:id])
    if current_user.id != @activity.host_id
      redirect_to mylist_path
    else
      @activity.reopen!
      redirect_to mylist_path
    end
  end

  def modal
    @activity = Activity.find(params[:id])
    respond_to do |format|
      format.js {}
      format.html {redirect_to activity_path(@activity)}
    end
  end

  private
  def activity_params
    params.require("activity").permit(:name, :guest_min, :guest_max, :details, :cost, :image_url, :host_id, :tag_ids => [])
  end
end
