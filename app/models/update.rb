class Update < ApplicationRecord
  belongs_to :project
  belongs_to :user

  scope :not_reply, -> { where(type: [nil, 'Comment']) }
end
