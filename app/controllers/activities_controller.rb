class ActivitiesController < ApplicationController

  def index
    if logged_in?
      @activities = Activity.where.not(host: current_user)
      current_user_AGs = ActivityGuest.where(guest_id: current_user.id, aasm_state: "unseen")
      if current_user_AGs.length < 5
        # Find activities that have not been show to the current_user
        unshown_activities = @activities.map do |activity|
            activity if (!current_user.funtimes.include?(activity)  && activity.host != current_user)
        end.compact
        # For the first 5 unshown activities, create Activity_Guests with current_user
        unshown_activities[0..4].each do |unshown|
          ActivityGuest.create(guest_id: current_user.id, activity_id: unshown.id)
        end

      end
      @fresh_activities = current_user.funtimes.map do |funtime|
        funtime if funtime.activity_guests[0].aasm_state == "unseen"
      end
    end
  end

  def myindex
    if logged_in?
      @activities = Activity.where(host_id: current_user.id)
    else
      redirect_to root_path #EVENTUALLY THIS WILL NEED TO BE JS TO SUGGEST LOGGING IN
    end
  end

  def new
    if logged_in?
      @activity = Activity.new
      respond_to do |format|
        format.html{}
        format.js{}
      end
    else
      redirect_to root_path #EVENTUALLY THIS WILL NEED TO BE JS TO SUGGEST LOGGING IN
    end
  end

  def create
    @activity = Activity.new(activity_params)
    @activity.host = current_user
    @activity.save
    redirect_to activity_path(@activity)
  end

  def show
    @activity = Activity.find(params[:id])
  end

  def edit
    @activity = Activity.find(params[:id])
  end

  def update
    @activity = Activity.find(params[:id])
    @activity.update(activity_params)
    redirect_to activity_path(@activity)
  end

  def destroy
    @activity = Activity.find(params[:id])
    if current_user.id != @activity.host_id
      redirect_to root_path
    else
      @activity.destroy
      redirect_to root_path
    end
  end

  private
  def activity_params
    params.require("activity").permit(:name, :guest_min, :guest_max, :details, :cost, :image_url, :host_id, :tag_ids => [])
  end
end
