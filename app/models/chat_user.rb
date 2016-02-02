class ChatUser < ActiveRecord::Base
  belongs_to :chat
  belongs_to :user

  validates_presence_of :chat_id, :user_id, :host
  validates :chat, uniqueness: {scope: :user_id}
  include AASM

  aasm do
    state :unread, :initial => true
    state :read


    event :view do
      transitions :from => :unread, :to => :read
    end

  end


end
