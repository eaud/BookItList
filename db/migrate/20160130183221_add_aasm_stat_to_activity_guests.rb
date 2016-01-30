class AddAasmStatToActivityGuests < ActiveRecord::Migration
  def change
    add_column :activity_guests, :aasm_state, :string
  end
end
