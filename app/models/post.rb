class Post < ApplicationRecord
  has_many :post_contents, dependent: :destroy
  has_many :comments, dependent: :destroy
  belongs_to :user

  validates :title, presence: true, length: { maximum: 255 }
  validates :user_id, presence: true

  acts_as_paranoid

  def self.search(search)
    if search
      return Post.where("title like ?", "%#{search}%")
    end
    Post.all
  end

  class << self
    def import_file file
      spreadsheet = Roo::Spreadsheet.open file
      header = spreadsheet.row(1)
      posts = []
      (2..spreadsheet.last_row).each do |i|
        row = [header, spreadsheet.row(i)].transpose.to_h
        post = new row
        posts << post
      end
      import! posts
    end
  end

end
