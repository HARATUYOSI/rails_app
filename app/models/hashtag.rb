class Hashtag < ApplicationRecord
  validates :name, uniqueness: true
  has_many :microposts, through: :micropost_hashtags
  has_many :micropost_hashtags
  has_many :tag_microposts, through: :micropost_hashtags, source: :micropost
end
