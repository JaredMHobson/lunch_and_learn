class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true
  validates :api_key, uniqueness: true
  validates_presence_of :password
  has_secure_password

  before_create :generate_api_key


  def generate_api_key
    self.api_key = SecureRandom.hex(20)
  end
end
