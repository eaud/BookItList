class ActivityGuest < ActiveRecord::Base
  belongs_to :activity
  belongs_to :guest, class_name: "User"
  validates_presence_of :activity_id, :guest_id
  include AASM

  aasm do
    state :unseen, :initial => true
    state :disliked
    state :liked
    state :denied
    state :approved

    event :like do
      transitions :from => :unseen, :to => :liked
    end

    event :dislike do
      transitions :from => :unseen, :to => :disliked
    end

    event :approve do
      transitions :from => :liked, :to => :approved
    end

    event :deny do
      transitions :from => :liked, :to => :denied
    end
  end


end
