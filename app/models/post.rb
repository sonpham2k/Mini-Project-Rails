class Post < ApplicationRecord
    has_many :result_vote
    has_many :post_content
    has_many :comment
    belongs_to :user
end
