class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # validates :name, :email, presence: true
  validates :email, uniqueness: true

  validates :password, :password_confirmation, presence: true, on: :create
  validates :password, confirmation: true
  has_many :likes, dependent: :destroy
  has_many :blogs
  has_many :comments
  has_many :following_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :following_relationships, source: :followed
  
  has_many :follower_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :follower_relationships, source: :follower

  def following?(other_user)
    following.exists?(id: other_user.id)
  end
  
  def followed_users?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end
  
  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end
  
  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end

  def follow(other_user)
    following_relationships.create(followed_id: other_user.id)
  end
  def unfollow(other_user)
    following_relationships.find_by(followed_id: other_user.id).destroy
  end
  def followers_count
    followers.count
  end
end
