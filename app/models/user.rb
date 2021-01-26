class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  mount_uploader :image, ImageUploader
  has_secure_password
  
  has_many :microposts, dependent: :destroy
  has_many :practices, dependent: :destroy
  
  has_many :relationships, dependent: :destroy
  has_many :followings, through: :relationships, source: :follow, dependent: :destroy
  
  has_many :favorites, dependent: :destroy
  has_many :likes, through: :favorites, source: :micropost, dependent: :destroy
  
  
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  def favorite(other_micropost)
    self.favorites.find_or_create_by(micropost_id: other_micropost.id)
  end

  def unfavorite(other_micropost)
    favorite = self.favorites.find_by(micropost_id: other_micropost.id)
    favorite.destroy if favorite
  end

  def favorite?(other_micropost)
    self.likes.include?(other_micropost)
  end
end