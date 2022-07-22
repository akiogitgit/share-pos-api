class Post < ApplicationRecord
  belongs_to :user
  has_many :folders, through: :folder_post_relations
  has_many :folder_post_relations
  # belongs_to :meta_info
  has_one :meta_info
  
  validates :url, presence: true, format: /\A#{URI::regexp(%w(http https))}\z/
  validates :user_id, presence: true
  
  def as_json(options={})
    super(
      # include: [user: { only: [:username] }]
      # include: [:meta_info]
      include: [user: {only: [:username]}, meta_info: {inclue: :meta_info}]
      include: [user: {inclue: :meta_info}, meta_info: {inclue: :meta_info}]
    )
  end
end
