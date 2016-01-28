class Tag < ActiveRecord::Base
  has_many :profile_tags, dependent: :destroy
  has_many :profiles, through: :tags
  has_many :activity_tags, dependent: :destroy
  has_many :activities, through: :activity_tags
  validates_presence_of :name
end
