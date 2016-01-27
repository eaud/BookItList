class Tag < ActiveRecord::Base
  has_many :profile_tags
  has_many :profiles, through: :tags
end
