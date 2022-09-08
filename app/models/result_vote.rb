class ResultVote < ApplicationRecord
    belongs_to :post_content
    belongs_to :user
end
