class UserRelation < ApplicationRecord
  # User同士のリレーションだから、特殊 class_nameで、そのテーブルから参照してる
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
end
