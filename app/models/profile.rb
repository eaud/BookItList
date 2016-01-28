class Profile < ActiveRecord::Base
  belongs_to :user
  has_many :profile_tags, dependent: :destroy
  has_many :tags, through: :profile_tags
end
