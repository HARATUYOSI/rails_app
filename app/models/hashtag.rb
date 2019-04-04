class Hashtag < ApplicationRecord
  validates :name, uniqueness: true
  has_many :microposts
  has_many :micropost_hashtags
  has_many :hashtag_microposts, through: :micropost_hashtags, source: :micropost
end
