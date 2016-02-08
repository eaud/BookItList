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
    state :removed

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

    event :remove do
      transitions :from => :approved, :to => :removed
    end
  end

  def self.approved_activity_guests(host, guest)
    host.activities.map do |activity|
      ActivityGuest.where(activity: activity, guest: guest)[0] if activity.approved_guests.include?(guest)
    end.compact
  end

  def self.interested_activity_guests(host, guest)
    host.activities.map do |activity|
      ActivityGuest.where(activity: activity, guest: guest)[0] if activity.interested_guests.include?(guest)
    end.compact
  end
end
