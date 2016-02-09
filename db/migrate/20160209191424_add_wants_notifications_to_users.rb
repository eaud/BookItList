class AddWantsNotificationsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :wants_notifications, :boolean, :default => false
  end
end
