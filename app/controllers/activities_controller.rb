class ActivitiesController < ApplicationController

  def index
    # binding.pry
    @activities = Activity.all
  end

  def new
    @activity = Activity.new

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
    binding.pry
    @activity.update(activity_params)
    redirect_to activity_path(@activity)
  end

  def destroy
    @activity = Activity.find(params[:id])
    @activity.destroy
    redirect_to root_path
  end

  private
  def activity_params
    params.require("activity").permit(:name, :guest_min, :guest_max, :details, :cost, :image_url, :host_id)
  end
end
