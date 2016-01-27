class CreateProfileTags < ActiveRecord::Migration
  def change
    create_table :profile_tags do |t|
      t.references :profile, index: true, foreign_key: true
      t.references :tag, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
