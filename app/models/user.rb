class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :registrations
  has_many :courses, through: :registrations

  validates_uniqueness_of :email
end
