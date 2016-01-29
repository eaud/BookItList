class Tag < ActiveRecord::Base
  has_many :user_tags, dependent: :destroy
  has_many :users, through: :tags
  has_many :activity_tags, dependent: :destroy
  has_many :activities, through: :activity_tags
  validates_presence_of :name
end
