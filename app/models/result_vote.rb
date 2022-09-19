class ResultVote < ApplicationRecord
  belongs_to :post_content
  belongs_to :user

  acts_as_paranoid
end
