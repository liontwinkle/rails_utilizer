class User < ApplicationRecord
  has_many :train_searches

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
end
