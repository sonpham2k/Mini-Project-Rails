class Comment < ApplicationRecord
  include ActionView::Helpers::DateHelper
  
  belongs_to :user
  belongs_to :post

  acts_as_paranoid

  def count_time_comment
    return distance_of_time_in_words(self.created_at + 7.hours, Time.utc(*Time.new.to_a))
  end
end
