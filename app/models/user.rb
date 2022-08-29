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

    validates :name, presence: true, length: { maximum: 255 }, on: :create
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email,   presence: true, 
                        format: { with: VALID_EMAIL_REGEX },
                        uniqueness: true
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
    
    has_secure_password

    # validates :password, comparison: { equal_to: :confirm_password }

    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

    def User.new_token
        SecureRandom.urlsafe_base64
    end

    def add_error_current_password(is_object)
        if is_object == false
            errors.add(:current_password, " fail")
        end
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

    # Forgets a user.
    def forget
        update_attribute(:remember_digest, nil)
    end

     # Sets the password reset attributes.
    def create_reset_digest
        self.reset_token = User.new_token
        update_attribute(:reset_digest, User.digest(reset_token))
        update_attribute(:reset_sent_at, Time.zone.now)
    end

    # Sends activation email.
    def send_activation_email
        UserMailer.account_activation(self).deliver_now
    end
end
