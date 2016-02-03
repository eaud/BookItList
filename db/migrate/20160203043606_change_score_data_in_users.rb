class ChangeScoreDataInUsers < ActiveRecord::Migration
  def change
    change_column :users, :score_data, 'json USING CAST(score_data AS json)'
  end
end
