class Post < ApplicationRecord
  validates :content, length: { maximum: 140 }
  belongs_to :user

  has_many :likes
  has_many :liking_users, through: :likes, source: :user, dependent: :destroy

  has_many :comments, dependent: :destroy
end
