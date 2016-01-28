class ActivityGuest < ActiveRecord::Base
  belongs_to :activity
  belongs_to :guest, class_name: "User"
  validates_presence_of :activity_id, :guest_id
end
