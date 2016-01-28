class AddProfileInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :uid, :string
    add_column :users, :name, :string
    add_column :users, :bio, :string
    add_column :users, :image_url, :string
    add_column :users, :token, :string
    remove_column :users, :username
    remove_column :users, :password_digest
  end
end
