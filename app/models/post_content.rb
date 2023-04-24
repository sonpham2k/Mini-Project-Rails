class PostContent < ApplicationRecord
    belongs_to :post
    has_many :result_votes, dependent: :destroy

    acts_as_paranoid
end
