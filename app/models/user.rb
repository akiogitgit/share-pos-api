# frozen_string_literal: true

class User < ActiveRecord::Base
  has_secure_password
  has_secure_token
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :validatable
  # include DeviseTokenAuth::Concerns::User
  validates :email, uniqueness: true

  has_many :posts # delete_allはいらない
  has_many :folders, dependent: :delete_all
end
