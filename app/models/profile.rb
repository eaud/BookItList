class Profile < ActiveRecord::Base
  belongs_to :user
  has_many :profile_tags, dependent: :destroy
  has_many :tags, through: :profile_tags
  validates_presence_of :user_id # :first_name, :last_name, :bio
end
