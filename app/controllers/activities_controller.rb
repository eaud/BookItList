class ActivitiesController < ApplicationController

  def index
    if logged_in?
      if current_user.unseen_activity_guests.length < 5
        current_user.generate_activity_guests(5)
      end
      @fresh_activities = current_user.fresh_activities
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
