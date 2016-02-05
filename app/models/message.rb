class Message < ActiveRecord::Base
  belongs_to :chat
  belongs_to :sender, class_name: "User"

  validates_presence_of :chat_id, :sender_id, :content
end
