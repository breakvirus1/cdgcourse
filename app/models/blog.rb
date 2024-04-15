class Blog < ApplicationRecord
    
    validates_presence_of :title, :body
    validates :user_id, presence: true
    has_many :comments, dependent: :destroy
    belongs_to :user
    has_many :likes, dependent: :destroy
    has_one_attached :image do |attachable|
        attachable.variant :display, resize_to_limit: [500, 500]
        end
       
    validates :image, content_type: { in: %w[image/jpeg image/gif image/png], message: "must be a valid image format" }, size: { less_than: 5.megabytes, message: "should be less than5MB" }

end
