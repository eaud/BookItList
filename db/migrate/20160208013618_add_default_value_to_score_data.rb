class AddDefaultValueToScoreData < ActiveRecord::Migration
  def change
    change_column :users, :score_data, :json, :default =>{"activity"=> {"liked"=>[], "disliked"=>[], "tag_likes"=>{}, "tag_dislikes"=>{}},"host"=>{"liked"=>{}, "disliked"=>{}, "tag_likes"=>{}, "tag_dislikes"=>{}}}
  end
end
