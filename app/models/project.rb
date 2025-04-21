class Project < ApplicationRecord
  has_many :project_users
  has_many :users, through: :project_users
  has_many :updates, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :name, presence: true, allow_blank: false

  enum status: [:active, :inactive]
end
