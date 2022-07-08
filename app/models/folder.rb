class Folder < ApplicationRecord
  belongs_to :user
  has_many :posts, through: :folder_post_relations
  has_many :folder_post_relations, dependent: :delete_all
end
