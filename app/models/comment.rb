class Comment < Update
  belongs_to :user
  belongs_to :project
  has_many :replies, dependent: :destroy

  validates :message, presence: true
end
