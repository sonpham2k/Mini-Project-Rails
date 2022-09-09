class PostContent < ApplicationRecord
    belongs_to :post
    has_many :result_votes
end
