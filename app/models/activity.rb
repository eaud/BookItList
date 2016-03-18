class Activity < ActiveRecord::Base
  belongs_to :host, class_name: "User"
  has_many :activity_tags, dependent: :destroy
  has_many :tags, through: :activity_tags
  has_many :activity_guests, dependent: :destroy
  has_many :guests, through: :activity_guests, class_name: "User"
  has_one :chat, dependent: :destroy

  scope :not_hosted_by, ->(user) { where.not(host: user) }
  scope :hosted_by,     ->(user) { where(host: user) }

  scope :open,   -> { where(aasm_state: 'open') }
  scope :closed, -> { where(aasm_state: 'closed') }

  scope :order_by_most_recent, ->  { order('activities.updated_at DESC') }

  validates_presence_of :host_id, :name, :details, :cost, :guest_min, :guest_max
  validates :guest_max, numericality: {:greater_than_or_equal_to => :guest_min}
  validates :cost, numericality: {greater_than_or_equal_to: 0}
  validates :guest_max, numericality: {greater_than_or_equal_to: 1}
  validates :guest_min, numericality: {greater_than_or_equal_to: 1}
  validate :date_is_in_the_future

  include AASM

  aasm do
    state :open, :initial => true
    state :closed
    state :deleted

    event :close do
      transitions :from => :open, :to => :closed
    end

    event :reopen do
      transitions :from => :closed, :to => :open
    end

    event :soft_delete do
      transitions :from => [:open, :closed], :to => :deleted
    end

  end

  def date_is_in_the_future
    if datetime.present? && datetime < Date.today
      errors.add(:datetime, "stop living in the past.")
    end
  end

  def interested_guests
    activity_guests.liked.flat_map(&:guest)
  end

  def approved_guests
    activity_guests.approved.flat_map(&:guest)
  end

end
