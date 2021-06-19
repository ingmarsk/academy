class Course < ApplicationRecord
  has_many :registrations, dependent: :destroy
  has_many :users, through: :registrations
  has_many :votes, as: :voteable

  validates :title, presence: true, uniqueness: true

  default_scope { order(created_at: :desc) }
end
