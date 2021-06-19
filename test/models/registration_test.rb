require 'test_helper'

class RegistrationTest < ActiveSupport::TestCase
  should belong_to(:user)
  should belong_to(:course)

  should validate_presence_of(:user_id)
  should validate_presence_of(:course_id)

  test 'should have a valid factory' do
    assert registration.valid?
  end

  private

  def registration
    @registration ||= create(:registration)
  end
end
