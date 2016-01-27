class CreateActivityTags < ActiveRecord::Migration
  def change
    create_table :activity_tags do |t|
      t.references :activity, index: true, foreign_key: true
      t.references :tag, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
