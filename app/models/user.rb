class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :registrations, dependent: :destroy
  has_many :courses, through: :registrations
  has_many :votes, as: :voteable

  validates :email, presence: true, uniqueness: true
end
