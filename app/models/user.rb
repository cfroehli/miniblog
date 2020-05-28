# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  validates :username,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 1, maximum: 20 },
            format: /\A[a-zA-Z0-9_\.]+\z/
  validates :profile, length: { maximum: 200 }
  validates :blog_url,
            allow_blank: true,
            format: %r{\A(https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9]+\.[^\s]{2,}|www\.[a-zA-Z0-9]+\.[^\s]{2,})\z} # rubocop:disable Layout/LineLength

  has_many :posts, dependent: :destroy

  has_many :followers_link, class_name: 'Follow', foreign_key: 'followee_id', inverse_of: :followee, dependent: :destroy
  has_many :followers, through: :followers_link

  has_many :followees_link, class_name: 'Follow', foreign_key: 'follower_id', inverse_of: :follower, dependent: :destroy
  has_many :followees, through: :followees_link

  # Shortcut to access followed users posts
  has_many :followed_posts, through: :followees, source: :posts

  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post

  has_many :comments, dependent: :destroy

  attr_writer :login

  def login
    @login || username || email
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).find_by(['lower(username) = :value OR lower(email) = :value', { value: login.downcase }])
  end
end
