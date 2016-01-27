class User < ActiveRecord::Base
  has_many :activities, foreign_key: "host_id"
  has_many :activity_guests, foreign_key: "guest_id"
  has_many :funtimes, through: :activity_guests, source: :activity
  has_one :profile
end
