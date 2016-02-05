class AddAasmStateToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :aasm_state, :string
  end
end
