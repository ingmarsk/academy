require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  should belong_to(:voteable)

  should validate_presence_of(:voteable_type)
  should validate_presence_of(:voteable_id)
  should validate_presence_of(:user_id)

  test 'should have a valid factory for user' do
    assert user_vote.valid?
  end

  test 'should have a valid factory for course' do
    assert user_vote.valid?
  end

  private

  def user_vote
    @user_vote ||= create(:user_vote)
  end

  def course_vote
    @course_vote ||= create(:course_vote)
  end
end
