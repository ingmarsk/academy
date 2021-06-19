class Registration < ApplicationRecord
  belongs_to :user
  belongs_to :course

  validates_presence_of :user_id
  validates_presence_of :course_id
  # Same user cannot register the same course twice
  validates_uniqueness_of :course_id, scope: :user_id
end
