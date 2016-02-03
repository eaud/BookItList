class CreateChatUsers < ActiveRecord::Migration
  def change
    create_table :chat_users do |t|
      t.references :chat, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.string :aasm_state
      t.boolean :host

      t.timestamps null: false
    end
  end
end
