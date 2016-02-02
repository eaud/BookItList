class CreateChats < ActiveRecord::Migration
  def change
    create_table :chats do |t|
      t.references :activity, index: true, foreign_key: true
      t.string :name

      t.timestamps null: false
    end
  end
end
