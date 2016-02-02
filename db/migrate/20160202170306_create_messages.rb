class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :chat, index: true, foreign_key: true
      t.references :sender, index: true

      t.timestamps null: false
    end
    add_foreign_key :messages, :users, column: :sender_id
  end
end
