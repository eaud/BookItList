class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.references :host, index: true
      t.string :name
      t.datetime :datetime
      t.float :cost
      t.integer :guest_min
      t.integer :guest_max
      t.string :details

      t.timestamps null: false
    end

     add_foreign_key :activities, :users, column: :host_id
  end
end
