class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  validates :username, presence: :true, uniqueness: { case_sensitive: false }, length: { minimum: 1, maximum: 20 }
  validates :profile, length: { maximum: 200 }
  validates_format_of :blog_url, allow_blank: true, with: /(https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9]+\.[^\s]{2,}|www\.[a-zA-Z0-9]+\.[^\s]{2,})/
  validates_format_of :username, with: /[a-zA-Z0-9_\.]+/

  has_many :posts, dependent: :destroy

  has_many :followers_link, class_name: 'Follow', foreign_key: 'followee_id'
  has_many :followers, through: :followers_link, dependent: :destroy

  has_many :followees_link, class_name: 'Follow', foreign_key: 'follower_id'
  has_many :followees, through: :followees_link, dependent: :destroy

  # Shortcut to access followed users posts
  has_many :followed_posts, through: :followees, source: :posts

  has_many :likes
  has_many :liked_posts, through: :likes, source: :post, dependent: :destroy

  has_many :comments, dependent: :destroy

  attr_writer :login

  def login
    @login || self.username || self.email
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { value: login.downcase }]).first
    else
      if conditions[:username].nil?
        where(conditions).first
      else
        where(username: conditions[:username]).first
      end
    end
  end
end
