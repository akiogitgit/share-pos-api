class Post < ApplicationRecord
  belongs_to :user
  has_many :folders, through: :folder_post_relations
  has_many :folder_post_relations, dependent: :destroy
  has_one :meta_info, dependent: :destroy
  
  validates :url, presence: true, format: /\A#{URI::regexp(%w(http https))}\z/
  validates :user_id, presence: true
  
  # 全ての返すpostのデータに、user.username, meta_infoを付ける
  def as_json(options={})
    super(
      include: [user: {only: [:id, :username]}, meta_info: {only: [:image, :title]}]
    )
  end
end
