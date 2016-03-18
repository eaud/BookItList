require 'net/http'
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
      @open_activities   = current_user.activities.open.order_by_most_recent
      @closed_activities = current_user.activities.closed.order_by_most_recent
    else
      redirect_to root_path #EVENTUALLY THIS WILL NEED TO BE JS TO SUGGEST LOGGING IN
    end
  end

  def myguestindex
    @approved_activities = current_user.approved_activities.order_by_most_recent
  end

  def giphy
    search_term = params[:search_term].gsub(" ", "+")
    url = "http://api.giphy.com/v1/gifs/search?q=" + search_term + "&api_key=dc6zaTOxFJmzC&limit=5"
    resp = Net::HTTP.get_response(URI.parse(url))
    buffer = resp.body
    result = JSON.parse(buffer)
    @urls = result["data"].map {|result| result["images"]["fixed_height"]["url"]}
    respond_to do |format|
      format.js {}
      format.html {redirect_to mylist_path}
    end
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
    respond_to do |format|
      format.js{}
      format.html{}
    end
  end

  def update
    @activity = Activity.find(params[:id])
    source = request.env["HTTP_REFERER"].split("/")[3]
    if @activity.update(activity_params)
      if source == "mylist"
        respond_to do |format|
        format.js {}
        format.html {redirect_to activity_path(@activity)}
        end
      else
        respond_to do |format|
        format.js {render "other_update"}
        format.html {redirect_to activity_path(@activity)}
        end
      end
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
    @activity.close!
    respond_to do |format|
      format.js {}
      format.html {redirect_to mylist_path}
    end
  end

  def open
    @activity = Activity.find(params[:id])
    @activity.reopen!
    respond_to do |format|
      format.js {}
      format.html {redirect_to mylist_path}
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
