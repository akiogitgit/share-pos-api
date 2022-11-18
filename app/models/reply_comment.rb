class ReplyComment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def as_json(options={})
    super(
      include: [
        user: {only: [:id, :username]},
      ]
    )
  end
end
