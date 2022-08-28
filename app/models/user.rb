class User < ApplicationRecord
    has_many :active_relationships, class_name: 'Relationship',
                                    foreign_key: 'follower_id',
                                    dependent: :destroy
    has_many :passive_relationships, class_name: 'Relationshi',
                                    foreign_key: 'followed_id',
                                    dependent: :destroy
    has_many :following, through: :active_relationships, source: :followed
    has_many :followers, through: :passive_relationships, source: :follower
    has_many :comment
    has_many :post
    has_many :result_vote
    has_many :relationships, :foreign_key => "follower_id",
                       :dependent => :destroy
    has_secure_password

    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

    def User.new_token
        SecureRandom.urlsafe_base64
    end

    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end

    # Returns true if the given token matches the digest.
    def authenticated?(attribute, token)
        digest = send("#{attribute}_digest")
        return false if digest.nil?
        BCrypt::Password.new(digest).is_password?(token)
    end
end
