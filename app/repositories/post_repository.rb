module PostRepository
  class PostRepository
    include BaseRepository

    def search(search, page)
      Post.reorder("id DESC").search(search).paginate(page: page, :per_page => 12)
    end

    def validate_attr(object, field)
      object.valid_attributes?(field)
    end

    def save_not_validate(object)
      object.save(:validate => false)
    end
  end
end
