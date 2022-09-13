class Post < ApplicationRecord
  has_many :post_contents
  has_many :comments
  belongs_to :user

  validates :title, presence: true, length: { maximum: 255 }
  validates :user_id, presence: true

  def self.search(search)
    if search
      return Post.where("title like ?", "%#{search}%")
    end
    Post.all
  end
end
