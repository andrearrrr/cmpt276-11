class User < ApplicationRecord
  has_many :picks

  #setting up relationship for friendships
  has_many :active_relationships,   class_name:   "Relationship",
                                    foreign_key:  "follower_id",
                                    dependent:    :destroy
  has_many :passive_relationships, class_name:    "Relationship",
                                   foreign_key:   "followed_id",
                                   dependent:     :destroy
  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  ##functions for friendships##
  #friends other_user (1 direction)
  def friend(other_user)
    self.following << other_user
  end

#unfriends the other_user (1 direction)
  def unfriend(other_user)
    self.following.delete(other_user)
  end

#Returns true if current user is friends with other_user (1 direction)
  def friends?(other_user)
    self.following.include?(other_user)
  end

  def mutualfriends?(other_user)
    self.following.include?(other_user) && self.followers.include?(other_user)
  end



  attr_accessor :remember_token, :activation_token
  #callback: make the email lowercase before saving to DB so that we can enforce the
  #uniqueness of emails (DB thinks different cases are different emails)
  before_save   :downcase_email
  #before creating a user, assign account activation stuff (and email them)
  before_create :create_activation_digest

  #regular expression/regex for emails (format of name@example.com)
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  #validates that the email is present, of correct length, and matches
  #regex. Validates that it's unique, but does not care about case
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  #validates that the length of name is appropriate and is present
  validates :name,  presence: true, length: { maximum: 50 }

  has_secure_password

  #password must exist and be at least 6 characters
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true



  #Why is this repeated again???

  #user.remember method
  #attr_accessor :remember_token
  #  before_save { self.email = email.downcase }
  #  validates :name,  presence: true, length: { maximum: 50 }
  #  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  #  validates :email, presence: true, length: { maximum: 255 },
  #                    format: { with: VALID_EMAIL_REGEX },
  #                    uniqueness: { case_sensitive: false }
  #  has_secure_password
  #  validates :password, presence: true, length: { minimum: 6 }




    # Returns the hash digest of the given string.
    def User.digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    # Returns a random token.
    def User.new_token
      SecureRandom.urlsafe_base64
    end

    # Remembers a user in the database for use in persistent sessions.
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

    # Activates an account.
    def activate
      update_columns(activated: true, activated_at: Time.zone.now)
    end

    # Sends activation email.
    def send_activation_email
      UserMailer.account_activation(self).deliver_now
    end

    # PRIVATE THINGS

    private

    # Converts email to all lower-case.
    def downcase_email
      self.email = email.downcase
    end

    # Creates and assigns the activation token and digest.
    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end

end
