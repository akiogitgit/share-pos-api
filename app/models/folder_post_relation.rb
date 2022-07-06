class FolderPostRelation < ApplicationRecord
  belongs_to :folder
  belongs_to :post
end
