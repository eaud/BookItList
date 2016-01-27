class ActivityGuest < ActiveRecord::Base
  belongs_to :activity
  belongs_to :guest
end
