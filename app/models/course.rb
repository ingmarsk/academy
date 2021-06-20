class Course < ApplicationRecord
  has_many :registrations, dependent: :destroy
  has_many :users, through: :registrations
  has_many :votes, as: :voteable

  validates :title, presence: true, uniqueness: true

  default_scope -> { left_joins(:votes).group('courses.id').order('count(votes.id) desc') }
end
