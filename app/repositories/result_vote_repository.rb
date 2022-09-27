module ResultVoteRepository
  class ResultVoteRepository
    include BaseRepository

    def delete(object, items)
      ResultVote.destroy(items)
    end
  end
end
