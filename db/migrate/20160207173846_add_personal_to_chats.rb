class AddPersonalToChats < ActiveRecord::Migration
  def change
    add_column :chats, :personal, :boolean, :default => false
  end
end
