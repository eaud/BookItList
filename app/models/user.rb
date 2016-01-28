class User < ActiveRecord::Base
  has_many :activities, foreign_key: "host_id", dependent: :destroy
  has_many :activity_guests, foreign_key: "guest_id", dependent: :destroy
  has_many :funtimes, through: :activity_guests, source: :activity
  has_many :user_tags, dependent: :destroy
  has_many :tags, through: :user_tags
  validates_presence_of :uid, :name, :token, :image_url
  validates_uniqueness_of :uid, :email
end
