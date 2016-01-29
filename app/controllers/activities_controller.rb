class ActivitiesController < ApplicationController

  def index
    # binding.pry
    @activities = Activity.all
  end

end
