class User < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :result_votes, dependent: :destroy
  has_many :relationships, :foreign_key => "follower_id",
                           :dependent => :destroy

  validates :name, presence: true, length: { maximum: 255 }, on: :create
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  has_one_attached :avatar
  validate :validate_avatar
  validate :add_error_current_password, on: :update, if: :password_changed?
  validate :add_error_confirm_password, on: :update, if: :password_changed?

  has_secure_password
  acts_as_paranoid

  CSV_ATTRIBUTES = %w(name email created_at updated_at deleted_at).freeze

  def self.as_csv
    attributes = %w(name email created_at updated_at deleted_at)
    CSV.generate do |csv|
      csv << attributes
      all.each do |item|
        csv << item.attributes.values_at(*attributes)
      end
    end
  end

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

  def self.search(search)
    if search
      users = User.where("name like ?", "%#{search}%")
    else
      User.all
    end
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def add_error_current_password
    if ($params[:id] != nil)
      if User.find($params[:id]).authenticate(password_params[:current_password]) == false
        errors.add(:current_password, " fail")
      end
    end
  end

  def add_error_confirm_password
    if password_params[:password] != password_params[:password_confirmation]
      errors.add(:password_confirmation, " don't match password")
    end
  end

  def password_changed?
    !password_params[:current_password].blank?
    !password_params[:password].blank?
    !password_params[:password_confirmation].blank?
  end

  def validate_avatar
    if $params[:user][:avatar] && $params[:user][:avatar].size > 5000000
      errors.add(:avatar, "larger capacity 5MB")
    end
    if $params[:user][:avatar] && !([".png", ".jpg", ".jpeg", ".gif"].include? File.extname($params[:user][:avatar].original_filename))
      errors.add(:avatar, "errors type file")
    end
  end

  def get_params
    if defined?($params)
      return $params
    end
  end

  def password_params
    $params.require(:user).permit :current_password, :password, :password_confirmation
  end
end
