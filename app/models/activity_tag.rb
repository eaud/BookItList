class ActivityTag < ActiveRecord::Base
  belongs_to :activity
  belongs_to :tag
  validates_presence_of :activity_id, :tag_id
end
