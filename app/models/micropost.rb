class Micropost < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites
  has_many :favorite_users, through: :favorites, source: :user
  has_many :micropost_hashtags, dependent: :destroy
  has_many :hashtags, through: :micropost_hashtags, source: :hashtag
  
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate :picture_size

  def already_favorited?(user_id)
    self.favorites.exists?(user_id: user_id)
  end

  def favorite(user)
    favorites.create(user_id: user.id)
  end

  def unfavorite(user)
    favorites.find_by(user_id: user.id).destroy
  end
  
  def favorite?(user)
    favorite_users.include?(user)
  end

  def save_hashtag
    hashtags = self.content.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    hashtags.uniq.map do |hashtag|
      tag = Hashtag.find_or_create_by(name: hashtag.delete('#'))
      self.hashtags << tag
    end
  end


  private
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end