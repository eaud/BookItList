class AddActivitypicToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :activitypic, :string
  end
end
