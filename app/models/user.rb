class User < ApplicationRecord
  has_secure_password
  has_secure_token
  
  has_many :post, dependent: :destroy

  validates :username, presence: true
  validates :nickname, presence: true
end
