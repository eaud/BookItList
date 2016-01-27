class CreateActivityGuests < ActiveRecord::Migration
  def change
    create_table :activity_guests do |t|
      t.references :activity, index: true, foreign_key: true
      t.references :guest, index: true

      t.timestamps null: false
    end
    add_foreign_key :activity_guests, :users, column: :guest_id
  end
end
