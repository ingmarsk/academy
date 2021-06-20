require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should have_many(:courses)
  should have_many(:registrations)
  should have_many(:votes)

  should validate_presence_of(:email)

  test 'should have a valid factory' do
    assert user.valid?
  end

  test 'should have a unique email' do
    user.save
    assert_raises ActiveRecord::RecordInvalid do
      create(:user, email: user.email)
    end
  end

  test 'should register multiple courses' do
    2.times do
      user.courses.create(title: Faker::Educator.course_name)
    end

    assert_equal 2, user.courses.length
  end

  test 'should not register same course twice' do
    2.times do
      user.registrations.create(course: course)
    end

    assert_equal 1, user.courses.length
    assert_equal course.id, user.courses.first.id
  end

  test 'should be voted by other users' do
    second_user = create(:user)
    third_user = create(:user)

    [second_user, third_user].each do |other_user|
      Vote.create(voteable: user, user_id: other_user.id)
    end

    assert_equal 2, user.votes.length
  end

  test 'should vote himself just once' do
    assert_difference 'Vote.count', 1 do
      2.times do
        Vote.create(voteable: user, user_id: user.id)
      end
    end
    assert_equal 1, user.votes.length
  end

  test 'should vote for another user just once' do
    another_user = create(:user)
    assert_difference 'Vote.count', 1 do
      2.times do
        Vote.create(voteable: another_user, user_id: user.id)
      end
    end
    assert_equal 1, another_user.votes.length
  end

  test 'should vote for same course just once' do
    assert_difference 'Vote.count', 1 do
      2.times do
        Vote.create(voteable: course, user_id: user.id)
      end
    end
    assert_equal 1, course.votes.length
  end

  private

  def user
    @user ||= create(:user)
  end

  def course
    @course ||= create(:course)
  end
end
