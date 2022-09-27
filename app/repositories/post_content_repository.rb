module PostContentRepository
  class PostContentRepository
    include BaseRepository

    def delete(object, items)
        PostContent.destroy(items)
    end
  end
end
