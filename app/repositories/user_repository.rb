module UserRepository
  class UserRepository
    include BaseRepository

    def attach_avatar(user, params)
      user.avatar.attach(params)
    end

    def find_by_email(valid)
      User.find_by(email: valid)
    end

    def find_by_reset_digest(valid)
      User.find_by(reset_digest: valid)
    end
  end
end
