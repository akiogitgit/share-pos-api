class Post < ApplicationRecord
  belongs_to :user
  has_many :folders, through: :folder_post_relations
  has_many :folder_post_relations, dependent: :destroy
  has_one :meta_info, dependent: :destroy
  has_many :reply_comments, dependent: :destroy
  
  validates :url, presence: true, format: /\A#{URI::regexp(%w(http https))}\z/
  validates :user_id, presence: true
  
  # 返されるpostに、user.username, meta_info, reply_comments を付ける
  # reply_commentsのuserも返し、reply_comments事態もonlyで絞る

  # 全て返すなら、:reply_comments
  # include: [:reply_comments, :user, meta_info: {only: [:image, :title]}]

  def as_json(options={})
    super(
      include: [
        reply_comments: {
          include: [user: {only: [:id, :username]}],
          only: [:id, :body]
        },
        user: {only: [:id, :username]},
        meta_info: {only: [:image, :title]}
      ]
    )
  end
end
