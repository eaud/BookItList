class Activity < ActiveRecord::Base
  belongs_to :host, class_name: "User"
  has_many :activity_tags, dependent: :destroy
  has_many :tags, through: :activity_tags
  has_many :activity_guests, dependent: :destroy
  has_many :guests, through: :activity_guests, class_name: "User"
  has_one :chat, dependent: :destroy
  validates_presence_of :host_id, :name, :details, :cost, :guest_min, :guest_max
  validates :guest_max, numericality: {:greater_than_or_equal_to => :guest_min}
  validates :cost, numericality: {greater_than_or_equal_to: 0}
  validates :guest_max, numericality: {greater_than_or_equal_to: 1}
  validates :guest_min, numericality: {greater_than_or_equal_to: 1}
  validate :date_is_in_the_future, on: :create

  def date_is_in_the_future
    if datetime.present? && datetime < Date.today
      errors.add(:datetime, "stop living in the past.")
    end
  end

  def interested_guests
    activity_guests = ActivityGuest.where(activity_id: self.id, aasm_state: "liked")
    guests = activity_guests.map do |activity_guest|
      activity_guest.guest
    end
    guests
  end

  def approved_guests
    activity_guests = ActivityGuest.where(activity_id: self.id, aasm_state: "approved")
    guests = activity_guests.map do |activity_guest|
      activity_guest.guest
    end
    guests
  end

end
