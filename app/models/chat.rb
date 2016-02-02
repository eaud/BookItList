class Chat < ActiveRecord::Base
  belongs_to :activity
  has_many :chat_users
  has_many :users, through: :chat_users
  has_many :messages

  validates_presence_of :name
  validates_uniqueness_of :activity_id
end
