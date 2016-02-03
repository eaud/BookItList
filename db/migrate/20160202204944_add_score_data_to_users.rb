class AddScoreDataToUsers < ActiveRecord::Migration
  def change
    enable_extension "hstore"
    add_column :users, :score_data, :hstore
  end
end
