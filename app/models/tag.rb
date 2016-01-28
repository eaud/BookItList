class Tag < ActiveRecord::Base
  has_many :profile_tags
  has_many :profiles, through: :tags
  has_many :activity_tags
  has_many :activities, through: :activity_tags
end
