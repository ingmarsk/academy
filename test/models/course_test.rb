require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  should have_many(:users)
  should have_many(:registrations)
  should have_many(:votes)

  should validate_presence_of(:title)

  test 'should have a valid factory' do
    assert course.valid?
  end

  test 'should have a unique title' do
    course.save
    assert_raises ActiveRecord::RecordInvalid do
      create(:course, title: course.title)
    end
  end

  test 'could be registered by many users' do
    assert_difference 'Registration.count', 2 do
      2.times do
        user = create(:user)
        user.registrations.create(course: course)
      end
    end

    assert_equal 2, course.users.size
  end

  test 'could be voted by many users' do
    second_user = create(:user)

    [user, second_user].each do |other_user|
      Vote.create(voteable: course, user_id: other_user.id)
    end

    assert_equal 2, course.votes.size
  end

  test 'should be voted by same user just once' do
    assert_difference 'Vote.count', 1 do
      2.times do
        Vote.create(voteable: course, user_id: user.id)
      end
    end

    assert_equal 1, course.votes.size
  end

  private

  def user
    @user ||= create(:user)
  end

  def course
    @course ||= create(:course)
  end
end
