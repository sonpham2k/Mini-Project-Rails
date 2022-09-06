class Post < ApplicationRecord
    has_many :result_vote
    has_many :post_content
    has_many :comment
    belongs_to :user

    validates :title, presence: true, length: { maximum: 255 }
    validates :user_id, presence: true
end
