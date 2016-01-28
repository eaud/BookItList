class Activity < ActiveRecord::Base
  belongs_to :host, class_name: "User"
  has_many :activity_tags
  has_many :tags, through: :activity_tags
  has_many :activity_guests, dependent: :destroy
  has_many :guests, through: :activity_guests, source: :user
end
