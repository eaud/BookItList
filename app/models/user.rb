class User < ActiveRecord::Base
  has_many :activities, foreign_key: "host_id", dependent: :destroy
  has_many :activity_guests, foreign_key: "guest_id", dependent: :destroy
  has_many :funtimes, through: :activity_guests, source: :activity
  has_many :user_tags, dependent: :destroy
  has_many :tags, through: :user_tags
  validates_presence_of :uid, :name, :token, :image_url, :token_expiration
  validates_uniqueness_of :uid, :email

  def self.new_from_oauth(auth)
    user = User.new
    user.uid = auth.uid
    user.name = auth.info.name
    user.email = auth.info.email
    user.image_url = auth.info.image
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


end
