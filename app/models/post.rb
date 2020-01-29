class Post < ApplicationRecord
  validates :content, length: { maximum: 140 }
  belongs_to :user

  has_many :likes
  has_many :liking_users, through: :likes, source: :user, dependent: :destroy

  has_many :comments, dependent: :destroy

  mount_uploader :featured_image, FeaturedImageUploader

  def self.with_username
    joins(:user).select('posts.*, users.username as user_name')
  end
end
