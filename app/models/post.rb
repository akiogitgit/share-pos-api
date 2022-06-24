class Post < ApplicationRecord
  belongs_to :user
  
  validates :url, presence: true
  validates :user_id, presence: true
end
