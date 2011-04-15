require 'digest/sha1'

class User < ActiveRecord::Base
  has_many :votes

  validates :username, :hashed_password, :presence => true
  validates :username, :email, :uniqueness => true
  validates :email, :format => { :with => /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i }

  attr_accessor :password_confirmation
  validates_confirmation_of :password

  validate :password_non_blank

  def password
    @password
  end

  def password=(pwd)
    @password = pwd
    return if pwd.blank?
    self.hashed_password = User.encrypt_password(self.password, create_new_salt)
  end

  def self.authenticate(username, password)
    user = self.find_by_username(username)
    if user
      expected_password = encrypt_password(password, read_salt(user.hashed_password, password.length))
      user = nil unless user.hashed_password == expected_password
    end
    user
  end

private

  def password_non_blank
    errors.add(:password, "Missing password") if hashed_password.blank?
  end

  def self.encrypt_password(password, salt)
    string_to_hash = password + "random" + salt
    encrypted_password = Digest::SHA1.hexdigest(string_to_hash)
    # Insert the salt into the hashed password for saving
    # Insertion point is determined by the length of the user's password
    index = (password.length > 40)? 40 : password.length
    return encrypted_password.insert(index, salt)
  end

  # Create salt as a SHA1 so it is a fixed length, and it blends in with the hashed_password
  def create_new_salt
    return Digest::SHA1.hexdigest(self.object_id.to_s + rand.to_s)
  end

  # Read the salt from the hashed_password
  def self.read_salt(hashed_password, password_length)
    index = (password_length > 40)? 40 : password_length
    return hashed_password[index..index+39]
  end
end
