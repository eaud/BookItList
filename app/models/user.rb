class User < ActiveRecord::Base
  has_many :activities, foreign_key: "host_id", dependent: :destroy
  has_many :activity_guests, foreign_key: "guest_id", dependent: :destroy
  has_many :funtimes, through: :activity_guests, source: :activity
  has_many :user_tags, dependent: :destroy
  has_many :tags, through: :user_tags
  has_many :chat_users
  has_many :chats, through: :chat_users
  validates_presence_of :uid, :name, :token, :image_url, :token_expiration
  validates_uniqueness_of :uid, :email

  def self.new_from_oauth(auth)
    user = User.new
    user.uid = auth.uid
    user.name = auth.info.name
    user.email = auth.info.email
    user.image_url = auth.info.image + "?type=large"
    user.token = auth.credentials.token
    user.token_expiration = Time.at(auth.credentials.expires_at)
    user.save
    user
  end

  def self.find_or_create_from_oauth(auth)
    if user = self.find_by(uid: auth.uid)
      user.update(token: auth.credentials.token, token_expiration: Time.at(auth.credentials.expires_at))
      user
    else
      self.new_from_oauth(auth)
    end
  end

  def unshown_activities
    activities =  Activity.where.not(host: self)
    unshown_activities = activities.map do |activity|
        activity if (!self.funtimes.include?(activity)  && activity.host != self)
    end.compact
    unshown_activities
  end

  def unseen_activity_guests
    current_user_AGs = ActivityGuest.where(guest_id: self.id, aasm_state: "unseen")
    current_user_AGs
  end

  def fresh_activities
    fresh_activities = self.funtimes.map do |funtime|
      funtime if funtime.activity_guests.where(guest: self)[0].aasm_state == "unseen"
    end.compact
    fresh_activities
  end

  def generate_activity_guests(num)
    new_activity_guests = self.unshown_activities[0..num].each do |unshown|
      ActivityGuest.create(guest_id: self.id, activity_id: unshown.id)
    end
    new_activity_guests
  end


end
