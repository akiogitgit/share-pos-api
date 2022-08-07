class Post < ApplicationRecord
  belongs_to :user
  has_many :folders, through: :folder_post_relations
  has_many :folder_post_relations
  has_one :meta_info, dependent: :destroy
  
  validates :url, presence: true, format: /\A#{URI::regexp(%w(http https))}\z/
  validates :user_id, presence: true
  
  # 全ての返すpostのデータに、user.username id, meta_infoを付ける
  def as_json(options={})
    super(
      include: [user: {only: [:username, :id]}, meta_info: {only: [:image, :title]}]
    )
  end
end
