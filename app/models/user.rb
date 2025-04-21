class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :project_users
  has_many :projects, through: :project_users
  has_many :updates, dependent: :destroy
  has_many :comments, dependent: :destroy
end
