class ChangeDefaultHostUserChats < ActiveRecord::Migration
  def change
    change_column :chat_users, :host, :boolean, :default => false
  end
end
