class Reply < Update
  belongs_to :comment
  validates :comment_id, :message, presence: true
end