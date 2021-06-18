class Course < ApplicationRecord
  has_many :registrations
  has_many :users, through: :registrations

  validates_uniqueness_of :title
end
