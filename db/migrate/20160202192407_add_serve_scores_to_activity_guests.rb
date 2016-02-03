class AddServeScoresToActivityGuests < ActiveRecord::Migration
  def change
    add_column :activity_guests, :serv_score, :integer
  end
end
