class User < ActiveRecord::Base
  has_many :activities, as: :host
  has_many :activity_guests, foreign_key: "guest_id"
  has_many :activities, through: :activity_guests, source: :user
  has_one :profile
end
