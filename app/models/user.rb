class User < ApplicationRecord

  #callback: make the email lowercase before saving to DB so that we can enforce the
  #uniqueness of emails (DB thinks different cases are different emails)
  before_save { self.email = email.downcase }

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
  validates :password, presence: true, length: { minimum: 6 }

end
