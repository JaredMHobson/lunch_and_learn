class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :api_key, uniqueness: true
  validates :password, presence: true
  has_secure_password

  has_many :favorites

  before_create :generate_api_key


  def generate_api_key
    self.api_key = SecureRandom.hex(20)
  end
end
