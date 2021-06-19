class Course < ApplicationRecord
  has_many :registrations
  has_many :users, through: :registrations
  has_many :votes, as: :voteable

  validates_uniqueness_of :title
end
