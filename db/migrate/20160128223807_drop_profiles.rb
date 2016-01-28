class DropProfiles < ActiveRecord::Migration
  def change
    drop_table :profile_tags
    drop_table :profiles
  end
end
