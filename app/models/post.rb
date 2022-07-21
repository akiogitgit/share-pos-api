class Post < ApplicationRecord
  belongs_to :user
  has_many :folders, through: :folder_post_relations
  has_many :folder_post_relations
  
  validates :url, presence: true
  validates :user_id, presence: true
  
  def as_json(options={})
    super(
      include: [user: { only: [:username] }]
    )
  end
end
