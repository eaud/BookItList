class Chat < ActiveRecord::Base
  belongs_to :activity
  has_many :chat_users, dependent: :destroy
  has_many :users, through: :chat_users
  has_many :messages, dependent: :destroy

  validates_presence_of :name
  validates :activity_id, uniqueness: true, if: 'activity_id.present?'

end
